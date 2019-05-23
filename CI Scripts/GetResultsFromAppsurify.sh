#url
#url="http://appsurify.dev.appsurify.com"
url=$1
#API Key
#apiKey="MTpEbzhXQThOaW14bHVQTVdZZXNBTTVLT0xhZ00"
apiKey=$2
#Project
#project="2"
project=$3
#Test Suite
#testsuite="1"
testsuite=$4
#get commit
commitId=$5
report=$6
importtype="junit"
echo $report"*.xml\`"


#get results
#finalRes=`curl --header "token: $apiKey" "$url/api/external/output/?${run_id}" ` ; echo $finalRes
#new_defects=`echo $finalRes | sed 's/\\\\\//\//g' | sed 's/[{}]//g' |tr "," "\n" | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' |  grep -w new_defects ` ; echo $new_defects
#reopened_defects=`echo $finalRes | sed 's/\\\\\//\//g' | sed 's/[{}]//g' |tr "," "\n" | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' |  grep -w reopened_defects ` ; echo $reopened_defects
#if [[ $new_defects != "new_defects:0" || $reopened_defects != "reopened_defects:0" ]] ; then exit 1 ; fi

exit 1