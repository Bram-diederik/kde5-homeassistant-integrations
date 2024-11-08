#!/bin/bash

# Home Assistant API settings
HA_SITE="http://192.168.1.1:8123"  # Replace with your Home Assistant IP
HA_TOKEN=""
# Google Custom Search API settings
API_KEY=""
CUSTOM_SEARCH_ENGINE_ID=""
NUM_RESULTS=10

# Function to convert special characters to HTML entities
html_encode() {
    local string="$1"
    string="${string//&/&amp;}"
    string="${string//</&lt;}"
    string="${string//>/&gt;}"
    string="${string//\"/&quot;}"
    string="${string//\'/&apos;}"
    string="${string// /%20}"  # Convert spaces to %20
    echo "$string"
}

# Function to display usage
usage() {
    echo "Usage: $0 -q <query>" 1>&2
    exit 1
}

# Parse command-line options
while getopts ":q:" opt; do
    case ${opt} in
        q )
            QUERY=${OPTARG}
            ;;
        \? )
            usage
            ;;
        : )
            echo "Invalid option: ${OPTARG} requires an argument" 1>&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Check if query is provided
if [ -z "${QUERY}" ]; then
    echo "Error: Query is missing" 1>&2
    usage
fi

QUERY=$(html_encode "${QUERY}")

# Fetch search results
SEARCH_RESULTS=$(curl -s "https://www.googleapis.com/customsearch/v1?key=${API_KEY}&cx=${CUSTOM_SEARCH_ENGINE_ID}&q=${QUERY}&num=${NUM_RESULTS}")

# Loop through each search result and create entities in Home Assistant
for ((i=0; i<${NUM_RESULTS}; i++)); do
    title=$(echo "${SEARCH_RESULTS}" | jq -r ".items[${i}].title")
    link=$(echo "${SEARCH_RESULTS}" | jq -r ".items[${i}].link")
    snippet=$(echo "${SEARCH_RESULTS}" | jq -r ".items[${i}].snippet")

    # Create entity using Home Assistant API
    curl -X POST -H "Authorization: Bearer ${HA_TOKEN}" -H "Content-Type: application/json" \
         -d '{
             "object_id": "google_search_'"${i}"'",
             "name": "google_search_'"${i}"'",
             "state": "'"${title}"'",
             "attributes": {
                 "title": "'"${title}"'",
                 "link": "'"${link}"'",
                 "snippet": "'"${snippet}"'"
             },
             "icon": "mdi:web"
         }' \
         "${HA_SITE}/api/states/sensor.google_search_${i}"
done
