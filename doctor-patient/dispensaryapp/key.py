from cryptography.fernet import Fernet

# Generate a key
key = Fernet.generate_key()
print(key.decode())  # Store this key safely

# Create Fernet object with the key
cipher_suite = Fernet(key)
