prev_platex_result="0"
dk_latex_build () {
   if [[ $1 == "" ]]; then
      echo "cmd $texFileName [-s(show platex log) | -d(double running platex)]"
      return
   fi

   filename="$(echo $1 | cut -d '.' -f1)"
   option=$2
   tmp_dir="tmp"
   platex_result="-1"

   mkdir $tmp_dir
   echo "running: platex -output-directory=$tmp_dir $filename.tex"

   if [[ $option == "-s" ]]; then
      platex -output-directory=$tmp_dir $filename.tex
   else
      platex -output-directory=$tmp_dir $filename.tex > /dev/null
   fi

   platex_result=$?

   if [[ $prev_platex_result == "-1" || $option == "-d" ]]; then
      echo "double running: platex -output-directory=$tmp_dir $filename.tex"
      platex -output-directory=$tmp_dir $filename.tex > /dev/null
   fi

   if [[ $platex_result == 0 ]]; then
      prev_platex_result="0"
      echo "running: dvipdfmx $tmp_dir/$filename.dvi -o $filename.pdf"
      dvipdfmx $tmp_dir/$filename.dvi -o $filename.pdf
      sleep 0.6
      open $filename.pdf
   else
      prev_platex_result="-1"
   fi
}
