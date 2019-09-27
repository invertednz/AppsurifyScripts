#javafile="org/jsoup/examples/HtmlToPlainText$FormattingVisitor.java"

#javafile=`echo $javafile | sed -e 's/\($&\).*\(.java&\)/\1\2/' `
#javafile=$1

#echo $javafile

#echo "$javafile" | cut -f2-1 -d"$"


#b=${javafile%\$*}
#echo "$b"

#javafile=`echo "$javafile" | sed -e 's/\(\$&\).*\(.java&\)/\1\2/' `
#echo $javafile


#javafile=${javafile%\.*}
#javafile=${javafile%\$*}
#echo $javafile

cd "c:/Github/jsoup/jsoup"

#foo=$RANDOM
#echo $foo
#echo $((foo%100))
#if [ $((foo%100)) -eq 1 ];
#	then
#	    echo "random skipping ... "
#		continue
#	fi
#
#numdetails=`find . -name "details.txt" -print | wc -l`
#echo $numdetails
#echo $(((RANDOM%$numdetails)+1))

total=1
counter=0
echo "hello"
num=0

numdetails=`find . -name "details.txt" -print | wc -l`
echo $numdetails
randomnum=$(((RANDOM%$numdetails)+1))
name=""

find . -name "details.txt" -print | while read filename
do
    echo "start ..."
	((num++))
    if [ $counter -eq $total ]
    then
	  break;
    fi

	if [ $num -ne $randomnum ];
	then
	    echo "random skipping ... "
		continue
	fi

    echo $filename
    name=$filename
    ((counter++))
done

echo $numdetails
echo $randomnum
echo $name