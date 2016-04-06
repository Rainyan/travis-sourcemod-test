# Script based on SMLIB's tests: https://github.com/bcserv/smlib/
#!/bin/bash

# Bash immediate exit and verbosity
set -ev

SMPATTERN="http:.*sourcemod-.*-linux.*"
SMURL="http://www.sourcemod.net/smdrop/$SMVERSION/"
SMPACKAGE=`lynx -dump "$SMURL" | egrep -o "$SMPATTERN" | tail -1`
COMPILE_TARGET="sm_testplugin.sp"

wget $SMPACKAGE
tar -xzf $(basename "$SMPACKAGE")
cp -R scripting/ addons/sourcemod/
cd addons/sourcemod/scripting/
chmod +x spcomp

# Temporarily disable bash immediate exit
set +e
while read -r function; do
	grep -Fq "$function" "$COMPILE_TARGET"
    exit_code=$?

    if [[ $exit_code != 0 ]]; then
    	echo "[ERROR] Stock function \"$function\" not found in \"$COMPILE_TARGET\". Please add it."
    	exit 1
    fi
done <<< "$functions"
set -e

./spcomp -\; "$COMPILE_TARGET"

ls *.smx