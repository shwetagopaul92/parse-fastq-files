#!/usr/bin/env python

import os
import argparse
import math
import pylab as plt
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import matplotlib.patches as patches
import Bio 
from Bio import SeqIO

def plot_fastq_qualities(fastqfile, axis=None, limit=10000):
    res=[]
    b=0
    for record in SeqIO.parse(fastqfile, "fastq"):
        score=record.letter_annotations["phred_quality"]
        res.append(score)
        b+=1
        if b>limit:
            break
    df = pd.DataFrame(res)
    l = len(df.T)+1

    if axis == None:
        f, axis = plt.pyplot.subplots(figsize=(12,5))
    rect = patches.Rectangle((0,0), l, 20, linewidth=0, facecolor='r', alpha=.4)
    axis.add_patch(rect)
    rect = patches.Rectangle((0,20), l, 8, linewidth=0, facecolor='blue', alpha=.4)
    axis.add_patch(rect)
    rect = patches.Rectangle((0,28), l ,12 ,linewidth=0, facecolor='g', alpha=.4)
    axis.add_patch(rect)
    df.mean().plot(ax=axis,c='black')
    boxprops = dict(linestyle='-', linewidth=1, color='black')
    df.plot(kind='box', ax=axis, grid=False, showfliers=False,
            color=dict(boxes='black', whiskers='black')  )
    axis.set_xticks(np.arange(0, l, 5))
    axis.set_xticklabels(np.arange(0, l, 5))
    axis.set_xlabel('position')
    axis.set_xlim((0,l))
    axis.set_ylim((0,40))
    axis.set_title('quality score')
    plt.show() 
    return

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("file", type=argparse.FileType('rt'))
    args = parser.parse_args()
    fastq_file = args.file
    plot_fastq_qualities(fastq_file)

if __name__ == '__main__':
    main()