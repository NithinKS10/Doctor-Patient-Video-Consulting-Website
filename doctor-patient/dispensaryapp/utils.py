import csv
import os
import ast
import pickle

# Define the paths to your CSV files
DATA_DIR = os.path.join(os.path.dirname(__file__), 'data')
MEDICATION_FILE = os.path.join(DATA_DIR, 'medications.csv')
PRECAUTIONS_FILE = os.path.join(DATA_DIR, 'precautions_df.csv')
DIET_FILE = os.path.join(DATA_DIR, 'diets.csv')
WORKOUT_FILE = os.path.join(DATA_DIR, 'workout.csv')

def load_csv_as_dict(file_path):
    """
    Load a CSV file and return it as a dictionary with the disease as the key
    and the associated data as the value (list).
    
    Args:
        file_path (str): Path to the CSV file.
    
    Returns:
        dict: A dictionary where each key is a disease and the value is a list of data (medications, precautions, etc.).
    """
    data = {}
    with open(file_path, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            disease = row['disease']
            try:
                # Convert the string list back into an actual Python list
                data_list = ast.literal_eval(row['data'])
                data[disease] = data_list
            except (ValueError, SyntaxError) as e:
                print(f"Error parsing data for {disease}: {e}")
                data[disease] = []  # Default to empty list in case of error
    return data

def get_medications():
    """
    Load the medications data from the CSV file.

    Returns:
        dict: A dictionary with disease names as keys and lists of medications as values.
    """
    return load_csv_as_dict(MEDICATION_FILE)

def get_precautions():
    """
    Load the precautions data from the CSV file.

    Returns:
        dict: A dictionary with disease names as keys and lists of precautions as values.
    """
    return load_csv_as_dict(PRECAUTIONS_FILE)

def get_diet():
    """
    Load the diet data from the CSV file.

    Returns:
        dict: A dictionary with disease names as keys and lists of diet recommendations as values.
    """
    return load_csv_as_dict(DIET_FILE)

def get_workout():
    """
    Load the workout data from the CSV file.

    Returns:
        dict: A dictionary with disease names as keys and lists of workout recommendations as values.
    """
    return load_csv_as_dict(WORKOUT_FILE)


def predict_disease(symptoms):
    """
    Predicts the disease based on symptoms using a pre-trained machine learning model.
    
    Args:
        symptoms (str): Symptoms provided by the user.
    
    Returns:
        str: Predicted disease.
    """
    # Define the path to the model and vectorizer files
    model_path = os.path.join(os.path.dirname(__file__), 'data/model.pkl')
    vectorizer_path = os.path.join(os.path.dirname(__file__), 'data/vectorizer.pkl')

    # Load the pre-trained model and vectorizer
    try:
        with open(model_path, 'rb') as f:
            model = pickle.load(f)
        with open(vectorizer_path, 'rb') as f:
            vectorizer = pickle.load(f)
    except FileNotFoundError as e:
        raise RuntimeError(f'File not found: {e}')
    except pickle.PicklingError as e:
        raise RuntimeError(f'Error loading pickle file: {e}')

    # Convert the symptoms text into numerical data using the vectorizer
    try:
        symptoms_transformed = vectorizer.transform([symptoms])
    except Exception as e:
        raise RuntimeError(f'Error transforming symptoms: {e}')

    # Predict the disease using the model
    try:
        predicted_disease = model.predict(symptoms_transformed)
        return predicted_disease[0]
    except Exception as e:
        raise RuntimeError(f'Error predicting disease: {e}')

