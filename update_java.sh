

srcpath="/f/professional/projects/java/appsurify/mutant_project/git_repo/jsoup/src/main/java"
counter=0

find . -name "details.txt" -print | while read filename
do
echo $filename

linenum=`grep -o -P '(?<=lineNumber=).*?(?=,)' $filename`
echo $linenum

dir=`dirname $filename`
classname=`ls -1 $dir/*.class | xargs basename`
echo $classname


javafile=`echo "$classname" | sed 's/\./\//g' | sed 's/\/class/\.java/g' `
completepath=$srcpath/$javafile
echo $completepath

newfile=`echo $completepath | xargs basename`
newfile=`echo "$newfile"new`

cp $completepath $dir/.

cp $completepath "$dir/$newfile"
sed -i "${linenum}s/$/ /gI" "$dir/$newfile"

((counter++))
echo $counter
echo "---------------------------------------------------------------------------"
done

