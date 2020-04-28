alias .="cd ../"
alias ..="cd ../../"
alias c="pbcopy"
alias p="pbpaste"
alias cp="cp -i -R"
alias mv="mv -f"
alias l="ls -a"
alias ll="ls -la"

# Actions onto bash profile
__bash () {
   case $1 in
      "edit" )
         __open sub ~/workspace/programming/libraries/libs_bash/macos
         return;;
      "update" )
         source ~/.zshrc
         return;;
      * )
         echo "Usage: cmd [edit | update]"
         return;;
   esac
}

# Remove data permanently
# if you wanna change at sudo level, add -g option after alias keyword.
alias rm="__rm"
__rm () {
   if [[ $* == "" ]]; then
      echo "Nothing to remove"
      return
   fi

   fileNamesExpression=""
   first="1"

   for fileName in "$@"; do
      if [[ $first == "1" ]]; then
         first="0"
         fileNamesExpression+="'$fileName'"
      elif [[ $first == "0" ]]; then
         fileNamesExpression+=", '$fileName'"
      fi
   done

   printf "Don't use this command as possible as you can since it will delete data permanently, maybe impossible to recovery. "
   printf "Consider use [dl] instead to move data to Recycle bin, so you can push back later.\n"
   echo "But if you still wanna continue, please enter [yes/*] to delete/abort files [$fileNamesExpression]."

   read confirmation

   if [[ $confirmation != "yes" ]]; then
      echo "Aborted since you did not agree on this action"
      return
   fi

   for target_file in "$@"; do
      sudo rm -rf "$target_file"

      result=$?

      if [[ $result == "0" ]]; then
         echo "Removed file '$target_file' successful"
      elif [[ $result == "-1" ]]; then
         echo "Failed to remove file '$target_file'"
      fi
   done

   echo "Permanently removed $# files [$fileNamesExpression]"
}

# Trash data to Recycle bin.
# Just tell Finder do for us since a lot of features has to implement, eg., push back from Trash...
alias dl="__delete"
__delete () {
   if [[ $1 == "" ]]; then
      echo "Usage: cmd $fileName"
      return
   fi

   filePath="$(pwd)/$1"

   osascript -e "tell application \"Finder\" to delete POSIX file \"$filePath\"" >> /dev/null

   echo "Moved to trash: $filePath"
}

# Clear current text on terminal
alias cl="__clear"
__clear () {
   case $1 in
      "" )
         clear
         return;;
   esac
}

# Change directory
alias cd="__cd"
__cd () {
   \cd "$@"; ls -a
}
