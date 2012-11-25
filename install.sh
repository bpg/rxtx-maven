#!/bin/sh

VERSION=2.2pre2
ARTIFACT=rxtx
GROUP=org.rxtx
NAME=$ARTIFACT-$VERSION

rm -rf $ARTIFACT* > /dev/null

echo Downloading binaries of $NAME
wget -q http://rxtx.qbang.org/pub/rxtx/$NAME-bins.zip > /dev/null

echo Preparing
unzip $NAME-bins.zip > /dev/null

echo Installing mavern artifact
mvn install:install-file -Dfile=$NAME-bins/RXTXcomm.jar -DgroupId=$GROUP -DartifactId=$ARTIFACT -Dversion=$VERSION -Dpackaging=jar -DgeneratePom=true > /dev/null

echo Downloading sources of $NAME
wget -q http://rxtx.qbang.org/pub/rxtx/$NAME.zip

echo Preparing
unzip $NAME.zip > /dev/null
cd $NAME/src
find . -name "CVS" -type d -print | xargs rm -rf
jar cf src.jar ./gnu

echo Installing mavern artifact
mvn install:install-file -Dfile=src.jar -DgroupId=$GROUP -DartifactId=$ARTIFACT -Dversion=$VERSION -Dpackaging=jar -Dclassifier=sources > /dev/null

cd ../../
echo Cleanup
rm -rf $ARTIFACT* > /dev/null

echo Done
exit 0
