#!/usr/bin/env bash
#

#[ -z "$BASH_VERSINFO" ] && printf "\n\033[1;35m Please make sure you're using \"bash\"! Bye...\033[m\n\n" >&2 && exit 245

# commits and pushes the folowing repos
docker_repos="serverdocker_web_1:openchirp/web serverdocker_rest_1:openchirp/rest serverdocker_mqtt-tsdb-storage-service_1:openchirp/mqtt-tsdb-storage-service"

# edit these ate you convinience
commit_author="Openchirp"
commit_tag="$1"
commit_comment="\"${commit_tag} commit.\""

# prefix commit tag with a ":"
ct=":${commit_tag}"

# commit and push repos
for dr in $docker_repos
do
	container=$(echo $dr | cut -f 1 -d :)
	repo=$(echo $dr | cut -f 2 -d :)
	docker commit -a "${commit_author}" -m "${commit_comment}" ${container} ${repo}${ct}
	docker push ${repo}${ct}
done
