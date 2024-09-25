import os
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
import pickle
from django.core.management.base import BaseCommand, CommandError

class Command(BaseCommand):
    help = 'Train the disease prediction model and save it to a file'

    def handle(self, *args, **options):
        # Define the path to the CSV file and model files
        data_dir = os.path.join(os.path.dirname(__file__), '../../data')
        csv_file_path = os.path.join(data_dir, 'symptoms_diseases.csv')
        model_file_path = os.path.join(data_dir, 'model.pkl')
        vectorizer_file_path = os.path.join(data_dir, 'vectorizer.pkl')

        # Print paths for debugging
        self.stdout.write(f'Data directory: {data_dir}')
        self.stdout.write(f'CSV file path: {csv_file_path}')
        self.stdout.write(f'Model file path: {model_file_path}')
        self.stdout.write(f'Vectorizer file path: {vectorizer_file_path}')

        # Check if data directory exists
        if not os.path.exists(data_dir):
            raise CommandError(f'Data directory does not exist: {data_dir}')

        # Check if CSV file exists
        if not os.path.isfile(csv_file_path):
            raise CommandError(f'CSV file does not exist: {csv_file_path}')

        try:
            # Load the dataset
            data = pd.read_csv(csv_file_path)

            # Separate features and target
            X = data['symptoms']  # symptoms as features
            y = data['disease']   # disease as the target

            # Convert the symptoms text into numerical data using CountVectorizer
            vectorizer = CountVectorizer()
            X = vectorizer.fit_transform(X)

            # Split data into training and testing sets
            X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

            # Train a Naive Bayes classifier
            model = MultinomialNB()
            model.fit(X_train, y_train)

            # Save the model to a file
            with open(model_file_path, 'wb') as f:
                pickle.dump(model, f)

            # Save the vectorizer for transforming input in Django
            with open(vectorizer_file_path, 'wb') as f:
                pickle.dump(vectorizer, f)

            self.stdout.write(self.style.SUCCESS('Model and vectorizer trained and saved successfully.'))

        except pd.errors.EmptyDataError:
            raise CommandError('CSV file is empty or could not be read')
        except pd.errors.ParserError:
            raise CommandError('Error parsing CSV file. Please check the file format.')
        except FileNotFoundError as e:
            raise CommandError(f'File not found: {e}')
        except Exception as e:
            raise CommandError(f'An unexpected error occurred: {e}')
