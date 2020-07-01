dk_java () {
   if [[ $1 == "" ]]; then
      echo "cmd $fileName"
      return
   fi

   fileName="$(echo $1 | cut -d '.' -f1)"
   classPath="/Users/Compet/.Trash/"

   javac -d $classPath $fileName.java

   if [[ $# == "" ]]; then
      echo "Compilation failed"
      return
   fi

   echo "Compilation successful"
   java -cp $classPath $fileName
}
