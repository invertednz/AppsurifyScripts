
#export JAVA_HOME="/c/Program Files/Java/jdk1.8.0_161"

echo "Starting the script"

commitId=$1

apiKey="MTpEbzhXQThOaW14bHVQTVdZZXNBTTVLT0xhZ00"
#fileName="/f/professional/projects/java/appsurify/jsoup/target/surefire-reports/TEST-org.jsoup.helper.DataUtilTest.xml"
#project="segridextras"
project="jsoup2"
testsuite="Unit"
importtype="junit"
#commitId="9f2f5671674e4fdbaea3bf73e826354fb177111b"

#cd ../Selenium-Grid-Extras
cd ../jsoup
git checkout -f $commitId

	  for fileName in `ls -1 ./target/surefire-reports/*.xml`
	  do
      
	    echo "call api for $fileName"
		curl -X POST http://appsurify.test.appsurify.com/api/external/import/ -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' -H "token: $apiKey" -F "file=@$fileName" -F 'project_name'=$project -F 'test_suite_name'=$testsuite -F 'type'=$importtype -F 'commit'=$commitId
	  done	  
#done


