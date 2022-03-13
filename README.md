# Evaluating Gender Bias in Machine Translation

This repository contains code and data for reproducing the experiments in [Evaluating Gender Bias in Machine Translation]

## Requirements
Install [Docker Desktop](https://docs.docker.com) on your machine.

Create an account and activate the translation service for :
* [Google Cloud](https://cloud.google.com)
* [Microsoft Azure](https://azure.microsoft.com) 
* [Amazon Web Services](https://aws.amazon.com)

## Installation

##### Set the environment variables  

* From Google Cloud, get the credentials json file and add it on this repository root. Set the environnment variable with the file name :
GOOGLE_APPLICATION_CREDENTIALS=/usr/src/app/

* From Microsoft Azure get the api key. Set the environnment variable :
BING_TRANSLATOR_TEXT_KEY=

* From Amazon Web Service get the api keys.  Set the environnment variables :
AWS_DEFAULT_REGION=
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=


##### Build the container
* To build the container, run on the console :

        docker build -t project-image .

## Running our experiments 

* For the general gender accuracy number, run:

        docker run [-e ENVIRONMENT VARIABLES] project-image ../scripts/evaluate_all_languages.sh ../data/aggregates/en.txt ../output1

* For evaluating *pro*-sterotypical translations, run:

        docker run [-e ENVIRONMENT VARIABLES] project-image ../scripts/evaluate_all_languages.sh ../data/aggregates/en_pro.txt ../output2

* For evaluating *anti*-sterotypical translations, run:

                docker run [-e ENVIRONMENT VARIABLES] project-image ../scripts/evaluate_all_languages.sh ../data/aggregates/en_anti.txt ../output3