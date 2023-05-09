FROM debian:latest

ARG FIVEM_VER
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY . /source/
WORKDIR /source/

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y zip
RUN apt install xz-utils git tar mc nano htop -y

# C# Part
RUN wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get update
RUN apt install apt-transport-https -y
RUN apt-get update
RUN apt install dotnet-sdk-6.0 -y

WORKDIR /fivem/
RUN wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/$FIVEM_VER/fx.tar.xz -O fx.tar.xz
RUN tar -xvf fx.tar.xz && rm fx.tar.xz

RUN git clone https://github.com/citizenfx/cfx-server-data.git server-data

RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN dpkg-reconfigure -p critical dash

RUN ln -s /source/server.cfg /fivem/server-data/server.cfg


RUN chmod +x /source/scripts/*.sh 
# Install BASE
RUN chmod +x /source/scripts/python.sh
RUN sh /source/scripts/python.sh
# Install BASE
RUN chmod +x /source/scripts/base.sh
RUN sh /source/scripts/base.sh

# Install QBCore
RUN chmod +x /source/scripts/qbcore.sh
RUN sh /source/scripts/qbcore.sh

RUN chmod +x /fivem/run.sh
RUN chmod +x /source/scripts/run.sh

CMD [ "/bin/sh", "-c", "/source/scripts/run.sh" ]
