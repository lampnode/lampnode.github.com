---
layout: post
title: "How to install tomcat7 on CentOS"
tagline: "How to install tomcat7 on CentOS"
description: ""
category: Linux 
tags: [CentOS, Linux, Tomcat, JAVA ]
---
{% include JB/setup %}

The purpose of this ducument is show you how to install and configurate Tomcat 7 on CentOS 6.x. JDK 1.8 should be installed firstly.


## Install JDK

### Download JDK 

You can download the JDK 1.8 from http://www.oracle.com. For example, If your CentOS is 64 bit, 
you should need jdk-8u40-linux-x64.rpm. Or, jdk-8u40-linux-i586.rpm
 
### installed by RPM

	$sudo rpm -ivh jdk-8u40-linux-x64.rpm

### Add specific profile 

	$sudo vim /etc/profile.d/java.sh


Add the following content to the file:


	#!/bin/bash
	export JAVA_HOME=/usr/java/jdk1.8.0_40
	export PATH=$JAVA_HOME/bin:$PATH
	export CLASSPATH=.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar

change the permission of java.sh

	$sudo chmod +x /etc/profile.d/java.sh

	$source /etc/profile.d/java.sh

### Test it

	$echo $JAVA_HOME
	$java -version


## Install and configurate Tomcat

### Download and check tomcat

You can download the lastest tomcat 7 from

	$wget http://apache.mirror.cdnetworks.com/tomcat/tomcat-7/v7.0.63/bin/apache-tomcat-7.0.63.tar.gz
 
You should verify the MD5 checksum for your downloaded package:

	$md5sum apache-tomcat-7.0.63.tar.gz

### Setup tomcat and run as a service

	$tar -xzvf apache-tomcat-7.0.63.tar.gz

	$sudo mv apache-tomcat-7.0.63 /usr/local/tomcat7

	$sudo vim /etc/init.d/tomcat

The shell script of tomcat:

	#!/bin/bash  
	JAVA_HOME=/usr/java/jdk1.8.0_40 
	export JAVA_HOME  
	PATH=$JAVA_HOME/bin:$PATH  
	export PATH  
	CATALINA_HOME=/usr/local/tomcat7  
  
	case $1 in  
	start)  
	sh $CATALINA_HOME/bin/startup.sh  
	;;   
	stop)     
	sh $CATALINA_HOME/bin/shutdown.sh  
	;;   
	restart)  
	sh $CATALINA_HOME/bin/shutdown.sh  
	sh $CATALINA_HOME/bin/startup.sh  
	;;   
	esac      
	exit 0

Then change the permission of this file:

	$sudo chmod 755 /etc/init.d/tomcat 

### start tomcat 

	$sudo /etc/init.d/tomcat start

Sample output:

	Using CATALINA_BASE:   /usr/local/tomcat7
	Using CATALINA_HOME:   /usr/local/tomcat7
	Using CATALINA_TMPDIR: /usr/local/tomcat7/temp
	Using JRE_HOME:        /usr/java/jdk1.8.0_40
	Using CLASSPATH:       /usr/local/tomcat7/bin/bootstrap.jar:/usr/local/tomcat7/bin/tomcat-juli.jar
	Tomcat started.

We can now access the Tomcat Manager page at: http://yourdomain.com:8080 or http://yourIPaddress:8080 and we should see the Tomcat home page.

### Add tomcat to chkconfig list

	sudo chkconfig --add tomcat
	sudo chkconfig tomcat on
	sudo chkconfig --list tomcat
	tomcat         	0:off	1:off	2:on	3:on	4:on	5:on	6:off

### Tomcat User management

For security reasons, no users or passwords are created for the Tomcat manager roles by default. In a production deployment, it is always best to remove the Manager application.To set roles, user name(s) and password(s), we need to configure the tomcat-users.xml file located at $CATALINA_HOME/conf/tomcat-users.xml.


We can set the manager-gui role, for example as below

	<!-- user manager can access only manager section -->
	<role rolename="manager-gui" />
	<user username="manager" password="_SECRET_PASSWORD_" roles="manager-gui" />

	<!-- user admin can access manager and admin section both -->
	<role rolename="admin-gui" />
	<user username="admin" password="_SECRET_PASSWORD_" roles="manager-gui,admin-gui" />

Note: the "_SECRET_PASSWORD_", should be really complex password.

## tomcat security options

### Run tomcat using Non-root user

For security resons, It is recommanded that you should run tomcat as non-root user, so, we need to do the following steps:

#### create tomcat user&group

	$sudo groupadd tomcat
	$sudo useradd -s /bin/bash -g tomcat tomcat

#### Change the permissions of  tomcat files to new user tomcat

	$sudo chown -Rf tomcat.tomcat /usr/local/tomcat7

#### Adjust the start/stop service script created above.


        #!/bin/bash
        JAVA_HOME=/usr/java/jdk1.8.0_40
        export JAVA_HOME
        PATH=$JAVA_HOME/bin:$PATH
        export PATH
        CATALINA_HOME=/usr/local/tomcat7

        case $1 in
        start)
        /bin/su tomcat $CATALINA_HOME/bin/startup.sh
        ;;
        stop)
        /bin/suo tomcat  $CATALINA_HOME/bin/shutdown.sh
        ;;
        restart)
        /bin/su tomcat $CATALINA_HOME/bin/shutdown.sh
        /bin/su tomcat $CATALINA_HOME/bin/startup.sh
        ;;
        esac
        exit 0

### Change default ROOT folder in Tomcat

Delete ROOT folder or rename ROOT. then,

	sudo ln -s yourapp ROOT

or,

	sudo mkdir ROOT

then add index.html to this folder,

	<html>
	<head>
		<title>Redirecting to /MYAPPLICATION</title>
	</head>
		<body onLoad="javascript:window.location='MYAPPLICATION';">
		</body>
	</html>


### Protecting the Shutdown Port

change the shutdown command in CATALINA_HOME/conf/server.xml and make sure that file is only readable by the tomcat user.

	<Server port="8005" shutdown="ReallyComplexWord">


### Changing the Tomcat Port

Locate server.xml in tomcat installation folder "conf\", and find following similar statement:

	<Connector port="8080" protocol="HTTP/1.1" 
	               connectionTimeout="20000" 
	               redirectPort="8443" />

You should change the commector port="8080" port to any other port number(Such as 8181). For example:

	<Connector port="8181" protocol="HTTP/1.1" 
	               connectionTimeout="20000" 
	               redirectPort="8443" />


### Remove Server Banner

Removeing server banner from http header. Add the following under Connector prot and save the file:

	Server =" "

Example:

	<Connector port="8080" protocol="HTTP/1.1" connectionTimeout="20000" Server=" " redirectPort="8443" />


### Replace default 404, 403, 500 page

Having default page for not found, forbidden, server error expose Tomcat version and that leads to security risk if you are running with vulnerable version. 

To mitigate, you can first create a general error page and configure web.xml to redirect to general error page. Go to the 
current application($tomcat/webapps/$application), create an error.jsp file:

	<html>
		<head> 
		<title>404-Page Not Found</title>
		</head>
	<body> That is an error! </body>
	</html>

then, go to "$tomcat/conf" folder, add the following in web.xml, and ensure the content before </web-app> syntax.

	<error-page> 
		<error-code>404</error-code> 
		<location>/error.jsp</location>
	</error-page>
	<error-page> 
		<error-code>403</error-code> 
		<location>/error.jsp</location>
	</error-page>
	<error-page> 
		<error-code>500</error-code> 
		<location>/error.jsp</location>
	</error-page>


You can do this for "java.lang.Exception" as well. This will help in not exposing tomcat version information 
if any java lang exception. Just add following in web.xml:

	<error-page> 
		<exception-type>java.lang.Exception</exception-type> 
		<location>/error.jsp</location>
	</error-page>

### Remove default/unwanted applications

By default Tomcat comes with following web applications, which may or not be required in production environment. 
You can delete them to keep it clean and avoid any known security risk with Tomcat default application.

 * ROOT – Default welcome page
 * Docs – Tomcat documentation
 * Examples – JSP and servlets for demonstration
 * Manager, host-manager – Tomcat administration



