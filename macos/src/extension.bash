__csharp () {
   if [[ $1 == "" ]]; then
      echo "cmd [fileName]"
      return
   fi

   fileName="$(echo $1 | cut -d '.' -f1)"

   mcs $fileName.cs

   if [[ $# == "" ]]; then
      echo "Compile failed"
      return
   fi

   echo "Compile successful"
   mono $fileName.exe
}

# Goto frequent places.
alias g="__goto"
__goto () {
   case $1 in
      "p" )
         __cd ~/workspace/programming
         return;;
      "s" )
         __cd /Volumes/Storage
         return;;
      * )
      "cmd [w | k | s]"
         return;;
   esac
}

# Open a specified application with parameterized.
alias op="__open"
__open () {
   case $1 in
      "" )
         echo "This command will open the software with specified parameters"
         echo "cmd [and | cod | int |...]"
         return;;
      "and" )
         \open -a Android\ Studio.app $2
         return;;
      "chr" )
         \open -a Google\ Chrome $2
         return;;
      "cod" )
         \open -a Visual\ Studio\ Code $2
         return;;
      "dro" )
         \open -a Dropbox $2
         return;;
      "dic" )
         \open -a Dictionary $2
         return;;
      "dri" )
         \open -a Google\ Drive $2
         return;;
      "int" )
         \open -a IntelliJ\ IDEA $2
         return;;
      "php" )
         \open -a PhpStorm $2
         return;;
      "lin" )
         \open -a Line $2
         return;;
      "lau" )
         \open -a LaunchPad
         return;;
      "mes" )
         \open -a Messages $2
         return;;
      "saf" )
         \open -a Safari $2
         return;;
      "sky" )
         \open -a Skype
         return;;
      "sub" )
         \open -a Sublime\ Text $2
         return;;
      "ato" )
         \open -a Atom $2
         return;;
      "uni" )
         \open /Applications/Unity\/Unity.app $2
         return;;
      * )
         \open $1
         return;;
   esac
}

# For Android with device.
__android_device () {
   if [[ $1 == "" ]]; then
      echo "cmd connect $dev_ip_address_follow_192.168"
      return
   fi

   if [[ $1 == "connect" ]]; then
      dev_ip_address=192.168.$2
      echo "Connecting to $dev_ip_address"
      adb kill-server
      adb start-server
      adb tcpip 5555
      adb connect $dev_ip_address:5555
   fi
}

prev_platex_result="0"
__latex_build () {
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

__quit_app () {
   case $1 in
      "" )
         echo "Usage: cmd $appName"
         return;;
      * )
         pid=$(ps -A | grep -m1 "$1" | awk '{print $1}')
         eval "kill -9 $pid"
         echo "quited app at pid $pid"
         return;;
   esac
}

__show_own_functions () {
   set | fgrep " ()"
}

# Calculate size of files
__sizeof () {
   case $1 in
      "" )
         echo "Usage: cmd $fileName"
         return;;
      * )
         du -sh "$1"
         return;;
   esac
}

__wifi () {
   case $1 in
      "" )
         echo "Usage: cmd [on | off]"
         return;;
      "on" )
         \networksetup -setairportpower airport on
         return;;
      "off" )
         \networksetup -setairportpower airport off
         return;;
   esac
}

# Eject disk
__eject_disk () {
   case $1 in
      "" )
         echo __eject device-name
         return;;
      * )
         \diskutil eject $1
         return;;
   esac
}

# Compress files to a archivement
__compress () {
   case $1 in
      "" )
         echo "Usage: cmd [zip | gz | bz2] param_outFileName param_inFileName"
         return;;
      "zip" )
         \zip $2.zip $3
         return;;
      "gz" )
         \tar -zcvf $2.tar.gz $3
         return;;
      "bz2" )
         \tar -jcvf $2.tar.bz2 $3
         return;;
   esac
}

# Opposite of compression, this extracts a file to set of pieces.
__extract () {
   if [ -f $1 ]; then
      case $1 in
         "" )
            echo "Usage: cmd param_fileName"
            return;;
         *.rar )
            ~/rar/unrar x *.rar
            return;;
         *.tar.bz2 )
            \tar xjf $1
            return;;
         *.tar.gz )
            \tar xvzf $1
            return;;
         *.bz2 )
            \bunzip2 $1
            return;;
         *.rar )
            \unrar e $1
            return;;
         *.gz )
            \gunzip $1
            return;;
         *.tar )
            \tar xf $1
            return;;
         *.tbz2 )
            \tar xjf $1
            return;;
         *.tgz )
            \tar xzf $1
            return;;
         *.zip )
            \unzip $1
            return;;
         *.Z )
            \uncompress $1
            return;;
         *.7z )
            \7z x $1
            return;;
         *.war )
            \jar -xvf $1
            return;;
         *.gif )
            \convert -coalesce $1 ./out.png
            return;;
         * )
            echo "'$1' cannot be extracted via __extract()"
            return;;
      esac
   else
      echo "'$1' is not a valid file"
   fi
}

__device () {
   case $1 in
      "" )
         echo "Usage: cmd [turn_off_screen]"
         return;;
      "turn_off_screen" )
         /System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine
         return;;
   esac
}

__start_localhost_with_python_at () {
   \python -m SimpleHTTPServer
}
