##
## ---------- Command Path ----------
##

# Flutter sdk
PATH="${PATH}:/Users/Compet/Library/Flutter/flutter/bin"

# Android sdk
PATH="${PATH}:/Users/Compet/Library/Android/sdk/tools"
PATH="${PATH}:/Users/Compet/Library/android/sdk/platform-tools"

# Apache for PHP
PATH="${PATH}:/Volumes/Storage/Apps/library/apache-ant-1.9.6/bin"

# VS Code
PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Sublime
PATH="${PATH}:/Applications/Sublime Text.app/Contents/SharedSupport/bin"

# TeX
PATH="${PATH}:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin"

# JavaScriptCore
PATH="${PATH}:/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources"

# MySQL
PATH="${PATH}:/usr/local/mysql/support-files"
PATH="${PATH}:/usr/local/mysql/bin"

# Laravel
PATH="${PATH}:/Users/Compet/.composer/vendor/bin"

# TomCat
#PATH="${PATH}:/Library/Tomcat/bin"

# Python
#PATH="${PATH}:/Library/Frameworks/Python.framework/Versions/Current/bin/python2"

# Ruby
#PATH="${PATH}:/usr/local/opt/ruby/bin"
#PATH="${PATH}:/Users/Compet/.gem/ruby/2.3.0/bin"

export PATH


##
## ---------- Style ----------
##

# Customize terminal style
#export PS1="%10F%m%f:%11F%2~%f \$ " // last 2 elements of full path (%/)
export PS1="%10F%m%f:%11F%~%f \$ "
#export PS1="%10F%m%f:%11F%/%f \$ " //all elements of full path (%/)
export CLICOLOR=1
export LSCOLORS=CxFxBxDxBxegedabagacad


##
## ---------- Basic command ----------
##

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
			code ~/workspace/darkcompet/bash/mac
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
alias rm="__remove"
__remove () {
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


##
## ---------- ZIP ----------
##

# Compress (zip) files to a archivement
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

# Extracts (unzip) a file to set of pieces.
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


##
## C++
##

__cpp_compile () {
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


##
## Extension
##

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
			echo "Args: `filename`"
			return;;
		* )
			du -sh "$1"
			return;;
	esac
}

__wifi () {
	case $1 in
		"" )
			echo "Option: --on, --off"
			return;;
		"-on" )
			\networksetup -setairportpower airport on
			return;;
		"-off" )
			\networksetup -setairportpower airport off
			return;;
	esac
}

# Eject disk
__eject_disk () {
	case $1 in
		"" )
			echo "Args: `fileName`"
			return;;
		* )
			\diskutil eject $1
			return;;
	esac
}

__device () {
	case $1 in
		"" )
			echo "Options: --turn_off_screen"
			return;;
		"-turn_off_screen" )
			/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine
			return;;
	esac
}

__start_localhost_with_python_at () {
	\python -m SimpleHTTPServer
}

##
## ---------- Git ----------
##

# Upload to remote Git repository
__git_push () {
	branchName=$(git branch | cut -d ' ' -f2)
	printf "Enter commit message for branch '$branchName': "

	commit_msg=""
	read commit_msg

	if [[ $commit_msg == "" ]]; then
		commit_msg="make it better"
	fi

	git add --all
	git commit -m "$commit_msg"
	git push

	echo "Uploaded to remote branch '$branchName'"
}


##
## ---------- Java ----------
##

__java () {
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


##
## ---------- Latex ----------
##

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



##
## ---------- Monitor ----------
##


# Customize top command for more effecient and readable
__top() {
	top -F -R -o cpu
}

__powermetric() {
	sudo powermetrics | grep "die"
}



##
## ---------- String ----------
##

__substring () {
	#
}

__split () {
	msg=$1
	delimiter=$2
}


##
## ---------- Utility ----------
##

alias g="__goto"
__goto () {
	case $1 in
	"-s" )
		__cd /Volumes/Storage
		return;;
	"-w" )
		__cd ~/workspace/wiki
		return;;
	"-m" )
		__cd ~/workspace/marbled
		return;;
	"-p" )
		__cd ~/workspace/projects
		return;;
	"-d" )
		__cd ~/workspace/darkcompet
		return;;
	"-k" )
		__cd ~/workspace/kilobytes
		return;;
	"-l" )
		__cd ~/workspace/libraries
		return;;
	* )
		"Options: --d (darkcompet), --k (kilobytes), --l (libraries), --m (marble), --p (projects), --s (storage), --w (workspace)"
		return;;
	esac
}

alias op="__open_app"
__open_app () {
	case $1 in
	"" )
		echo "This command will open the software with specified parameters"
		echo "cmd [and | cod | int |...]"
		return;;
	"-and" )
		\open -a Android\ Studio $2
		return;;
	"-ato" )
		\open -a Atom $2
		return;;
	"-chr" )
		\open -a Google\ Chrome $2
		return;;
	"-cod" )
		\open -a Visual\ Studio\ Code $2
		return;;
	"-cha" )
		\open -a Chatwork $2
		return;;
	"-doc" )
		\open -a Docker $2
		return;;
	"-dro" )
		\open -a Dropbox $2
		return;;
	"-dic" )
		\open -a Dictionary $2
		return;;
	"-dri" )
		\open -a Google\ Drive $2
		return;;
	"-xco" )
		\open -a XCode $2
		return;;
	"-int" )
		\open -a IntelliJ\ IDEA\ CE $2
		return;;
	"-sto" )
		\open -a PhpStorm $2
		return;;
	"-sub" )
		\open -a Sublime\ Text $2
		return;;
	"-lin" )
		\open -a Line $2
		return;;
	"-lau" )
		\open -a LaunchPad
		return;;
	"-mes" )
		\open -a Messages $2
		return;;
	"-nav" )
		\open -a Navicat\ Premium $2
		return;;
	"-saf" )
		\open -a Safari $2
		return;;
	"-sky" )
		\open -a Skype
		return;;
	"-sub" )
		\open -a Sublime\ Text $2
		return;;
	"-uni" )
		\open /Applications/Unity\/Unity.app $2
		return;;
	"-wor" )
		\open -a MySQLWorkbench $2
		return;;
	"-zil" )
		\open -a FileZilla $2
		return;;
	* )
		\open $1
		return;;
	esac
}
