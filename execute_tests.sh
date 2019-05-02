
export JAVA_HOME="/c/Program Files/Java/jdk1.8.0_161"

parentpath="jsoup"
srcpath="/f/professional/projects/java/appsurify/mutant_project/git_repo/jsoup/src/main/java"
cpath="/f/professional/projects/java/appsurify/mutant_project/git_repo/jsoup/target/classes"

apiKey="MTpEbzhXQThOaW14bHVQTVdZZXNBTTVLT0xhZ00"
project="121"
testsuite="Unit"
importtype="junit"

total=1
counter=0
echo "hello"

find . -name "details.txt" -print | while read filename
do
    echo "start ..."
    if [ $counter -eq $total ]
    then
	  break;
    fi
	
	foo=$RANDOM
    
	if [ $((foo%2)) -eq 0 ];
	then
	    echo "random skipping ... "
		continue
	fi


	echo $filename

	dir=`dirname $filename`
	classname=`ls -1 $dir/*.class | xargs basename`
	echo $classname

	javafile=`echo "$classname" | sed 's/\./\//g' | sed 's/\/class/\.java/g' `
	completepath=$srcpath/$javafile
	echo $completepath
	
	cfile=`echo "$javafile" | sed 's/java/class/g' `
	echo $cpath/$cfile

	jname=`echo $completepath | xargs basename`
	newfile=`echo $completepath | xargs basename`
	newfile=`echo "$newfile"new`
    echo $dir/$newfile 

	# Replace the .java file
	echo "$dir/$newfile" $completepath
	cp "$dir/$newfile" $completepath
	EXIT_STATUS=$?
	
	if [ $EXIT_STATUS -ne 0 ]; then
        echo "Continue to next file ..........."
		continue 
	fi
	
	# replace the .class
	echo "$dir/$classname" "$cpath/$cfile"
	cp "$dir/$classname" "$cpath/$cfile"
	
	echo "running test"
	# run mvn surefire:test
	cd $parentpath
	/g/installations/maven/apache-maven-3.5.4-bin/apache-maven-3.5.4/bin/mvn surefire:test
	
	# commit the code
	git add -A
	git status
	git commit -m "mutant changes"
    git push
	
	commitId=`git log -n 1 | grep commit | cut -d " " -f2`
	sleep 5
	
	# push the results
	echo "push test results to api server"
	fileName="/f/professional/projects/java/appsurify/mutant_project/git_repo/jsoup/target/surefire-reports/TEST-org.jsoup.select.TraversorTest.xml"
	
	for fileName in `ls -1 ./target/surefire-reports/*.xml`
	  do
	    echo "call api for $fileName" 
		curl -X POST http://appsurify.dev.appsurify.com/api/external/import/ -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' -H "token: $apiKey" -F "file=@$fileName" -F 'project'=$project -F 'test_suite_name'=$testsuite -F 'type'=$importtype -F 'commit'=$commitId
	  done
	
	cd ..
	echo "-----Revert the java file------------"
	
	# Replace the .java file
	echo "$dir/$jname" $completepath
	cp "$dir/$jname" $completepath
	
	
	# replace the .class  or mvn clean install
	cd $parentpath
	/g/installations/maven/apache-maven-3.5.4-bin/apache-maven-3.5.4/bin/mvn clean install
	
	# run mvn surefire:test
	/g/installations/maven/apache-maven-3.5.4-bin/apache-maven-3.5.4/bin/mvn surefire:test
	
	# commit the code
	git add -A
	git status
	git commit -m "revert mutant changes"
    git push
	
	commitId=`git log -n 1 | grep commit | cut -d " " -f2`
	sleep 5
	
	# push the results
	echo "push test results to api server"
	fileName="/f/professional/projects/java/appsurify/mutant_project/git_repo/jsoup/target/surefire-reports/TEST-org.jsoup.select.TraversorTest.xml"
	
	for fileName in `ls -1 ./target/surefire-reports/*.xml`
	  do
	    echo "call api for $fileName" 
		curl -X POST http://appsurify.dev.appsurify.com/api/external/import/ -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' -H "token: $apiKey" -F "file=@$fileName" -F 'project'=$project -F 'test_suite_name'=$testsuite -F 'type'=$importtype -F 'commit'=$commitId
	  done
	
	cd ..
	
	echo "----------------"
	
	
	((counter++))
	echo $counter
	echo "---------------------------------------------------------------------------"

done
