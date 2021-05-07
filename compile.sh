#!/bin/bash

# -----------------------------------------------------
# Citunius GmbH - 01.05.2021
# Program to compile business logics from GIT project
# -----------------------------------------------------

# -----------------------------------------------------------------------------------------------
# ----- Global variables
# -----------------------------------------------------------------------------------------------
DEFAULT_TENANTID=demo
DEFAULT_ACCOUNTID=ALL_ACCOUNTS
ANT_VERSION=1.10.10
ANT_DOWNLOAD_URL=https://downloads.apache.org/ant/binaries/apache-ant-$ANT_VERSION-bin.zip
TOOLS_DIR=tools
CURRENT_DIR=$(pwd)
ANT_HOME=$CURRENT_DIR/$TOOLS_DIR/apache-ant-$ANT_VERSION
GIT_HOME=$CURRENT_DIR/git

# -----------------------------------------------------------------------------------------------
# ----- Script body
# -----------------------------------------------------------------------------------------------
# Creating tools dir ...
[ ! -d "$CURRENT_DIR/$TOOLS_DIR" ] && mkdir -p "$CURRENT_DIR/$TOOLS_DIR"

echo Check Java ...
# Check JAVA_HOME variable
if type -p java; then
    echo "[OK] Found Java executable in PATH"
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo "[OK] Found java executable in JAVA_HOME"  
    _java="$JAVA_HOME/bin/java"
else
    echo "[ERROR] Java not found"
	exit 1
fi

# Check Java version
if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" > "1.8" ]]; then
        echo "[OK] Java version is higher than 1.8"
    else         
        echo "[ERROR] Java version is less than 1.8"
		exit 1
    fi
fi

# Install Apache Ant
if [ ! -d "$ANT_HOME" ] 
then
    echo "[NOT FOUND] Apache Ant" 
    echo Downloading Apache Ant ...
	wget -qc "$ANT_DOWNLOAD_URL" -O "${TOOLS_DIR}/apache-ant.zip"
	unzip -d ${TOOLS_DIR} "${TOOLS_DIR}/apache-ant.zip"
else
    echo [FOUND] Apache Ant in $ANT_HOME
fi


if find "$GIT_HOME" -mindepth 1 -print -quit 2>/dev/null | grep -q .; then
    echo "Git folder contains following projects:"
	ls -ald $GIT_HOME/*
else
    echo [WARNING] Git folder $GIT_HOME is empty. Checkout your business logic into this folder to compile.
fi

# Ask for business logic path
promptFile()
{
    local path

    while true
    do
        read -p "Provide the GIT repository path to the business logic: [q to quit]: " path
        if [ "$path" == q ]; then
            echo "Exiting.." >&2
            return 1
        fi

        if [ ! -f "$path/build.xml" ]; then
            echo "[ERROR] File $path/build.xml does not exist, check your path and try again" >&2
        else
			echo $path # This return the path
            break
        fi
    done
}

tempLoc=$(promptFile)
if [ -n "$tempLoc" ]; then
   BUSINESSLOGIC_PATH=$tempLoc
   echo "[OK] Using business logic in $BUSINESSLOGIC_PATH"
else
	exit 1
fi 


# Compile Business Logic
cd $BUSINESSLOGIC_PATH
echo Create business logic package for ...
$ANT_HOME/bin/ant -Dtenantid=$DEFAULT_TENANTID -Daccountid=$DEFAULT_ACCOUNTID
retVal=$?
echo ##### Returncode: $retVal #####
if [ $retVal -ne 0 ]; then
    echo "*******************************"
	echo "[ERROR] Ant target failed"
	echo "*******************************"
else
    echo "*******************************"
	echo "[OK] Ant target exit normally"
	echo "*******************************"
fi
exit $retVal

# -----------------------------------------------------------------------------------------------
# ----- END: Script body
# -----------------------------------------------------------------------------------------------

# EXIT
