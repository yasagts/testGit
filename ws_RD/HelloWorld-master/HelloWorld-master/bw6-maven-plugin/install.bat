echo Installing Maven Plugin to Maven Repository

start cmd.exe /C mvn install:install-file -Dfile=com.tibco.bw.palette.shared_6.1.100.003.jar -DgroupId=com.tibco.plugins -DartifactId=com.tibco.bw.palette.shared -Dversion=6.1.100 -Dpackaging=jar

start cmd.exe /C mvn install:install-file -Dfile=com.tibco.xml.cxf.common_1.3.200.001.jar -DgroupId=com.tibco.plugins -DartifactId=com.tibco.xml.cxf.common -Dversion=1.3.200 -Dpackaging=jar

start cmd.exe /C mvn install:install-file -Dfile=bw6-maven-plugin-2.0.1.jar -DpomFile=pom.xml

start cmd.exe /C mvn install:install-file -Dfile=fabric8/fabric8-maven-plugin-2.2.102.jar -DpomFile=fabric8/pom.xml




