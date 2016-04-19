#!/bin/sh

for i in $(docker ps --format="{{ .ID }}"); do

	CONTAINER=$(docker inspect --format="{{ json .Config.Labels }}" $i | jq ".[\"io.rancher.project_service.name\"]" | sed -e 's/^"//'  -e 's/"$//' -e 's/\//_/' )

	if [ "$CONTAINER" != "null" ]; then

		FILENAME="$CONTAINER.tar.xz"
		echo "$FILENAME"

		docker run --rm \
			--volumes-from "$i" \
			-e TAR_OPTS="$TAR_OPTS" \
			-e ACCESS_KEY="$AWS_ACCESS_KEY" \
			-e SECRET_KEY="$AWS_SECRET_KEY" \
			-e BUCKET="s3://$AWS_BUCKET/" \
			boombatower/docker-backup-s3 backup "$FILENAME"

	else

        echo "$i is not a rancher container."

    fi

done
