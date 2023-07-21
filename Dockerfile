# pull base docker image
FROM ubuntu:20.04

# maintainer details
MAINTAINER Shweta Gopal "shwetagopaul92@gmail.com" 

# copy source files
COPY . /opt/

# unzip first fastq.gz file
RUN gunzip /opt/read1.fastq.gz 

# unzip second  fastq.gz file
RUN gunzip /opt/read2.fastq.gz

# set working directory
WORKDIR /opt 

# install dependencies; run trimmomatic to remove adapter sequences
RUN apt-get update -y
RUN apt-get install -y libx11-dev
RUN apt-get install -y python3-tk
RUN apt-get install -y software-properties-common
RUN apt-get install -y python
RUN apt-get install -y python3-pip
RUN pip3 install -r requirements.txt
#RUN apt-get install fastqc
#RUN apt-get install trimmomatic

# copy the shell script into bin directory
COPY parse_fastq.sh /usr/local/bin

# make the shell script executable
RUN ["chmod", "+x", "/usr/local/bin/parse_fastq.sh"]

# set environment variable path to detect python executable script
ENV PATH="/usr/local/bin:${PATH}"

# set the command to display a help message on how to use this image
CMD echo "To use this image: docker run -v /hostdirectory_with_fastq_files:/data reshg/parse-fastq-files /usr/local/bin/parse_fastq.sh /data/read1.fastq /data/read2.fastq -o report.txt"





