#!/bin/sh
owner_name="damoncoo"
app_name="Yi"
token="3bbdf9f880358ddb7c31e5f81da43e160b1f5be4"
build_path="output.ipa"
destination_name="Internal"
release_notes="Upload By CI"

# Step 1: Create an upload resource and get an upload_url (good for 24 hours)
request_url="https://api.appcenter.ms/v0.1/apps/${owner_name}/${app_name}/release_uploads"
upload_json=$(curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" --header "X-API-Token: ${token}" "${request_url}") 
upload_id=$(echo ${upload_json} | \
    python3 -c "import sys, json; print(json.load(sys.stdin)['upload_id'])")
upload_url=$(echo ${upload_json} | \
    python3 -c "import sys, json; print(json.load(sys.stdin)['upload_url'])")

# Step 2: Upload ipa
curl -F "ipa=@${build_path}" ${upload_url}

# Step 3: Upload resource's status to committed and get a release_url
release_json=$(curl -X PATCH --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-API-Token: ${token}" -d '{ "status": "committed" }' "${request_url}/${upload_id}")
release_id=$(echo ${release_json} | \
    python3 -c "import sys, json; print(json.load(sys.stdin)['release_id'])")

# Step 4: Distribute the uploaded release to a distribution group"
release_url="https://api.appcenter.ms/v0.1/apps/${owner_name}/${app_name}/releases/${release_id}"
data="{ \"destination_name\": \"${destination_name}\", \"release_notes\": \"${release_notes}\" }"
response_json=$(curl -X PATCH --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-API-Token: ${token}" -d "${data}" ${release_url})
echo ${response_json}