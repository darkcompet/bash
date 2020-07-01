dk_csharp () {
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
dk_android_device () {
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

dk_quit_app () {
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

dk_show_own_functions () {
   set | fgrep " ()"
}

# Calculate size of files
dk_sizeof () {
   case $1 in
      "" )
         echo "Usage: cmd $fileName"
         return;;
      * )
         du -sh "$1"
         return;;
   esac
}

dk_wifi () {
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
dk_eject_disk () {
   case $1 in
      "" )
         echo "cmd [fileName]"
         return;;
      * )
         \diskutil eject $1
         return;;
   esac
}

dk_device () {
   case $1 in
      "" )
         echo "Usage: cmd [turn_off_screen]"
         return;;
      "turn_off_screen" )
         /System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine
         return;;
   esac
}

dk_start_localhost_with_python_at () {
   \python -m SimpleHTTPServer
}
