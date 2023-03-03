- For the IZICAP project, we are using jdk 17 and updated some line of the dockerfile
FROM openjdk:17
EXPOSE 8080/tcp
ARG JAR_FILE=target/izicap-api.jar izicap-api.jar
COPY ${JAR_FILE} izicap-api.jar
ENTRYPOINT ["java","-jar","/izicap-api.jar"]

- Add a filename inside a pom.xlm
<finalName>izicap-api</finalName>

- Each project have a Jenkinsfile which will be used inside a Jenkins job.

- Like we have tow project, we will need 2 Jobs, the first to build a docker image of project, the second to build image of TA project and run the two image inside a docker container to run the test. 
The two project will be checkout on github:

Project : https://github.com/njartiana/IZICAP
TA : https://github.com/njartiana/Test_auto_izicap

***** How to run the code? *****
Create 2 jobs in pipeline option. Use Pipeline script from SCM to use Jenkinsfile.
The first will be named : Java_API_IZICAP_JOB and the second : TA_IZICAP_Robot_Framework. By using these 2 name, you don't need to touch on the Jenkinsfiles but just runing the project.
NB : 
The TA_IZICAP_Robot_Framework will be called automaticly by Java_API_IZICAP_JOB at the end of the build and the test will be start after.
At the end of the build, all container will be stoped and deleted. The image of the projects also
