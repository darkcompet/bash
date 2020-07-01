# Compress (zip) files to a archivement
dk_compress () {
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

# Extracts (unzip) a file to set of pieces.
dk_extract () {
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
            echo "'$1' cannot be extracted via dk_extract()"
            return;;
      esac
   else
      echo "'$1' is not a valid file"
   fi
}
