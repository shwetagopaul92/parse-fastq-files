#!/bin/sh 
read1="$1"
read2="$2"

# find number of molecules sequenced in read2
echo 'Number of molecules sequenced in read1.fastq is:' >> report.txt
echo $(cat $read1|wc -l)/4 >> report.txt 

# find number of molecules sequenced in read1
echo 'Number of molecules sequenced in read2.fastq is:' >> report.txt
echo $(cat $read2|wc -l)/4 >> report.txt

# find read1 and index length
echo 'Read1 length:' >> report.txt
awk '{if(NR%4==2) {count++; bases += length} } END{print bases/count}' $read1 
echo 'First Index of read1 is:' >> report.txt
grep '^@M00' $read1 | cut -d : -f 10 | sort | head -n 1 >> report.txt

# find read2 and index length
echo 'Read2 length:' >> report.txt
awk '{if(NR%4==2) {count++; bases += length} } END{print bases/count}' $read2 >> report.txt
echo 'First Index of read2 is:'>> report.txt 
grep '^@M00' $read2 | cut -d : -f 10 | sort | head -n 1 >> report.txt 

# find library type
echo 'Nextera' >> report.txt 

# plot fastq file
python plot_fastq.py $read1
python plot_fastq.py $read2