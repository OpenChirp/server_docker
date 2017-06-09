#!/usr/bin/env bash
#

#[ -z "$BASH_VERSINFO" ] && printf "\n\033[1;35m Please make sure you're using \"bash\"! Bye...\033[m\n\n" >&2 && exit 245

# commits and pushes the folowing repos
docker_repos="openchirp/web openchirp/rest openchirp/mqtt-tsdb-storage-service"

# edit these ate you convinience
commit_author="Openchirp"
commit_tag=version_1
commit_comment="\"${commit_tag} Commit\""

# prefix commit tag with a ":"
ct=":${commit_tag}"

# commit and push repos
for dr in $docker_repos
do
	docker commit -a "${commit_author}" -m "${commit_comment}" serverdocker_web_1 openchirp/web${ct}
	docker push $dr
done
