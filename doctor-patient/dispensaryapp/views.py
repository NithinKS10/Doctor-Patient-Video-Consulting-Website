
import ast
import csv
from io import BytesIO
import json
from django.db import connection
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.shortcuts import get_object_or_404, render
from django.urls import reverse
import qrcode
# Create your views here.
from django.shortcuts import render,redirect
from django.contrib import messages
from django.contrib.auth import authenticate
from django.contrib.auth import logout
import joblib
import pandas as pd
from dispensaryapp.models import *
from django.core.files.storage import FileSystemStorage
from django.conf import settings
import os
from datetime import date,time
from email.message import EmailMessage
import smtplib
import ssl
import random
from django.http import JsonResponse
from django.conf import settings
import logging
from django.http import JsonResponse
from django.conf import settings
import logging
from django.http import JsonResponse
from django.conf import settings
from twilio.jwt.access_token import AccessToken
from twilio.jwt.access_token.grants import VideoGrant
from django.views.decorators.csrf import csrf_exempt
from django.core.exceptions import PermissionDenied
from cryptography.fernet import Fernet
from django.contrib.auth.hashers import make_password
import re

from dispensaryapp.utils import get_diet, get_medications, get_precautions, get_workout,  predict_disease
cipher_suite = Fernet(settings.SECRET_KEY.encode())

logger = logging.getLogger(__name__)


def encrypt_data(data):
    # Convert data to string if necessary and encode it
    data_bytes = str(data).encode()
    # Encrypt data
    encrypted_data = cipher_suite.encrypt(data_bytes)
    # Return encrypted data as a string
    return encrypted_data.decode()

def decrypt_data(encrypted_data):
    # Decode the encrypted data and decrypt it
    decrypted_data = cipher_suite.decrypt(encrypted_data.encode())
    # Return decrypted data as a string
    return decrypted_data.decode()
# Create your views here.
def index(request):
    return render(request,'index.html')
def hospital_registration(request):
    data = State.objects.all()
  
    return render(request,'hospital_registration.html',{'data':data})
def patient_registration(request):
    today1 = date.today()
    data = State.objects.all()
    return render(request,'patient_registration.html',{'data':data,'today':today1})
def sign_in(request):
    return render(request,'signin.html')
def sign_in_process(request):
    u=request.POST.get("username")
    p=request.POST.get("password")
    obj=authenticate(username=u,password=p)
    if obj is not None:
        if obj.is_superuser == 1:
            request.session['aname'] = u
            request.session['slogid'] = obj.id
            return redirect('/admin_home/')
        else:
          messages.add_message(request, messages.INFO, 'Invalid User.')
          return redirect('/index/')
    else:
        newp=make_password(p,salt='mySalt')
        try:
            obj1=Login.objects.get(username=u,password=newp)

            if obj1.Usertype=="Lab":
                if(obj1.status=="Approved"):
                    request.session['lname'] = u
                    request.session['slogid'] = obj1.login_id
                    return redirect('/lab_home/')
                elif(obj1.status=="Not Approved"):
                  messages.add_message(request, messages.INFO, 'Waiting For Approval.')
                  return redirect('/login/')
                else:
                  messages.add_message(request, messages.INFO, 'Invalid User.')
                  return redirect('/login/')
            elif obj1.Usertype=="Doctor":
                if(obj1.status=="Approved"):
                    request.session['dname'] = u
                    request.session['slogid'] = obj1.login_id
                    return redirect('/doctor_home/')
                elif(obj1.status=="Not Approved"):
                  messages.add_message(request, messages.INFO, 'Waiting For Approval.')
                  return redirect('/login/')
                else:
                  messages.add_message(request, messages.INFO, 'Invalid User.')
                  return redirect('/login/')
            elif obj1.Usertype=="Patient":
                if(obj1.status=="Approved"):
                    request.session['pname'] = u
                    request.session['slogid'] = obj1.login_id
                    return redirect('/patient_home/')
                elif(obj1.status=="Not Approved"):
                  messages.add_message(request, messages.INFO, 'Waiting For Approval.')
                  return redirect('/login/')
                else:
                  messages.add_message(request, messages.INFO, 'Invalid User.')
                  return redirect('/login/')
            elif obj1.Usertype=="Receptionist":
                if(obj1.status=="Approved"):
                    request.session['cname'] = u
                    request.session['slogid'] = obj1.login_id
                    return redirect('/receptionist_home/')
                elif(obj1.status=="Not Approved"):
                  messages.add_message(request, messages.INFO, 'Waiting For Approval.')
                  return redirect('/login/')
                else:
                  messages.add_message(request, messages.INFO, 'Invalid User.')
                  return redirect('/login/')

            else:
                 messages.add_message(request, messages.INFO, 'Invalid User.')
                 return redirect('/login/')
        except Login.DoesNotExist:
         messages.add_message(request, messages.INFO, 'Invalid User.')
         return redirect('/login/')
def admin_home(request):
    if 'aname' in request.session:
     return render(request,'Master/index.html')
    else:
      return redirect('/index/')
def lab_home(request):
    if 'lname' in request.session:
     return render(request,'Lab/index.html')
    else:
      return redirect('/index/')
def doctor_home(request):
    if 'dname' in request.session:
     return render(request,'Doctor/index.html')
    else:
      return redirect('/index/')
def patient_home(request):
    if 'pname' in request.session:
        logid=request.session['slogid']
        d=Patients.objects.get(login_id=logid)
        cursor=connection.cursor()
        cursor.execute("select m.speciality,d.doctor_first_name,d.doctor_last_name,d.qualification,d.photo from  tbl_medical_speciality as m inner join   tbl_doctor as d on m.medical_speciality_id =d.medical_speciality_id")
        data=cursor.fetchall()
 
       
        return render(request,'Patient/index.html',{'data':data,'d':d})
    else:
        return redirect('/index/')
    

def admin_logout(request):
    logout(request)
    request.session.delete()
    return redirect('/index/')
def user_logout(request):
    logout(request)
    request.session.delete()
    return redirect('/index/')
# def hospital_action(request):
#     username=request.POST.get("username")
#     password=request.POST.get("password")
#     data = {
#        'username_exists':      Login.objects.filter(username=username).exists(),
#         'error':"Username Already Exist"
#     }
#     if(data["username_exists"]==False):
#         tbl1=Login()
#         username=request.POST.get("username")
#         tbl1.username=request.POST.get("username")
#         password=request.POST.get("password")
#         tbl1.password=request.POST.get("password")
#         tbl1.Usertype="Hospital"
#         tbl1.status="Not Approved"
#         tbl1.save()
#         obj=Login.objects.get(username=username,password=password)

#         u=Hospital()
#         u.login_id = obj.login_id
#         u.hospital=request.POST.get("hospital")
#         u.address =request.POST.get("address")
#         u.email=request.POST.get("email")
#         u.phone_number=request.POST.get("phone_number")
#         u.district_id=request.POST.get("district")
#         u.place=request.POST.get("place")

#         u.save()
#         messages.add_message(request, messages.INFO, 'Registered successfully.')
#         return redirect('/hospital_registration/')
#     else:
#         messages.add_message(request, messages.INFO, 'Username already exist.. Try Again.')
#         return redirect('/hospital_registration/')
def patient_action(request):
    username=request.POST.get("username")
    password=make_password(request.POST.get("password"),salt='mySalt')
    data = {
       'username_exists':      Login.objects.filter(username=username).exists(),
        'error':"Username Already Exist"
    }
    if(data["username_exists"]==False):
        tbl1=Login()
        username=request.POST.get("username")
        tbl1.username=request.POST.get("username")
       
        tbl1.password=password
        tbl1.Usertype="Patient"
        tbl1.status="Submitted"
        tbl1.save()
        obj=Login.objects.get(username=username,password=password)

        u=Patients()
        u.login_id = obj.login_id
        u.patient_name=request.POST.get("patient_name")
        u.Address =request.POST.get("address")
        u.email=request.POST.get("email")
        u.phone_number=request.POST.get("phone_number")
        u.district_id=request.POST.get("district")
        u.place=request.POST.get("place")
        u.dob=request.POST.get("dob")
        u.save()
       
        return redirect('/otp_verification/'+str(obj.login_id))
    else:
        messages.add_message(request, messages.INFO, 'Username already exist.. Try Again.')
        return redirect('/patient_registration/')
def display_district(request):
    state_id = request.GET.get("state_id")
    try:

        dist = District.objects.filter(state_id = state_id)
    except Exception:
        data=[]
        data['error_message'] = 'error'
        return JsonResponse(data)
    return JsonResponse(list(dist.values('district_id', 'district')), safe = False)

def check_username(request):
    username = request.GET.get("username")
    data = {
       'username_exists':      login.objects.filter(username=username).exists(),
        'error':"Username Already Exist"
    }
    if(data["username_exists"]==False):
        data["success"]="Available"

    return JsonResponse(data)
# Approval
def approve_hospital(request):
   if 'aname' in request.session:
        cursor=connection.cursor()
        cursor.execute("select p.*,s.state,d.district from  tbl_hospital as p inner join   tbl_district as d on p.district_id =d.district_id inner join tbl_state as s on d.state_id=s.state_id  where p.login_id in (select login_id from tbl_login where Usertype='hospital' and status='Not Approved')")
        data=cursor.fetchall()
        return render(request,'Master/approve_hospital.html',{'data':data})
   else:
       return redirect('/index/')
def approve(request,id):
    if 'aname' in request.session:
        tbl=Login.objects.get(login_id=id)
        tbl.status="Approved"
        tbl.save()
        messages.add_message(request, messages.INFO, 'Updated successfully.')
        return redirect('/approve_hospital/')
    else:
       return redirect('/index/')
def reject(request,id):
    if 'aname' in request.session:
        tbl=Login.objects.get(login_id=id)
        tbl.status="Rejected"
        tbl.save()
        messages.add_message(request, messages.INFO, 'Rejected successfully.')
        return redirect('/approve_hospital/')
    else:
        return redirect('/login')

def hospital_list(request):
   if 'aname' in request.session:
            cursor=connection.cursor()
            cursor.execute("select p.*,s.state,d.district from  tbl_hospital as p inner join   tbl_district as d on p.district_id =d.district_id inner join tbl_state as s on d.state_id=s.state_id  where p.login_id in (select login_id from tbl_login where Usertype='hospital' and status='Approved')")
            data=cursor.fetchall()
            return render(request,'Master/approved_hospital.html',{'data':data})
   else:
        return redirect('/login')
   
def Complaint_frm(request):
    if 'pname' in request.session:
        logid=request.session['slogid']
        data1 = Complaint.objects.filter(user_login_id=logid)
        return render(request,'Patient/complaint.html',{'data1':data1})
    else:
       return redirect('/index/')
def save_complaint(request):
    if 'pname' in request.session:
        tbl=Complaint()
        tbl.user_login_id=request.session['slogid']
        # tbl.complaint_subject=request.POST.get("subject")
        tbl.complaint=request.POST.get("complaint")
        tbl.reply="No"
        tbl.save()
        messages.add_message(request, messages.INFO, 'Added successfully.')
        return redirect('/add_complaint/')
    else:
       return redirect('/index/')

def delete_complaint(request,id):
    if 'pname' in request.session:
        tbl=Complaint.objects.get(complaint_id=id)
        tbl.delete()
        messages.add_message(request, messages.INFO, 'Deleted successfully.')
        return redirect('/add_complaint/')
    else:
       return redirect('/index/')


def feedback_frm(request):
    if 'pname' in request.session:
        logid=request.session['slogid']
        data1 = Feedback.objects.filter(user_login_id=logid)
        return render(request,'Patient/feedback.html',{'data1':data1})
    else:
       return redirect('/index/')
def save_feedback(request):
    if 'pname' in request.session:
        tbl=Feedback()
        tbl.user_login_id=request.session['slogid']
        # tbl.feedback_subject=request.POST.get("subject")
        tbl.feedback=request.POST.get("feedback")
        tbl.reply="No"
        tbl.save()
        messages.add_message(request, messages.INFO, 'Added successfully.')
        return redirect('/feedback')
    else:
       return redirect('/index/')

def delete_feedback(request,id):
    if 'pname' in request.session:
        tbl=Feedback.objects.get(feedback_id=id)
        tbl.delete()
        messages.add_message(request, messages.INFO, 'Deleted successfully.')
        return redirect('/feedback')
    else:
       return redirect('/index/')

    # ----------------Admin Complaint -------------
def view_complaints(request):
    if 'aname' in request.session:
        cursor=connection.cursor()
        cursor.execute("select c.*,u.* from  tbl_complaint  as c inner join  tbl_patient as u  on c.user_login_id =u.login_id where c.reply='No'  order by c.complaint_id desc")
        data=cursor.fetchall()
        return render(request,'Master/view_complaints.html',{'data':data})
    else:
       return redirect('/index/')
def replied_list(request):
    if 'aname' in request.session:
        cursor=connection.cursor()
        cursor.execute("select c.*,u.* from  tbl_complaint  as c inner join  tbl_patient as u  on c.user_login_id =u.login_id where c.reply!='No' order by c.complaint_id desc")
        data=cursor.fetchall()
        return render(request,'Master/replied_complaints.html',{'data':data})
    else:
       return redirect('/index/')
def adm_reply_complaint(request,id):
    if 'aname' in request.session:

        return render(request,'Master/reply_complaint.html',{'id':id})
    else:
       return redirect('/index/')
def add_reply(request,id):
    tbl=Complaint.objects.get(complaint_id=id)
    tbl.reply=request.POST.get("reply")
    tbl.save()
    return redirect('/replied_list')


# Admin feedback

def view_feedback(request):
    if 'aname' in request.session:
        cursor=connection.cursor()
        cursor.execute("select c.*,u.* from  tbl_feedback  as c inner join  tbl_patient as u  on c.user_login_id =u.login_id where c.reply='No'  order by c.feedback_id desc")
        data=cursor.fetchall()
        return render(request,'Master/view_feedback.html',{'data':data})
    else:
       return redirect('/index/')
def feedback_replied_list(request):
    if 'aname' in request.session:
        cursor=connection.cursor()
        cursor.execute("select c.*,u.* from  tbl_feedback  as c inner join  tbl_patient as u  on c.user_login_id =u.login_id where c.reply!='No' order by c.feedback_id desc")
        data=cursor.fetchall()
        return render(request,'Master/replied_feedback.html',{'data':data})
    else:
       return redirect('/index/')
def adm_reply_feedback(request,id):
    if 'aname' in request.session:

        return render(request,'Master/reply_feedback.html',{'id':id})
    else:
       return redirect('/index/')
def add_reply_feedback(request,id):
    tbl=Feedback.objects.get(feedback_id=id)
    tbl.reply=request.POST.get("reply")
    tbl.save()
    return redirect('/feedback_replied_list')

#Doctor

def add_doctor(request):
    if 'aname' in request.session:
        data = State.objects.all()
        data2 = MedicalSpeciality.objects.all()
        return render(request,'Master/add_doctor.html',{'data':data,'data2':data2})
    else:
       return redirect('/login/')
def save_doctor(request):
    username=request.POST.get("username")
    password=request.POST.get("password")
    data = {
       'username_exists':      Login.objects.filter(username=username).exists(),
        'error':"Username Already Exist"
    }
    if(data["username_exists"]==False):
        logid=  request.session['slogid']
        tbl1=Login()

        tbl1.username=request.POST.get("username")
        password=make_password(password,salt='mySalt')
        tbl1.password=password
        tbl1.Usertype="Doctor"
        tbl1.status="Approved"
        tbl1.save()
        obj=Login.objects.get(username=username,password=password)

        u=Doctor()
        u.login_id = obj.login_id
       
        u.doctor_first_name=request.POST.get("doctor_first_name")
        u.doctor_last_name=request.POST.get("doctor_last_name")
        u.medical_speciality_id=request.POST.get("medical_speciality_id")
        u.address =request.POST.get("address")
        u.email=request.POST.get("email")
        u.phone_number=request.POST.get("phone_number")
        u.district_id=request.POST.get("district")
        u.place=request.POST.get("place")
        u.qualification=request.POST.get("qualification")
        photo=request.FILES['photo']
      
        split_tup = os.path.splitext(photo.name)
        file_extension = split_tup[1]
        # folder path
        dir_path = settings.MEDIA_ROOT
        count = 0
        # Iterate directory
        for path in os.listdir(dir_path):
        # check if current path is a file
            if os.path.isfile(os.path.join(dir_path, path)):
                count += 1
        filecount=count+1
        filename=str(filecount)+"."+file_extension
        obj=FileSystemStorage()
        file=obj.save(filename,photo)
        url1=obj.url(file)
        u.photo=url1
       
        u.save()
        messages.add_message(request, messages.INFO, 'Added successfully.')
        return redirect('/add_doctor/')
    else:
        messages.add_message(request, messages.INFO, 'Username already exist.. Try Again.')
        return redirect('/add_doctor/')
def doctor_list(request):
    if 'aname' in request.session:
           
            cursor=connection.cursor()
            cursor.execute("select p.*,s.state,d.district from  tbl_doctor as p inner join   tbl_district as d on p.district_id =d.district_id inner join tbl_state as s on d.state_id=s.state_id")
            data=cursor.fetchall()
            return render(request,'Master/doctor_list.html',{'data':data})
    else:
        return redirect('/login')
def edit_doctor(request,id):
 if 'aname' in request.session:
    data=Doctor.objects.get(doctor_id=id)
    data1 = State.objects.all()
    data2 = MedicalSpeciality.objects.all()
    return render(request,'Master/edit_doctor.html',{'data':data,'data1':data1,'data2':data2})
 else:
      return redirect('/index/')
def update_doctor(request,id):
 if 'aname' in request.session:
    u=Doctor.objects.get(doctor_id=id)

   
    u.doctor_first_name=request.POST.get("doctor_first_name")
    u.doctor_last_name=request.POST.get("doctor_last_name")
    u.medical_speciality_id=request.POST.get("medical_speciality_id")
    u.address =request.POST.get("address")
    u.email=request.POST.get("email")
    u.phone_number=request.POST.get("phone_number")
    u.place=request.POST.get("place")
    u.qualification=request.POST.get("qualification")
    if len(request.FILES) != 0:
        photo=request.FILES['photo']

        split_tup = os.path.splitext(photo.name)
        file_extension = split_tup[1]
        # folder path
        dir_path = settings.MEDIA_ROOT
        count = 0
        # Iterate directory
        for path in os.listdir(dir_path):
        # check if current path is a file
            if os.path.isfile(os.path.join(dir_path, path)):
                count += 1
        filecount=count+1
        filename=str(filecount)+"."+file_extension
        obj=FileSystemStorage()
        file=obj.save(filename,photo)
        url1=obj.url(file)
        u.photo=url1
    u.save()
    messages.add_message(request, messages.INFO, 'Updated successfully.')
    return redirect('/doctor_list/')
 else:
      return redirect('/index/')
def delete_doctor(request,id):
 if 'aname' in request.session:
    tbl=Doctor.objects.get(doctor_id=id)
    logid=tbl.login_id
    tbl2=Login.objects.get(login_id=logid)
    tbl2.delete()
    tbl3=Doctor.objects.get(doctor_id=id)
    tbl3.delete()
    messages.add_message(request, messages.INFO, 'Deleted successfully.')
    return redirect('/doctor_list/')
 else:
      return redirect('/index/')
 
# Insurance

def add_insurance(request):
    if 'aname' in request.session:
        logid=  request.session['slogid']
        data = Insurance.objects.all()
        return render(request,'Master/add_insurance.html',{'data':data})
    else:
       return redirect('/index/')
def save_insurance(request):
    if 'aname' in request.session:
        c=request.POST.get("insuarnce_company")
     
        data = {
       'exists':      Insurance.objects.filter(insuarnce_company=c).exists(),
        'error':"Already Exist"
        }
        if(data["exists"]==False):  
          
            u=Insurance()
     
            u.insuarnce_company=request.POST.get("insurance_company")    
            u.description=request.POST.get("description")          
            u.save()
            messages.add_message(request, messages.INFO, 'Added successfully.')
            return redirect('/add_insurance/')
        else:
           messages.add_message(request, messages.INFO, 'Failed..  insurance has been already added ')
           return redirect('/add_insurance/')
    else:
       return redirect('/index/')

def edit_insurance(request,id):
 if 'aname' in request.session:
    data=Insurance.objects.get(insurance_id=id)
    return render(request,'Master/edit_insurance.html',{'data':data})
 else:
      return redirect('/index/')
def update_insurance(request,id):
 if 'aname' in request.session:
    u=Insurance.objects.get(insurance_id=id)
    u.insuarnce_company=request.POST.get("insurance_company")    
    u.description=request.POST.get("description")      
    u.save()
    messages.add_message(request, messages.INFO, 'Updated successfully.')
    return redirect('/add_insurance/')
 else:
      return redirect('/index/')
def delete_insurance(request,id):
 if 'aname' in request.session:
    tbl=Insurance.objects.get(insurance_id=id)
    tbl.delete()
    messages.add_message(request, messages.INFO, 'Deleted successfully.')
    return redirect('/add_insurance/')
 else:
      return redirect('/index/')
 
def appointment(request):
    if 'pname' in request.session:
        
        data = MedicalSpeciality.objects.all()
        return render(request,'Patient/appointment.html',{'data':data})
    else:
        return redirect('/index/')
def display_speciality(request):
        cursor=connection.cursor()
        cursor.execute("select m.medical_speciality_id,m.speciality from  tbl_medical_speciality as m inner join   tbl_doctor as d on m.medical_speciality_id =d.medical_speciality_id inner join tbl_hospital as h on h.login_id=d.hospital_login_id")
        data=cursor.fetchall()
        count=1
        str1="<option value="">--Select--</option>"
        for k in data:
            str1+="<option value="+str(k[0])+">"+str(k[1])+"</option>"        
        return HttpResponse(str1)


def display_doctor(request):
    medical_speciality_id = request.GET.get("medical_speciality_id")
 
    try:

        dist = Doctor.objects.filter(medical_speciality_id = medical_speciality_id)
    except Exception:
        data=[]
        data['error_message'] = 'error'
        return JsonResponse(data)
    return JsonResponse(list(dist.values('login_id', 'doctor_first_name', 'doctor_last_name')), safe = False)
def save_appointment(request):
    if 'pname' in request.session:
                        
        u=Appointment()
        logid=  request.session['slogid']
        u.patient_login_id = logid
        u.doctor_login_id=request.POST.get("doctor")    
        u.appointment_date=request.POST.get("appointment_date")          
        u.save()
        messages.add_message(request, messages.INFO, 'Added successfully.')
        return redirect('/appointment/')
  
    else:
       return redirect('/index/')
def history(request):
    if 'pname' in request.session:
        logid=  request.session['slogid']
        cursor=connection.cursor()
        cursor.execute("select  a.appointment_date,a.entry_date,d.doctor_first_name,d.doctor_last_name,m.speciality,a.appointment_id,a.pay_status,a.fee,a.status from tbl_appointment as a inner join   tbl_doctor as d on a.doctor_login_id =d.login_id  inner join tbl_medical_speciality as m  on m.medical_speciality_id=d.medical_speciality_id   where a.patient_login_id="+str(logid))
        data=cursor.fetchall()
        return render(request,'Patient/appointment_list.html',{'data':data})
    else:
        return redirect('/index/')
def display_hospital_list(request):
        district_id = request.GET.get("district_id")
        cursor=connection.cursor()
        cursor.execute("select h.* from  tbl_hospital as h inner join tbl_login as l on h.login_id=l.login_id where district_id="+str(district_id)+" and l.status='Approved'")
        data=cursor.fetchall()
        count=1
        str1="<table class='table table-bordered'>  <thead><th>Id</th><th>Hospital</th><th>Address</th><th>Email</th><th>Phone Number</th><th>Place</th></thead>"
        count=1
        for k in data:
            str1+="<tr><td>"+str(count)+"<td>"+str(k[2])+"</td><td>"+str(k[3])+"</td><td>"+str(k[4])+"</td><td>"+str(k[5])+"</td><td>"+str(k[7])+"</td><td><a href='/doctors/"+str(k[1])+"' class='btn btn-info'>Doctors</a></td>"
                            
            count=count+1
                            

        str1+="</table>"                
        return HttpResponse(str1)
def doctors(request,id):
    if 'pname' in request.session:
      
        cursor=connection.cursor()
        cursor.execute("select d.*,h.* from  tbl_doctor as d inner join  tbl_medical_speciality as h  on h.medical_speciality_id=d.medical_speciality_id")
        data1=cursor.fetchall()
        return render(request,'Patient/doctors.html',{'data1':data1,'data':data})
    else:
        return redirect('/index/')
def insurance(request,id):
    if 'pname' in request.session:
        data = Insurance.objects.all()
       
        return render(request,'Patient/insurance.html',{'data':data})
    else:
        return redirect('/index/')
def patient_profile(request):
    if 'pname' in request.session:
        logid=  request.session['slogid']
        data = Patients.objects.get(login_id =logid)
        return render(request,'Patient/profile.html',{'data':data})
    else:
        return redirect('/index/')
def update_profile(request,id):
    u=Patients.objects.get(patient_id=id)
    u.patient_name=request.POST.get("patient_name")
    u.Address =request.POST.get("address")
    u.phone_number=request.POST.get("phone_number")
    u.place=request.POST.get("place")
    u.dob=request.POST.get("dob") 
    u.save()
    messages.add_message(request, messages.INFO, 'Updated successfully.')
    return redirect('/patient_profile/')

def patient_change_password(request):
    if 'pname' in request.session:

        return render(request,'Patient/change_password.html')
    else:
       return redirect('/index/')
def update_password(request):
    if 'pname' in request.session:
        id=request.session['slogid']
        opass=request.POST.get("opassword")
        npass=request.POST.get("password")
        obj1=Login.objects.filter(login_id=id,password=opass)
        if(obj1):
            tbl1=Login.objects.get(login_id=id)
            tbl1.password=npass
            tbl1.save()
            messages.add_message(request, messages.INFO, 'Updated Please Login Using new Password.')
            return redirect('/login/')
        else:
            messages.add_message(request, messages.INFO, 'Invalid Data')
            return redirect('/patient_change_password/')
    else:
       return redirect('/index/')
def patient_list(request):
    if 'aname' in request.session:
        logid=request.session['slogid']
        cursor=connection.cursor()
        cursor.execute("select distinct p.* from tbl_appointment as a inner join   tbl_doctor as d on a.doctor_login_id =d.login_id  inner join tbl_medical_speciality as m  on m.medical_speciality_id=d.medical_speciality_id inner join tbl_patient as p on p.login_id=a.patient_login_id")
        data=cursor.fetchall()
        likm={}
        for i in data:
           d = i[7]
           id=i[0]
           y=d.strftime("%Y")
           m=d.strftime("%m")
           day=d.strftime("%d")        
           age =calculate_age(int(day),int(m),int(y))
           likm[id]=age
        return render(request,'Master/patient_list.html',{'data':data,'likm':likm})
    else:
       return redirect('/index/')
def calculate_age(day, month, year):
    # we are getting the current date using the today()
    today = date.today()
    # convering year, month and day into birthdate
    birthdate = date(year, month, day)
    # calculating the age 
    age = today.year - birthdate.year - ((today.month, today.day) < (birthdate.month, birthdate.day))
    # return the age value
    return age
def appointment_list(request):
    if 'aname' in request.session:
        logid=request.session['slogid']
        today = datetime.date.today()
        cursor=connection.cursor()
        cursor.execute("select  p.*,d.doctor_first_name,d.doctor_last_name,d.photo,m.speciality,a.appointment_date,a.time from tbl_appointment as a inner join   tbl_doctor as d on a.doctor_login_id =d.login_id  inner join tbl_medical_speciality as m  on m.medical_speciality_id=d.medical_speciality_id inner join tbl_patient as p on p.login_id=a.patient_login_id   where  a.appointment_date>="+str(today))
        data=cursor.fetchall()
        likm={}
        for i in data:
           d = i[7]
           id=i[0]
           y=d.strftime("%Y")
           m=d.strftime("%m")
           day=d.strftime("%d")        
           age =calculate_age(int(day),int(m),int(y))
           likm[id]=age
        return render(request,'Master/appointment_list.html',{'data':data,'likm':likm})
    else:
       return redirect('/index/')
def appointment_approval(request):
    if 'dname' in request.session:
        today = datetime.date.today()
        logid=request.session['slogid']
        cursor=connection.cursor()
        query="select p.*,d.doctor_first_name,d.doctor_last_name,d.photo,m.speciality,a.appointment_date, a.appointment_id from tbl_appointment as a inner join   tbl_doctor as d on a.doctor_login_id =d.login_id  inner join tbl_medical_speciality as m  on m.medical_speciality_id=d.medical_speciality_id inner join tbl_patient as p on p.login_id=a.patient_login_id   where a.status='Not Consulted' and  a.doctor_login_id="+str(logid)+" and a.appointment_date>='"+str(today)+"'"
        cursor.execute(query)
        data=cursor.fetchall()
        likm={}
        for i in data:
           d = i[7]
           id=i[0]
           y=d.strftime("%Y")
           m=d.strftime("%m")
           day=d.strftime("%d")        
           age =calculate_age(int(day),int(m),int(y))
           likm[id]=age
        return render(request,'Doctor/appointment_approval.html',{'data':data,'likm':likm})
    else:
       return redirect('/index/')

def new_appointment(request):
    if 'dname' in request.session:
        today = datetime.date.today()
        logid=request.session['slogid']
        cursor=connection.cursor()
        query="select p.*,d.doctor_first_name,d.doctor_last_name,d.photo,m.speciality,a.appointment_date, a.appointment_id,a.time from tbl_appointment as a inner join   tbl_doctor as d on a.doctor_login_id =d.login_id  inner join tbl_medical_speciality as m  on m.medical_speciality_id=d.medical_speciality_id inner join tbl_patient as p on p.login_id=a.patient_login_id   where a.status='Accepted' and  a.doctor_login_id="+str(logid)+" and a.appointment_date='"+str(today)+"'"
        cursor.execute(query)
        data=cursor.fetchall()
        likm={}
        for i in data:
           d = i[7]
           id=i[0]
           y=d.strftime("%Y")
           m=d.strftime("%m")
           day=d.strftime("%d")        
           age =calculate_age(int(day),int(m),int(y))
           likm[id]=age
        return render(request,'Doctor/appointment_list.html',{'data':data,'likm':likm})
    else:
       return redirect('/index/')
    
def search_by_op(request):
    if 'dname' in request.session:
        today = datetime.date.today()
        op=request.POST.get("op")
        logid=request.session['slogid']
        cursor=connection.cursor()
        query="select p.*,d.doctor_first_name,d.doctor_last_name,d.photo,m.speciality,a.appointment_date, a.appointment_id,a.time from tbl_appointment as a inner join   tbl_doctor as d on a.doctor_login_id =d.login_id  inner join tbl_medical_speciality as m  on m.medical_speciality_id=d.medical_speciality_id inner join tbl_patient as p on p.login_id=a.patient_login_id   where a.status='Accepted' and  a.doctor_login_id="+str(logid)+" and a.appointment_date='"+str(today)+"' and p.patient_id="+str(op)
        cursor.execute(query)
        data=cursor.fetchall()
        likm={}
        for i in data:
           d = i[7]
           id=i[0]
           y=d.strftime("%Y")
           m=d.strftime("%m")
           day=d.strftime("%d")        
           age =calculate_age(int(day),int(m),int(y))
           likm[id]=age
        return render(request,'Doctor/appointment_list.html',{'data':data,'likm':likm})
    else:
       return redirect('/index/')
def add_prescription(request,id):
    if 'dname' in request.session:
        data = Lab.objects.all()
        return render(request,'Doctor/add_prescription.html',{'id':id,'data':data})
    else:
       return redirect('/index/')
def save_prescription(request,id):
    if 'dname' in request.session:
        tbl=prescription()
    
        tbl.appointment_id=id
        tbl.visiting_date=request.POST.get("visiting_date")
        tbl.symptoms=encrypt_data(request.POST.get("symptoms"))
        tbl.medicine=encrypt_data(request.POST.get("medicine"))
        tbl.uses=encrypt_data(request.POST.get("uses"))
        tbl.details=encrypt_data(request.POST.get("details"))
       
        tbl.save()
     
        li=request.POST.getlist("test_type")
        for i in li:
            tbl2=lab_test()
            tbl2.appointment_id=id
            tbl2.test_id=i
            tbl2.save()

        tbl1=Appointment.objects.get(appointment_id=id)
        tbl1.status="Consulted"
        tbl1.fee=request.POST.get("fee")
        
        tbl1.save()
        messages.add_message(request, messages.INFO, 'Added successfully.')
        return redirect('/new_appointment/')
    else:
       return redirect('/index/')
def all_appointment_list(request):
    if 'dname' in request.session:
        
        logid=request.session['slogid']
        cursor=connection.cursor()
        query="select  p.*,d.doctor_first_name,d.doctor_last_name,d.photo,m.speciality,a.appointment_date,a.appointment_id from tbl_appointment as a inner join   tbl_doctor as d on a.doctor_login_id =d.login_id  inner join tbl_medical_speciality as m  on m.medical_speciality_id=d.medical_speciality_id inner join tbl_patient as p on p.login_id=a.patient_login_id   where a.status='Consulted' and  a.doctor_login_id="+str(logid)
        cursor.execute(query)
        data=cursor.fetchall()
        likm={}
        for i in data:
           d = i[7]
           id=i[0]
           y=d.strftime("%Y")
           m=d.strftime("%m")
           day=d.strftime("%d")        
           age =calculate_age(int(day),int(m),int(y))
           likm[id]=age
        return render(request,'Doctor/all_appointment_list.html',{'data':data,'likm':likm})
    else:
       return redirect('/index/')



def view_prescription(request, id):
    if 'dname' in request.session:
        cursor = connection.cursor()

        # Fetch prescription data
        query = "SELECT * FROM tbl_prescription WHERE appointment_id=" + str(id)
        cursor.execute(query)
        prescription_data = cursor.fetchall()

        # Decrypt the necessary fields: symptoms, medicine, uses, details
        decrypted_prescription_data = []
        for row in prescription_data:
            decrypted_row = list(row)  # Convert row to a list for easier manipulation

            # Assuming column order: adjust these indices based on actual column positions
            # Symptoms: Index 3, Medicine: Index 4, Uses: Index 5, Details: Index 6
            decrypted_row[3] = decrypt_data(decrypted_row[3])  # Decrypt 'symptoms'
            decrypted_row[4] = decrypt_data(decrypted_row[4])  # Decrypt 'medicine'
            decrypted_row[5] = decrypt_data(decrypted_row[5])  # Decrypt 'uses'
            decrypted_row[6] = decrypt_data(decrypted_row[6])  # Decrypt 'details'

            decrypted_prescription_data.append(decrypted_row)

        # Fetch lab test data (no encryption assumed here)
        query = """
        SELECT * FROM tbl_lab_test 
        INNER JOIN tbl_lab_test_type ON tbl_lab_test.test_id = tbl_lab_test_type.lab_test_type_id 
        INNER JOIN tbl_lab ON tbl_lab.login_id = tbl_lab_test_type.lab_login_id 
        WHERE appointment_id=""" + str(id)
        cursor.execute(query)
        lab_test_data = cursor.fetchall()
        decrypted_lab_data = []
        for row1 in lab_test_data:
            decrypted_row1 = list(row1)
            if row1[3]=='Result is not Prepared':
                decrypted_row1[5] =decrypted_row1[5]
                decrypted_lab_data.append(decrypted_row1)
            else:
                # Convert row to list for easier manipulation
                # Assuming column order: symptoms (index 3), medicine (index 4), uses (index 5), details (index 6)
                decrypted_row1[5] = decrypt_data(decrypted_row1[5])  # Decrypt symptoms
            
                decrypted_lab_data.append(decrypted_row1)

        # Pass decrypted prescription and lab test data to the template
        return render(request, 'Doctor/view_prescription.html', {
            'data': decrypted_prescription_data, 
            'data2': decrypted_lab_data
        })
    else:
        return redirect('/index/')

def dr_view_patient(request):
    if 'dname' in request.session:
        logid=request.session['slogid']
        cursor=connection.cursor()
        query="select distinct p.*,di.district,s.state from tbl_appointment as a inner join   tbl_doctor as d on a.doctor_login_id =d.login_id  inner join tbl_medical_speciality as m  on m.medical_speciality_id=d.medical_speciality_id inner join tbl_patient as p on p.login_id=a.patient_login_id inner join tbl_district as di on p.district_id=di.district_id inner join tbl_state as s on s.state_id=di.state_id   where a.status='Consulted' and  a.doctor_login_id="+str(logid)
        cursor.execute(query)
        data=cursor.fetchall()
        likm={}
        for i in data:
           d = i[7]
           id=i[0]
           y=d.strftime("%Y")
           m=d.strftime("%m")
           day=d.strftime("%d")        
           age =calculate_age(int(day),int(m),int(y))
           likm[id]=age
        return render(request,'Doctor/view_patient.html',{'data':data,'likm':likm})
    else:
       return redirect('/index/')
def dr_view_patient_records(request,id):

    if 'dname' in request.session:
        cursor = connection.cursor()

        # Fetch prescription data
        query = """
        SELECT p.prescription_id, p.appointment_id, p.visiting_date, p.symptoms, p.medicine, p.uses, p.details
        FROM tbl_prescription AS p
        INNER JOIN tbl_appointment AS a ON p.appointment_id = a.appointment_id
        WHERE a.patient_login_id = %s
        """ % (str(id))
        cursor.execute(query)
        prescription_data = cursor.fetchall()

        # Decrypt fields that are encrypted: symptoms, medicine, uses, details
        decrypted_prescription_data = []
        for row in prescription_data:
            decrypted_row = list(row)  # Convert row to list for easier manipulation
            # Assuming column order: symptoms (index 3), medicine (index 4), uses (index 5), details (index 6)
            decrypted_row[3] = decrypt_data(decrypted_row[3])  # Decrypt symptoms
            decrypted_row[4] = decrypt_data(decrypted_row[4])  # Decrypt medicine
            decrypted_row[5] = decrypt_data(decrypted_row[5])  # Decrypt uses
            decrypted_row[6] = decrypt_data(decrypted_row[6])  # Decrypt details

            decrypted_prescription_data.append(decrypted_row)

        # Fetch lab test data (assuming no encryption here)
        query = """
        SELECT *
        FROM tbl_lab_test
        INNER JOIN tbl_lab_test_type ON tbl_lab_test.test_id = tbl_lab_test_type.lab_test_type_id
        INNER JOIN tbl_lab ON tbl_lab.login_id = tbl_lab_test_type.lab_login_id
        INNER JOIN tbl_appointment ON tbl_appointment.appointment_id = tbl_lab_test.appointment_id
        WHERE tbl_appointment.patient_login_id = %s
        """ % (str(id))
        cursor.execute(query)
        lab_test_data = cursor.fetchall()
        decrypted_lab_data = []
        for row1 in lab_test_data:
            decrypted_row1 = list(row1)
            if row1[3]=='Result is not Prepared':
                decrypted_row1[5] = decrypted_row1[5]  # Decrypt symptoms
         
                decrypted_lab_data.append(decrypted_row1)
            else: 
                decrypted_row1[5] = decrypt_data(decrypted_row1[5])  # Decrypt symptoms
         
                decrypted_lab_data.append(decrypted_row1)
              # Convert row to list for easier manipulation
            # Assuming column order: symptoms (index 3), medicine (index 4), uses (index 5), details (index 6)
            
        # Pass the decrypted prescription and lab test data to the template
        return render(request, 'Doctor/view_patient_records.html', {
            'data': decrypted_prescription_data, 
            'data2': decrypted_lab_data
        })
    else:
        return redirect('/index/')
    

# Doctor
def doctor_profile(request):
    if 'dname' in request.session:
        logid=  request.session['slogid']
        data = Doctor.objects.get(login_id =logid)
    
        data1 = State.objects.all()
        data2 = MedicalSpeciality.objects.all()
        return render(request,'Doctor/profile.html',{'data':data,'data1':data1,'data2':data2})
    else:
        return redirect('/index/')
def update_dr_profile(request,id):
    if 'dname' in request.session:
        u=Doctor.objects.get(doctor_id=id)

    
        u.doctor_first_name=request.POST.get("doctor_first_name")
        u.doctor_last_name=request.POST.get("doctor_last_name")
        
        u.address =request.POST.get("address")
        u.email=request.POST.get("email")
        u.phone_number=request.POST.get("phone_number")
        u.place=request.POST.get("place")
        u.qualification=request.POST.get("qualification")
        if len(request.FILES) != 0:
            photo=request.FILES['photo']

            split_tup = os.path.splitext(photo.name)
            file_extension = split_tup[1]
            # folder path
            dir_path = settings.MEDIA_ROOT
            count = 0
            # Iterate directory
            for path in os.listdir(dir_path):
            # check if current path is a file
                if os.path.isfile(os.path.join(dir_path, path)):
                    count += 1
            filecount=count+1
            filename=str(filecount)+"."+file_extension
            obj=FileSystemStorage()
            file=obj.save(filename,photo)
            url1=obj.url(file)
            u.photo=url1
        u.save()
        messages.add_message(request, messages.INFO, 'Updated successfully.')
        return redirect('/doctor_profile/')
    else:
      return redirect('/index/')

def change_password_doctor(request):
    if 'dname' in request.session:

        return render(request,'Doctor/change_password.html')
    else:
       return redirect('/index/')
def update_dr_password(request):
    if 'dname' in request.session:
        id=request.session['slogid']
        opass=request.POST.get("opassword")
        npass=request.POST.get("password")
        obj1=Login.objects.filter(login_id=id,password=opass)
        if(obj1):
            tbl1=Login.objects.get(login_id=id)
            tbl1.password=npass
            tbl1.save()
            messages.add_message(request, messages.INFO, 'Updated Please Login Using new Password.')
            return redirect('/login/')
        else:
            messages.add_message(request, messages.INFO, 'Invalid Data')
            return redirect('/change_password_doctor/')
    else:
       return redirect('/index/')
    

# Speciality

def save_speciality(request):
    if 'aname' in request.session:
        id=request.session['slogid']
        tbl=MedicalSpeciality()
        tbl.speciality=request.POST.get("category")
        tbl.save()
        messages.add_message(request, messages.INFO, 'Added successfully.')
        return redirect('/add_speciality/')
    else:
        return redirect('/login')
def add_speciality(request):
 if 'aname' in request.session:
    data=MedicalSpeciality.objects.all()
    return render(request,'Master/speciality.html',{'data':data})
 else:
      return redirect('/index/')
def edit_speciality(request,id):
 if 'aname' in request.session:
    data=MedicalSpeciality.objects.get(medical_speciality_id=id)
    return render(request,'Master/edit_speciality.html',{'data':data})
 else:
      return redirect('/index/')


def update_speciality(request,id):
 if 'aname' in request.session:
    tbl=MedicalSpeciality.objects.get(medical_speciality_id=id)
    tbl.speciality=request.POST.get("category")
    tbl.save()
    messages.add_message(request, messages.INFO, 'Updated successfully.')
    return redirect('/add_speciality/')
 else:
      return redirect('/index/')
def delete_speciality(request,id):
 if 'aname' in request.session:
    tbl=MedicalSpeciality.objects.get(medical_speciality_id=id)
    tbl.delete()
    messages.add_message(request, messages.INFO, 'Deleted successfully.')
    return redirect('/add_speciality/')
 else:
      return redirect('/index/')
 
def view_prescription_patient(request,id):
    if 'pname' in request.session:
        cursor=connection.cursor()
        query="select  * from tbl_prescription  where  appointment_id="+str(id)
        cursor.execute(query)
        data=cursor.fetchall()
        decrypted_prescription_data = []
        for row in data:
            decrypted_row = list(row)  # Convert row to a list for easier manipulation

            # Assuming column order: adjust these indices based on actual column positions
            # Symptoms: Index 3, Medicine: Index 4, Uses: Index 5, Details: Index 6
            decrypted_row[3] = decrypt_data(decrypted_row[3])  # Decrypt 'symptoms'
            decrypted_row[4] = decrypt_data(decrypted_row[4])  # Decrypt 'medicine'
            decrypted_row[5] = decrypt_data(decrypted_row[5])  # Decrypt 'uses'
            decrypted_row[6] = decrypt_data(decrypted_row[6])  # Decrypt 'details'

            decrypted_prescription_data.append(decrypted_row)

        query="select  tbl_lab_test.*,tbl_lab_test_type.*,tbl_lab.* from tbl_lab_test inner join tbl_lab_test_type on tbl_lab_test.test_id=tbl_lab_test_type.lab_test_type_id inner join  tbl_lab on tbl_lab.login_id=tbl_lab_test_type.lab_login_id   where  appointment_id="+str(id)
        cursor.execute(query)
        data2=cursor.fetchall()



        decrypted_lab_data = []
        for row1 in data2:
            decrypted_row1 = list(row1)
            if row1[3]=='Result is not Prepared':
                decrypted_row1[5] =decrypted_row1[5]
                decrypted_lab_data.append(decrypted_row1)
            else:
                # Convert row to list for easier manipulation
                # Assuming column order: symptoms (index 3), medicine (index 4), uses (index 5), details (index 6)
                decrypted_row1[5] = decrypt_data(decrypted_row1[5])  # Decrypt symptoms
            
                decrypted_lab_data.append(decrypted_row1)

        return render(request,'patient/view_prescription.html',{'data':decrypted_prescription_data,'data2':decrypted_lab_data})
    else:
       return redirect('/index/')
    

# Lab


def add_lab(request):
    if 'aname' in request.session:

        return render(request,'Master/add_lab.html')
    else:
       return redirect('/login/')
def save_lab(request):
    username=request.POST.get("username")
    password=make_password(request.POST.get("password"),salt='mySalt')
    data = {
       'username_exists':      Login.objects.filter(username=username).exists(),
        'error':"Username Already Exist"
    }
    if(data["username_exists"]==False):
      
        tbl1=Login()

        tbl1.username=request.POST.get("username")

        tbl1.password=password
        tbl1.Usertype="Lab"
        tbl1.status="Approved"
        tbl1.save()
        obj=Login.objects.get(username=username,password=password)

        u=Lab()
        u.login_id = obj.login_id
      
        u.name=request.POST.get("name")
        u.address =request.POST.get("address")
        u.email=request.POST.get("email")
        u.phone_number=request.POST.get("phone_number")
        u.place=request.POST.get("place")  
       
        u.save()
        messages.add_message(request, messages.INFO, 'Added successfully.')
        return redirect('/add_lab/')
    else:
        messages.add_message(request, messages.INFO, 'Username already exist.. Try Again.')
        return redirect('/add_lab/')
def lab_details(request):
    if 'aname' in request.session:
           
           
            data=Lab.objects.all()
            return render(request,'Master/lab_details.html',{'data':data})
    else:
        return redirect('/login')
def edit_lab(request,id):
 if 'aname' in request.session:
    
    data=Lab.objects.get(lab_id=id)
    return render(request,'Master/edit_lab.html',{'data':data})
 else:
      return redirect('/index/')
def update_lab(request,id):
 if 'aname' in request.session:
    u=Lab.objects.get(lab_id=id)
    u.name=request.POST.get("name")
    u.address =request.POST.get("address")
    u.email=request.POST.get("email")
    u.phone_number=request.POST.get("phone_number")
    u.place=request.POST.get("place")  
    u.save()
    messages.add_message(request, messages.INFO, 'Updated successfully.')
    return redirect('/lab_details/')
 else:
      return redirect('/index/')
def delete_lab(request,id):
 if 'aname' in request.session:
    tbl=Lab.objects.get(lab_id=id)
    logid=tbl.login_id
    tbl2=Login.objects.get(login_id=logid)
    tbl2.delete()
    tbl3=Lab.objects.get(lab_id=id)
    tbl3.delete()
    messages.add_message(request, messages.INFO, 'Deleted successfully.')
    return redirect('/lab_details/')
 else:
      return redirect('/index/')

def save_test_type(request):
    if 'lname' in request.session:
        id=request.session['slogid']
        tbl=lab_test_type()
        tbl.tests=request.POST.get("test_type")
        tbl.lab_login_id=id
        tbl.save()
        messages.add_message(request, messages.INFO, 'Added successfully.')
        return redirect('/add_test_type/')
    else:
        return redirect('/login')
def add_test_type(request):
 if 'lname' in request.session:
    id=request.session['slogid']
    data=lab_test_type.objects.filter(lab_login_id=id)
    return render(request,'Lab/add_test_type.html',{'data':data})
 else:
      return redirect('/index/')
def edit_test_type(request,id):
 if 'lname' in request.session:
    data=lab_test_type.objects.get(lab_test_type_id=id)
    return render(request,'Lab/edit_test_type.html',{'data':data})
 else:
      return redirect('/index/')


def update_test_type(request,id):
 if 'lname' in request.session:
    tbl=lab_test_type.objects.get(lab_test_type_id=id)
    tbl.tests=request.POST.get("test_type")
    tbl.save()
    messages.add_message(request, messages.INFO, 'Updated successfully.')
    return redirect('/add_test_type/')
 else:
      return redirect('/index/')
def delete_test_type(request,id):
 if 'lname' in request.session:
    tbl=lab_test_type.objects.get(lab_test_type_id=id)
    tbl.delete()
    messages.add_message(request, messages.INFO, 'Deleted successfully.')
    return redirect('/add_test_type/')
 else:
      return redirect('/index/')


def display_lab_type(request):
    lab_id = request.GET.get("lab_login_id")
    try:
        dist = lab_test_type.objects.filter(lab_login_id = lab_id)
    except Exception:
        data=[]
        data['error_message'] = 'error'
        return JsonResponse(data)
    return JsonResponse(list(dist.values('lab_test_type_id', 'tests')), safe = False)

def view_test_list(request):
    if 'lname' in request.session:
        id=request.session['slogid']
        cursor=connection.cursor()
        query="select  * from tbl_lab_test inner join tbl_lab_test_type on tbl_lab_test.test_id=tbl_lab_test_type.lab_test_type_id inner join  tbl_lab on tbl_lab.login_id=tbl_lab_test_type.lab_login_id inner join tbl_appointment  on tbl_appointment.appointment_id=tbl_lab_test.appointment_id inner join tbl_patient on tbl_appointment.patient_login_id=tbl_patient.login_id  where tbl_lab_test.status='Result is not Prepared' and  tbl_lab.login_id="+str(id)
        cursor.execute(query)
        data=cursor.fetchall()
        likm={}
        for i in data:
           d = i[33]
           id=i[0]
           y=d.strftime("%Y")
           m=d.strftime("%m")
           day=d.strftime("%d")        
           age =calculate_age(int(day),int(m),int(y))
           likm[id]=age
        # data=lab_test_type.objects.filter(lab_login_id=id)
        return render(request,'Lab/view_test_list.html',{'data':data,'likm':likm})
    else:
        return redirect('/index/')
def add_test_result(request,id):
 if 'lname' in request.session:

    return render(request,'Lab/add_test_result.html',{'id':id})
 else:
      return redirect('/index/')
def save_test_result(request,id):
    if 'lname' in request.session:
        tbl=lab_test.objects.get(lab_test_id=id)
        tbl.description=encrypt_data(request.POST.get("description"))
        tbl.status="Result is prepared"
        result=request.FILES['result']

        split_tup = os.path.splitext(result.name)
        file_extension = split_tup[1]
        # folder path
        dir_path = settings.MEDIA_ROOT
        count = 0
        # Iterate directory
        for path in os.listdir(dir_path):
        # check if current path is a file
            if os.path.isfile(os.path.join(dir_path, path)):
                count += 1
        filecount=count+1
        filename=str(filecount)+"."+file_extension
        obj=FileSystemStorage()
        file=obj.save(filename,result)
        url1=obj.url(file)
        tbl.result=url1
       
        tbl.save()
        messages.add_message(request, messages.INFO, 'Added successfully.')
        return redirect('/view_test_list/')
    else:
        return redirect('/login')
    
def view_test_result(request):
    if 'lname' in request.session:
        id=request.session['slogid']
        cursor=connection.cursor()
        query="select  * from tbl_lab_test inner join tbl_lab_test_type on tbl_lab_test.test_id=tbl_lab_test_type.lab_test_type_id inner join  tbl_lab on tbl_lab.login_id=tbl_lab_test_type.lab_login_id inner join tbl_appointment  on tbl_appointment.appointment_id=tbl_lab_test.appointment_id inner join tbl_patient on tbl_appointment.patient_login_id=tbl_patient.login_id  where tbl_lab_test.status='Result is prepared' and  tbl_lab.login_id="+str(id)
        cursor.execute(query)
        data=cursor.fetchall()
        likm={}
        decrypted_prescription_data = []
        for row in data:
            decrypted_row = list(row)  # Convert row to list for easier manipulation
            # Assuming column order: symptoms (index 3), medicine (index 4), uses (index 5), details (index 6)
            decrypted_row[5] = decrypt_data(decrypted_row[5])  # Decrypt symptoms
            decrypted_prescription_data.append(decrypted_row)
        for i in data:
           d = i[33]
           id=i[0]
           y=d.strftime("%Y")
           m=d.strftime("%m")
           day=d.strftime("%d")        
           age =calculate_age(int(day),int(m),int(y))
           likm[id]=age
        # data=lab_test_type.objects.filter(lab_login_id=id)
        return render(request,'Lab/view_test_result.html',{'data':decrypted_prescription_data,'likm':likm})
    else:
        return redirect('/index/')
def approve_appointment(request,id):
    if 'dname' in request.session:
        appo= Appointment.objects.get(appointment_id=id)
        app_date=appo.appointment_date
        did=appo.doctor_login_id
    
        appointments = Appointment.objects.filter(appointment_date=app_date,doctor_login_id=did).values_list('time', flat=True)

        excluded_times = list(appointments)

        hours = []

        for hour in range(7, 20):
            for minute in range(0, 60, 10):
                if time(hour, minute) not in excluded_times:
                    if hour < 12:
                        time_str = '{:02d}:{:02d} AM'.format(hour, minute)
                    elif hour == 12:
                        time_str = '12:{:02d} PM'.format(minute)
                    else:
                        time_str = '{:02d}:{:02d} PM'.format(hour - 12, minute)
                    hours.append({'value': '{:02d}:{:02d}'.format(hour, minute), 'display': time_str})
        
        return render(request,'Doctor/approve_appointment.html',{'id':id,'hours': hours,'excluded_times':excluded_times,'app_date':app_date})
    else:
       return redirect('/index/')
def save_approve(request,id):
    if 'dname' in request.session:
        tbl=Appointment.objects.get(appointment_id=id)
        tbl.status="Accepted"
        tbl.time=request.POST.get("time")
        tbl.save()
        messages.add_message(request, messages.INFO, 'Accepted successfully.')
        return redirect('/appointment_approval/')
    else:
       return redirect('/index/')
def reject_appointment(request,id):
    if 'dname' in request.session:
        tbl=Appointment.objects.get(appointment_id=id)
        tbl.status="Rejected"
        tbl.save()
        messages.add_message(request, messages.INFO, 'Rejected successfully.')
        return redirect('/appointment_approval/')
    else:
        return redirect('/login')
 

def appointment_status(request):
    if 'pname' in request.session:
        today = datetime.date.today()
        logid=  request.session['slogid']
        cursor=connection.cursor()
        cursor.execute("select  a.appointment_date,a.entry_date,d.doctor_first_name,d.doctor_last_name,m.speciality,a.appointment_id, a.status,a.time from tbl_appointment as a inner join   tbl_doctor as d on a.doctor_login_id =d.login_id  inner join tbl_medical_speciality as m  on m.medical_speciality_id=d.medical_speciality_id   where a.patient_login_id="+str(logid))
        data=cursor.fetchall()
        return render(request,'Patient/appointment_status.html',{'data':data})
    else:
        return redirect('/index/')
def forget_password(request):
    return render(request,'forget_password.html')

def send_otp(request):
    username=request.POST.get("username")
    email=request.POST.get("email")
    c = Login.objects.filter(username=username,Usertype='Patient').count()
    if(c>0):
        data = Login.objects.get(username=username,Usertype='Patient')
        logid= data.login_id
        data2 = Patients.objects.get(login_id=logid)
        reg_email=data2.email
        if(str(email)==str(reg_email)):
            sub="Your OTP"
            msg=generate_otp(4)
            send_mail(email,msg,sub)
            msg1=msg
            return render(request,'check_otp.html',{'msg':msg1,'logid':logid})
        else:
            messages.add_message(request, messages.INFO, 'This is not your Registered Email Id')
            return redirect('/sign_in/')
    else:
            messages.add_message(request, messages.INFO, 'Invalid User name')
            return redirect('/sign_in/')
def check_otp_action(request):
     logid=request.POST.get("logid")
     otp=request.POST.get("otp")
   
     otpsend = request.POST.get("sendotp")
     if(int(otpsend)==int(otp)):
      
        return render(request,'new_password.html',{'logid':logid})
     else:
        messages.add_message(request, messages.INFO, 'Invalid OTP')
        return redirect('/sign_in/')
def change_psd(request):
     logid=request.POST.get("logid")
     password=make_password(request.POST.get("password"),salt='mySalt')
     tbl = Login.objects.get(login_id=logid)
     tbl.password=password
     tbl.save()      
     messages.add_message(request, messages.INFO, 'Password has been changed')
     return redirect('/sign_in/')

def send_mail(erc,msg,sub):
    email_sender=""
    email_password=""
    email_receiver=erc
    subject=sub
    body=msg
    em=EmailMessage()
    em['From']=email_sender
    em['To']=email_receiver
    em['Subject']=subject
    em.set_content(body)
    context=ssl.create_default_context()
    with smtplib.SMTP_SSL('smtp.gmail.com',465,context=context) as smtp:
        smtp.login(email_sender,email_password)
        smtp.sendmail(email_sender,email_receiver,em.as_string())

def generate_otp(length): # Define the function with the parameter ‘length’
    otp = ""
    for _ in range(length): # Use for loop
        otp += str(random.randint(0, 9)) # 
    return otp
def video_chat(request):
    room_name = request.GET.get('room_name', '')
    return render(request, 'video_chat.html', {'room_name': room_name})




@csrf_exempt
def generate_token(request, room_name):
    try:
        account_sid = settings.TWILIO_ACCOUNT_SID
        api_key_sid = settings.TWILIO_API_KEY_SID
        api_key_secret = settings.TWILIO_API_KEY_SECRET

        identity = 'user'

        # Create Access Token with credentials
        token = AccessToken(account_sid, api_key_sid, api_key_secret, identity=identity)

        # Create a Video grant and add to token
        video_grant = VideoGrant(room='cool room')
        token.add_grant(video_grant)

        # Return token info as JSON
        token_str=token.to_jwt()
        return JsonResponse({'token': token_str})

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
def otp_verification(request, id):
    login_id=id
    c = Login.objects.filter(login_id=id).count()
    if(c>0):
       
        data2 = Patients.objects.get(login_id=login_id)
        email=data2.email
        sub="Your OTP From Online Hospital Web Portal"
        msg=generate_otp(4)
        send_mail(email,msg,sub)
        msg1=msg
        return render(request,'reg_check_otp.html',{'msg':msg1,'logid':login_id})

    else:
            messages.add_message(request, messages.INFO, 'Invalid User name')
            return redirect('/sign_in/')
def reg_check_otp_action(request):
     logid=request.POST.get("logid")
     otp=request.POST.get("otp")
   
     otpsend = request.POST.get("sendotp")
     if(int(otpsend)==int(otp)):
        data=Login.objects.get(login_id=logid)
        data.status="Approved"
        data.save()
        messages.add_message(request, messages.INFO, 'Registered Successfully')
        return redirect('/patient_registration/')
     else:
        data=Login.objects.get(login_id=logid)
        data.delete()
        data2=Patients.objects.get(login_id=logid)
        data2.delete()
        messages.add_message(request, messages.INFO, 'Regsitration Failed : Invalid Mail Id or OTP')
        return redirect('/patient_registration/')
     




def get_recommendations(request):
    if request.method == 'POST':
        # Retrieve symptoms from POST data
        symptoms = request.POST.get('symptoms')

        # Predict the disease based on symptoms
        disease = predict_disease(symptoms)

        # Fetch related information from various CSV files
        medications = get_medications().get(disease, [])
        precautions = get_precautions().get(disease, [])
        diet = get_diet().get(disease, [])
        workout = get_workout().get(disease, [])

        # Handle AJAX request
     
        data = {
                'disease': disease,
                'medications': medications,
                'precautions': precautions,
                'diet': diet,
                'workout': workout,
            }
        return JsonResponse(data)

        # If the request is not AJAX, return an HTTP 400 Bad Request
 

    # For GET request, render the form view
    return render(request, 'Doctor/add_prescription.html')
def generate_qr_code(request, appointment_id):
    # Generate the URL that will simulate payment for the appointment
    payment_url = request.build_absolute_uri(reverse('simulate_payment', args=[appointment_id]))

    # Create QR code with the payment URL
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(payment_url)
    qr.make(fit=True)

    img = qr.make_image(fill_color="black", back_color="white")

    # Serve the QR code as an image
    buffer = BytesIO()
    img.save(buffer, format="PNG")
    buffer.seek(0)

    return HttpResponse(buffer, content_type="image/png")
def simulate_payment(request, appointment_id):
    # Get the appointment and update its status
    appointment = get_object_or_404(Appointment,appointment_id=appointment_id)
    appointment.pay_status = 'Paid'
    appointment.save()

    # Redirect to a confirmation page or back to the appointment page
    messages.add_message(request, messages.INFO, 'Paid Successfully')
    return render(request, 'Patient/pay_success.html')

