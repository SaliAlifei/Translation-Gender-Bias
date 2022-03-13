FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y && apt-get clean

# c++
RUN apt-get -y install clang

# cmake
RUN apt-get update && apt-get -y install cmake protobuf-compiler

RUN apt-get install -y libgoogle-perftools-dev libsparsehash-dev

WORKDIR /usr/src/app

COPY ./ ./

### Install fast_align

WORKDIR /usr/src/app/fast_align

RUN mkdir build

WORKDIR /usr/src/app/fast_align/build

RUN cmake ..
RUN make

ENV FAST_ALIGN_BASE='/usr/src/app/fast_align'


### Install mt_gender

# Python package management and basic dependencies
RUN apt-get install -y curl python3.7 python3.7-dev python3.7-distutils

# Register the version in alternatives
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1

# Set python 3 as the default python
RUN update-alternatives --set python /usr/bin/python3.7

# Upgrade pip to latest version
RUN curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py --force-reinstall && \
    rm get-pip.py


RUN python3.7 -m pip install docopt 
RUN python3.7 -m pip install tqdm
RUN python3.7 -m pip install spacy==2.2.3
RUN python3.7 -m pip install mosestokenizer

RUN python3.7 -m spacy download en
RUN python3.7 -m spacy download de
RUN python3.7 -m spacy download it
RUN python3.7 -m spacy download es
RUN python3.7 -m spacy download fr

RUN apt-get install -y git
RUN python3.7 -m pip install git+https://github.com/kmike/pymorphy2
RUN python3.7 -m pip install pymorphy2-dicts-ru
RUN python3.7 -m pip install pymorphy2-dicts-uk

RUN python3.7 -m pip install ufal.morphodita

RUN python3.7 -m pip install google-cloud-translate==1.7.0
RUN python3.7 -m pip install boto3

WORKDIR /usr/src/app/mt_gender/src

#CMD ../scripts/evaluate_all_languages.sh ../data/aggregates/en.txt ../output1
#CMD ../scripts/evaluate_all_languages.sh ../data/aggregates/en_pro.txt ../output2
#CMD ../scripts/evaluate_all_languages.sh ../data/aggregates/en_anti.txt ../output3