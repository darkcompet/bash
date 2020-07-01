# Upload to remote Git repository
dk_git_push () {
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
