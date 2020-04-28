__cpp () {
   if [[ $1 == "" ]]; then
      echo "Usage: cmd [fileName]"
      return
   fi

   fileName="$(echo $1 | cut -d '.' -f1)"
   g++ -std=c++14 -O2 -Wall $fileName.cpp -o a.out

   if [[ $# == "" ]]; then
      echo "Compile failed"
      return
   fi

   echo "Compile successful"
   ./a.out
}
