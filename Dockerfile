FROM ubuntu

RUN apt-get update

RUN apt install -y python3.10
RUN apt install -y python3-pip

ENV WAIT_VERSION 2.9.0
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/$WAIT_VERSION/wait /wait
RUN chmod +x /wait

#RUN apt mkdir "Results"
#ARG REPORT_FILE=./Results
#COPY ${REPORT_FILE} ./Results

#COPY . /app
#WORKDIR /app

RUN pip install -r requirements.txt


CMD /wait && robot --outputdir Results TestCases/ManageTokens/TokenCreationTest.robot TestCases/ManageUsers/UserCreationTest.robot
#ENTRYPOINT robot --outputdir Results TestCases/
