

srcpath="c:/Github/jsoup/jsoup/src/main/java"
counter=0

find . -name "details.txt" -print | while read filename
do
echo $filename

linenum=`grep -o -P '(?<=lineNumber=).*?(?=,)' $filename`
echo $linenum

dir=`dirname $filename`
classname=`ls -1 $dir/*.class | xargs basename`
echo $classname

javafile=`echo "$classname" | sed 's/\./\//g' | sed 's/\/class/\.java/g' | sed -e 's/\($&\).*\(.java&\)/\1\2/' `
echo "JAVA FILE = "
echo $javafile
#javafile=`echo "$javafile" | sed -e 's/\($&\).*\(.java&\)/\1\2/' `
javafile=`echo $javafile | sed -e 's/\($&\).*\(.java&\)/\1\2/' `
echo "JAVA FILE = "
echo $javafile
javafile=${javafile%\.*}
javafile=${javafile%\$*}
echo "JAVA FILE = "
echo $javafile
javafile=`echo "$javafile".java`
echo "JAVA FILE = "
echo $javafile
completepath=$srcpath/$javafile
echo $completepath

newfile=`echo $completepath | xargs basename`
echo $newfile
newfile=`echo "$newfile"new`

echo $newfile

cp $completepath $dir/.

echo "copy one complete"

cp $completepath "$dir/$newfile"
sed -i "${linenum}s/$/ /gI" "$dir/$newfile"

((counter++))
echo $counter
echo "---------------------------------------------------------------------------"
done

