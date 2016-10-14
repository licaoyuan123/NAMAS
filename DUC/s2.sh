#!/bin/bash

echo "Step 1: Extracting DUC files"
cd $1
tar xvf DUC2003_Summarization_Documents.tgz
tar xvf DUC2004_Summarization_Documents.tgz
tar xvf duc2004_results.tgz
tar xvf detagged.duc2003.abstracts.tar.gz

cd duc2004_results/ROUGE/; tar xvf duc2004.task1.ROUGE.models.tar.gz
cd ..
cd ..
cd DUC2003_Summarization_Documents/duc2003_testdata/task1/; tar xvf task1.docs.tar.gz
cd ..
cd ..
cd ..
cd ..

echo "Step 2: Make reference files."

mkdir $1/clean_2004/
mkdir $1/clean_2004/references
mkdir $1/clean_2004/system

echo "Where am I?"
pwd

python DUC/make_DUC.py --result_docs DUC_data/duc2004_results/ROUGE/eval/models/1/ \
    --sum_docs DUC_data/DUC2004_Summarization_Documents/duc2004_testdata/tasks1and2/duc2004_tasks1and2_docs/docs/ \
    --ref_dir DUC_data/clean_2004/references --year 2004 --article_file DUC_data/clean_2004/input.txt \
    --sys_dir DUC_data/clean_2004/system
echo "Where am I?"
pwd

mkdir $1/clean_2003/
mkdir $1/clean_2003/references
mkdir $1/clean_2003/system
python DUC/make_DUC.py --result_docs DUC_data/detagged.duc2003.abstracts/models/ \
    --sum_docs DUC_data/DUC2003_Summarization_Documents/duc2003_testdata/task1/docs.without.headlines/  \
    --ref_dir DUC_data/clean_2003/references --year 2003 --article_file DUC_data/clean_2003/input.txt \
    --sys_dir DUC_data/clean_2003/system

