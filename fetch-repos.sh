#!/usr/bin/env bash
#

[ -z "$BASH_VERSINFO" ] && printf "\n\033[1;35m Please make sure you're using \"bash\"! Bye...\033[m\n\n" >&2 && exit 245

############################
# clone source code repos into ./service-folder/code/

printf "\n\033[1;34m Cloning Repositories...\033[m\n\n"

while read line; do
	# ignore comments
	[[ "$line" =~ ^#.*$ ]] && continue

	# extract data from line
 	base_url=$(echo $line | cut -f 1 -d :)
 	repo=$(echo $line | cut -f 2 -d :)
  	url="https://${base_url}/${repo}"
  	tag=$(echo $line | cut -f 3 -d :)
  	target_folder=$(echo $line | cut -f 4 -d :)
	[ -z "$target_folder" ] && target_folder=$repo
	target_folder="./${target_folder}/code"

  	[ -d "$target_folder" ] && rm -fr "$target_folder"

  	git clone $url $target_folder || {
     	printf "\n\033[1;35m Error clonning repo ! \033[m\n\n"
     	continue
 	}
  	[ ! -z $tag ] && git --git-dir="$target_folder/.git" checkout $tag
done < repos-list.txt
