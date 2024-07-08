from azure.storage.blob import BlobServiceClient, BlobClient
import os

# Define the storage account URL, container name, and SAS token
storage_account_url = os.environ.get("STORAGE_ACCOUNT_URL")
container_name = os.environ.get("STORAGE_CONTAINER_NAME")
sas_token = os.environ.get("SAS_TOKEN")

# Create a BlobServiceClient using the SAS token
blob_service_client = BlobServiceClient(account_url=storage_account_url, credential=sas_token)

# Get a reference to the container
container_client = blob_service_client.get_container_client(container_name)

# Define the name of the file to be uploaded and its content
file_name = "test_file.txt"
file_content = "This is a test file."

# Upload the file
blob_client = container_client.get_blob_client(file_name)
blob_client.upload_blob(file_content, overwrite=True)

print(f"File '{file_name}' uploaded successfully.")
