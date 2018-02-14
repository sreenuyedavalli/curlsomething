#!/bin/bash
#Author Sreenu Yedavalli
set -e 
set -x 

DATE=$(date) 

function curl_this {
	for ((i=1; i<=$TIMES; i++)); do
		 curl -i -s -o /dev/null -w "%{http_code}\n" $URL/;
	done
	}
function curl_response_count {
	echo "resp_200_ok=$(grep -c '200' curl_log_"$DATE")"
	echo "resp_405_notallowed=$(grep -c '405' curl_log_"$DATE")"
	echo "resp_503_unavailable=$(grep -c '503' curl_log_"$DATE")"
	echo "resp_504_timeout=$(grep -c '504' curl_log_"$DATE")"
	echo "resp_500_server_error=$(grep -c '500' curl_log_"$DATE")"
	}

echo "Wanna Curl the shit out of something?"
read -e -p "Enter the url for the site (ex. http://www.google.com):" URL
read -e -p "Enter the number of times you want to curl it:" TIMES

curl_this>>curl_log_"$DATE"
curl_response_count
