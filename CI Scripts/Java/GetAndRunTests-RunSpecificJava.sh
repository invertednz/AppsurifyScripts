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

starttests=""
fullname="True"

priority=""
if [[ $priority == "High" ]] ; priority="1" ; fi
if [[ $priority == "Medium" ]] ; priority="2" ; fi
if [[ $priority == "Low" ]] ; priority="3" ; fi
if [[ $priority == "Unassigned" ]] ; priority="4" ; fi
if [[ $priority == "Ready" ]] ; priority="6" ; fi
if [[ $priority == "Open" ]] ; priority="7" ; fi
if [[ $priority == "Rerun" ]] ; priority="5" ; fi


echo $url
echo $apiKey
echo $project
echo $testsuite
echo $commitId

finalTestNames=""
json=`curl --header "token: $apiKey" "$url/api/external/prioritized-tests/?project_name=$project&priority=1&full_name=$fullname&test_suite_name=$testsuite&commit=$commitId" | sed 's/\"//g'`
echo $json
prop="name"
values=`echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' |tr "," "\n" | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop | sed 's/\[//g' | sed 's/\]//g' | sed 's/name://g' `
then echo $values
if [[ $json != *"name"* ]] ; then echo "No test found" ; values="" ; fi
for testName in $values; do count=$((count+1));  echo $count; if [ $(( $count % $maxtests )) -eq "0" ]; then finalTestNames=$finalTestNames`echo $starttests$testName,`; finalTestNames=`echo $finalTestNames | sed 's/,$//g'`; mvn -Dtest=$finalTestNames test ; finalTestNames=""; else finalTestNames=$finalTestNames`echo $starttests$testName,`; fi;done
finalTestNames=`echo $finalTestNames | sed 's/,$//g'` ; fi
if [[ $finalTestNames != "" ]] ; then mvn -Dtest=$finalTestNames test ; fi


