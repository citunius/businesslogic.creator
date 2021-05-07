<img src="https://avatars.githubusercontent.com/u/83244875?s=400&v=4" width="50"/>

Business Logic - Creator
========================

This project contains the scripts to compile business logics for the [Business Bot Platform](https://www.citunius.de/). The creator script expects the source project (e.g. Git project) to compile it using Apache Ant. The output is a zip file (Business Logic file) runnable on the Business Bot platform.


Features/Benefits
-------------------
- Available on Windows and Linux (CentOS)
- Builds a business logic zip file runnable on the Business Bot Platform
- Checks for correct Java version
- Download and setup Apache Ant to build the business logic package

Please check out the [documentation](https://library.citunius.de/products/bbp_edition_community/) for
additional information on this project.

JDK 1.8 is required. Make sure your default JDK version is >=1.8
by typing `java -version`.


## Usage

1. Download this project
2. Put your business logic project into folder `<businesslogic.creator>/git`
3. Run compile script
4. Check log output and compiled business logic zip package in `<businesslogic.creator>/distrib`
5. Deploy business logic zip file on the Business Bot Platform

### Windows

```console

C:\businesslogic.creator> compile.bat
Provide the GIT repository path to the business logic: C:\businesslogic.creator\git\businesslogic.calculator

```

Example Output for business logic *businesslogic.calculator* on Windows:

```console

C:\businesslogic.creator>compile.bat
Check Java ...
[FOUND] Apache Ant in C:\businesslogic.creator\tools\apache-ant-1.10.10
BL: businesslogic.calculator # Size: 4920152
Provide the GIT repository path to the business logic: C:\businesslogic.creator\git\businesslogic.calculator
Create business logic package for ...
Buildfile: C:\businesslogic.creator\git\businesslogic.calculator\build.xml
     [echo] Started: 2021-05-03 10:58:20
     [echo] Passed Environment Variable: JAVA_HOME=C:\Program Files\AdoptOpenJDK\jdk-11.0.11.9-openj9\\lib
     [echo] Passed Environment Variable: tenantid=demo
     [echo] Passed Environment Variable: accountid=ALL_ACCOUNTS
     [echo] Project Version: 1.0.0
     [echo] Project Name: businesslogic.calculator
     [echo] Project Zip Output File: demo.ALL_ACCOUNTS.de.citunius.generic.calculator-1.0.0.zip

copyGitProject:
     [copy] Copying 33 files to C:\businesslogic.creator\source\businesslogic.calculator
     [copy] Copied 20 empty directories to 2 empty directories under C:\businesslogic.creator\source\businesslogic.calculator

clean:
     [echo] Removing old directory structure...

mkDeployDir:
    [mkdir] Created dir: C:\businesslogic.creator\staging\businesslogic.calculator\classes
    [mkdir] Created dir: C:\businesslogic.creator\staging\businesslogic.calculator\target\classes
    [mkdir] Created dir: C:\businesslogic.creator\staging\businesslogic.calculator\lib

updateLoggingFile:
     [echo] Updating logging.properties file ...

updateManifestFile:
     [echo] Updating MANIFEST.MF file ...

updatePluginPropertiesFile:
     [echo] Updating plugin.properties file ...

compile:
     [echo] Compiling ...
    [javac] Compiling 6 source files to C:\businesslogic.creator\staging\businesslogic.calculator\classes
    [javac] Note: org.pf4j.processor.ExtensionAnnotationProcessor init
    [javac] Note: Options {}
    [javac] Note: Processing @org.pf4j.Extension
    [javac] Note: C:\businesslogic.creator\source\businesslogic.calculator\src\de\citunius\businesslogic\calculator\botbuilder\ActionHandler.java uses or overrides a deprecated API.
    [javac] Note: Recompile with -Xlint:deprecation for details.
     [copy] Copying 9 files to C:\businesslogic.creator\staging\businesslogic.calculator\target\classes

copy:
     [copy] Copying 7 files to C:\businesslogic.creator\staging\businesslogic.calculator\lib
     [echo] Removing unwanted libs from Business Logic (used for development only)
   [delete] Deleting: C:\businesslogic.creator\staging\businesslogic.calculator\lib\log4j-1.2.15.jar
   [delete] Deleting: C:\businesslogic.creator\staging\businesslogic.calculator\lib\de.citunius.businesslogic.api-1.0.0.jar
     [copy] Copying 10 files to C:\businesslogic.creator\staging\businesslogic.calculator\resources
     [copy] Copying 1 file to C:\businesslogic.creator\staging\businesslogic.calculator\classes\META-INF
     [copy] Copying 1 file to C:\businesslogic.creator\staging\businesslogic.calculator\target\classes\META-INF
     [copy] Copying 1 file to C:\businesslogic.creator\staging\businesslogic.calculator
     [copy] Copying 1 file to C:\businesslogic.creator\staging\businesslogic.calculator

zipTarget:
      [zip] Building zip: C:\businesslogic.creator\staging\demo.ALL_ACCOUNTS.de.citunius.generic.calculator-1.0.0.zip

distrib:
     [copy] Copying 1 file to C:\businesslogic.creator\distrib

cleanup:
     [echo] Cleaning staging directory ...
   [delete] Deleting directory C:\businesslogic.creator\source\businesslogic.calculator
   [delete] Deleting directory C:\businesslogic.creator\staging

cleandist:

BUILD SUCCESSFUL
Total time: 4 seconds
##### Returncode: 0 #####
*******************************
[OK] Ant target exit normally
*******************************

C:\businesslogic.creator>

```

### Linux (CentOS)

```console

[user@server tmp]# compile.sh
Provide the GIT repository path to the business logic: /tmp/businesslogic.creator/git/businesslogic.calculator

```

Example Output for business logic *businesslogic.calculator* on Linux (CentOS):

```console

[user@server businesslogic.creator]# ./compile.sh
Check Java ...
/usr/bin/java
[OK] Found Java executable in PATH
version 1.8.0_232
[OK] Java version is higher than 1.8
[FOUND] Apache Ant in /tmp/businesslogic.creator/tools/apache-ant-1.10.10
Git folder contains following projects:
drwxr-xr-x 10 user user 217 May  3 13:55 /tmp/businesslogic.creator/git/businesslogic.calculator
drwxr-xr-x 10 user user 241 May  3 13:55 /tmp/businesslogic.creator/git/businesslogic.wikipedia
Provide the GIT repository path to the business logic: [q to quit]: /tmp/businesslogic.creator/git/businesslogic.calculator
[OK] Using business logic in /tmp/businesslogic.creator/git/businesslogic.calculator
Create business logic package for ...
Buildfile: /home/tmp/businesslogic.creator/git/businesslogic.calculator/build.xml
     [echo] Started: 2021-05-03 14:24:17
     [echo] Passed Environment Variable: JAVA_HOME=${env.JAVA_HOME}\lib
     [echo] Passed Environment Variable: tenantid=demo
     [echo] Passed Environment Variable: accountid=ALL_ACCOUNTS
     [echo] Project Version: 1.0.0
     [echo] Project Name: businesslogic.calculator
     [echo] Project Zip Output File: demo.ALL_ACCOUNTS.de.citunius.generic.calculator-1.0.0.zip

copyGitProject:
     [copy] Copying 33 files to /home/tmp/businesslogic.creator/source/businesslogic.calculator
     [copy] Copied 20 empty directories to 2 empty directories under /home/tmp/businesslogic.creator/source/businesslogic.calculator

clean:
     [echo] Removing old directory structure...

mkDeployDir:
    [mkdir] Created dir: /home/tmp/businesslogic.creator/staging/businesslogic.calculator/classes
    [mkdir] Created dir: /home/tmp/businesslogic.creator/staging/businesslogic.calculator/target/classes
    [mkdir] Created dir: /home/tmp/businesslogic.creator/staging/businesslogic.calculator/lib

updateLoggingFile:
     [echo] Updating logging.properties file ...

updateManifestFile:
     [echo] Updating MANIFEST.MF file ...

updatePluginPropertiesFile:
     [echo] Updating plugin.properties file ...

compile:
     [echo] Compiling ...
    [javac] Compiling 6 source files to /home/tmp/businesslogic.creator/staging/businesslogic.calculator/classes
    [javac] Note: org.pf4j.processor.ExtensionAnnotationProcessor init
    [javac] Note: Options {}
    [javac] Note: Processing @org.pf4j.Extension
     [copy] Copying 9 files to /home/tmp/businesslogic.creator/staging/businesslogic.calculator/target/classes

copy:
     [copy] Copying 7 files to /home/tmp/businesslogic.creator/staging/businesslogic.calculator/lib
     [echo] Removing unwanted libs from Business Logic (used for development only)
   [delete] Deleting: /home/tmp/businesslogic.creator/staging/businesslogic.calculator/lib/log4j-1.2.15.jar
   [delete] Deleting: /home/tmp/businesslogic.creator/staging/businesslogic.calculator/lib/de.citunius.businesslogic.api-1.0.0.jar
     [copy] Copying 10 files to /home/tmp/businesslogic.creator/staging/businesslogic.calculator/resources
     [copy] Copying 1 file to /home/tmp/businesslogic.creator/staging/businesslogic.calculator/classes/META-INF
     [copy] Copying 1 file to /home/tmp/businesslogic.creator/staging/businesslogic.calculator/target/classes/META-INF
     [copy] Copying 1 file to /home/tmp/businesslogic.creator/staging/businesslogic.calculator
     [copy] Copying 1 file to /home/tmp/businesslogic.creator/staging/businesslogic.calculator

zipTarget:
      [zip] Building zip: /home/tmp/businesslogic.creator/staging/demo.ALL_ACCOUNTS.de.citunius.generic.calculator-1.0.0.zip

distrib:
     [copy] Copying 1 file to /home/tmp/businesslogic.creator/distrib

cleanup:
     [echo] Cleaning staging directory ...
   [delete] Deleting directory /home/tmp/businesslogic.creator/source/businesslogic.calculator
   [delete] Deleting directory /home/tmp/businesslogic.creator/staging

cleandist:

BUILD SUCCESSFUL
Total time: 1 second

*******************************
[OK] Ant target exit normally
*******************************
[user@server businesslogic.creator]#


```

## Running
Once created, deploy the business logic package on the Business Bot Platform as documented [here](https://library.citunius.de/products/bbp_edition_community/documentation/R2021-FP2116/en/administration/botadministration/businesslogics/#add-business-logic-from-a-local-file).


## Business Bot Platform Documentation
For a more detailed documentation about the Business Bot Platform, please visit: [https://library.citunius.de/products/bbp_edition_community/](https://library.citunius.de/products/bbp_edition_community/) 


# History
Initial version by [Citunius GmbH](https://www.citunius.de/)

## License
This software is under [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

## Suggestions
Any suggestions are  welcome.