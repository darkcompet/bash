
# Customize top command for more effecient and readable
dk_top() {
   top -F -R -o cpu
}

dk_powermetric() {
   sudo powermetrics  | grep "die"
}
