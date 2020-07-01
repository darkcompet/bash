alias g="dk_goto"
dk_goto () {
   case $1 in
      "s" )
         dk_cd /Volumes/Storage
         return;;
      "w" )
         dk_cd ~/workspace/wiki
         return;;
      "m" )
         dk_cd ~/workspace/marbled
         return;;
      "p" )
         dk_cd ~/workspace/projects
         return;;
      "d" )
         dk_cd ~/workspace/darkcompet
         return;;
      "k" )
         dk_cd ~/workspace/kilobytes
         return;;
      "l" )
         dk_cd ~/workspace/libraries
         return;;
      * )
      "cmd [d | k | l | m | p | s | w]"
         return;;
   esac
}

alias op="dk_open_app"
dk_open_app () {
   case $1 in
      "" )
         echo "This command will open the software with specified parameters"
         echo "cmd [and | cod | int |...]"
         return;;
      "and" )
         \open -a Android\ Studio.app $2
         return;;
      "ato" )
         \open -a Atom $2
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
      "storm" )
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
      "uni" )
         \open /Applications/Unity\/Unity.app $2
         return;;
      * )
         \open $1
         return;;
   esac
}