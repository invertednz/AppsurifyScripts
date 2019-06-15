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
spectoexec=$7

#rspec --format RspecJunitFormatter  --out result.xml

rspec bundle exec rspec $spectoexec --fail-fast   ###this still needs to produce a xml output file