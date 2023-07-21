Parse Fastq Files and Create Plot

Please follow the steps below to get started:

Docker Hub Image can be got from:

docker pull reshg/parse-fastq-files

To get started:

docker run reshg/parse-fastq-files:1.0 would throw a help message on how to use this image

Output: To use this image: docker run -v /hostdirectory_with_fastq_files:/data reshg/parse-fastq-files:1.0 ./parse_fastq.sh /data/read1.fastq /data/read2.fastq

To use your own image, follow these steps:

docker run -v $PWD:/data reshg/image_classifier:latest classify_image.py --model_dir /model --image_file /data/demo_images/imagename

Here we mount a host directory($PWD:/data) with our fastq.gz files to the docker container and specify the command to call the bash script and python script with required arguments.

For example, with the golden retriever dog image present in this repository, you could:

docker run -v $PWD:/data reshg/image_classifier:latest classify_image.py --model_dir /model --image_file /data/dog.jpg
