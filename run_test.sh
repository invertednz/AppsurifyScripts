
#export JAVA_HOME="/c/Program Files/Java/jdk1.8.0_161"

echo "Starting the script"

#n_commit=$1

apiKey="MTpEbzhXQThOaW14bHVQTVdZZXNBTTVLT0xhZ00"
#fileName="/f/professional/projects/java/appsurify/jsoup/target/surefire-reports/TEST-org.jsoup.helper.DataUtilTest.xml"
project="segridextras"
testsuite="Unit"
importtype="junit"
#commitId="9f2f5671674e4fdbaea3bf73e826354fb177111b"

cd ../Selenium-Grid-Extras

> console.log

echo "here"
git checkout -f master
#for j in `git branch -r | grep origin | grep -v HEAD`
#do
#    echo "branch" >> console.log
#    echo $j >> console.log
	#git checkout $j
    #for i in `git log -n $n_commit --reverse | grep commit | cut -d " " -f2`
    for i in `git log --since="2014-8-10" --reverse | grep commit | cut -d " " -f2`
    do
    rm -rf SeleniumGridExtras/target/surefire-reports
    echo %DATE% %TIME% >> console.log
      git checkout -f master
      echo $i >> console.log
	  commitId=$i
      git checkout -f $i

      echo "running test" >> console.log
      #del ./target/surefire-reports/
      #/g/installations/maven/apache-maven-3.5.4-bin/apache-maven-3.5.4/bin/mvn test
      #mvn test
      mvn package
    echo %DATE% %TIME%  >> console.log
	  echo "push test results to api server" >> console.log
	  
	  for fileName in `ls -1 ./SeleniumGridExtras/target/surefire-reports/*.xml`
	  do
      echo %DATE% %TIME%  >> console.log
	    echo "call api for $fileName" >> console.log
		curl -X POST http://appsurify.test.appsurify.com/api/external/import/ -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' -H "token: $apiKey" -F "file=@$fileName" -F 'project_name'=$project -F 'test_suite_name'=$testsuite -F 'type'=$importtype -F 'commit'=$commitId
	  done	  
    echo "finished uploading"
    git checkout -f master
    done
#done


