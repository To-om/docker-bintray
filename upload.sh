#!/bin/bash

set -e

die() {
	echo $* >&2
	exit 1
}

[ -z "$PLUGIN_FILE"    ] && die 'No file to upload (setting "file")'
[ -z "$PLUGIN_USER"    ] && die 'No user configured (setting "user")'
[ -z "$PLUGIN_API_KEY" ] && die 'No API key configured (setting "api_key")'

if [ -z "$PLUGIN_URL" ]; then
	SUBJECT=${PLUGIN_SUBJECT:-$DRONE_REPO_NAMESPACE}
	REPO=${PLUGIN_REPO:-$DRONE_REPO_NAME}
	[ -z "$PLUGIN_PACKAGE" ] && die 'No package configured (setting "package")'
	DEST_FILE=${PLUGIN_DEST_FILE:-$(basename $PLUGIN_FILE)}
	PLUGIN_URL=${PLUGIN_BASE_URL:-https://api.bintray.com}/${PLUGIN_TYPE:-content}/$SUBJECT/$REPO/$PLUGIN_PACKAGE/${PLUGIN_VERSION:-$DRONE_TAG}/$DEST_FILE
fi

[ -n "$PLUGIN_DEB_DISTRIBUTION" ] && PLUGIN_URL=$PLUGIN_URL;deb_distribution=$PLUGIN_DEB_DISTRIBUTION
[ -n "$PLUGIN_DEB_COMPONENT"    ] && PLUGIN_URL=$PLUGIN_URL;deb_component=$PLUGIN_DEB_COMPONENT
[ -n "$PLUGIN_DEB_ARCHITECTURE" ] && PLUGIN_URL=$PLUGIN_URL;deb_architecture=$PLUGIN_DEB_ARTHITECTURE
[ -n "$PLUGIN_PUBLISH"          ] && PLUGIN_URL=$PLUGIN_URL;publish=$PLUGIN_PUBLISH
[ -n "$PLUGIN_OVERRIDE"         ] && PLUGIN_URL=$PLUGIN_URL;override=$PLUGIN_OVERRIDE
[ -n "$PLUGIN_EXPLODE"          ] && PLUGIN_URL=$PLUGIN_URL;explode=$PLUGIN_EXPLODE

echo "Uploading $PLUGIN_FILE to $PLUGIN_URL"

curl -T $PLUGIN_FILE -u$USER:$API_KEY $PLUGIN_URL
