# Script based on SMLIB's tests: https://github.com/bcserv/smlib/
#!/bin/bash

SMPATTERN="http:.*sourcemod-.*-linux.*"
SMURL="http://www.sourcemod.net/smdrop/$SMVERSION/"
SMPACKAGE=`lynx -dump "$SMURL" | egrep -o "$SMPATTERN" | tail -1`
COMPILE_TARGET="sm_testplugin.sp"

wget $SMPACKAGE
tar -xzf $(basename "$SMPACKAGE")
cp -R scripting/ addons/sourcemod/
cd addons/sourcemod/scripting/
chmod +x spcomp

./spcomp -\; "$COMPILE_TARGET"

ls *.smx