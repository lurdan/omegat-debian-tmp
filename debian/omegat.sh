#!/bin/sh

JAVA_OPTIONS='-Djava.library.path=/usr/lib/jni'

JAVA=$(which java | xargs readlink -f)

echo "$JAVA" | grep -e '(openjdk|sun)'
if [ $? -eq 0 ]
then
    JAVABIN=$JAVA
elif [ -x /usr/lib/jvm/java-6-openjdk/bin/java ]
then
    JAVABIN="/usr/lib/jvm/java-6-openjdk/bin/java"
elif [ -x /usr/lib/jvm/java-6-sun/bin/java ]
then
    JAVABIN="/usr/lib/jvm/java-6-sun/bin/java"
elif [ -x /usr/lib/jvm/java-1.5.0-sun/bin/java ]
then
    JAVABIN="/usr/lib/jvm/java-1.5.0-sun/bin/java"
else
    echo "Suitable java binary not found."
    exit 1
fi

exec $JAVABIN $JAVA_OPTIONS -jar /usr/share/java/OmegaT.jar $*
