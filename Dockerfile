FROM rocker/verse:3.5.0


RUN apt-get update && apt-get install -y \
        bzr \
        gnupg2 \
        cvs \
        git \
        curl \
        mercurial \
        subversion \
        git-core \
        libssl-dev \
        libcurl4-gnutls-dev

RUN apt-get update -qq && apt-get install -y 


## RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y

ARG MRAN="https://cran.microsoft.com/snapshot/2020-04-10/"
RUN install2.r -d TRUE -r ${MRAN} -- plumber

COPY [".", "./apiaah"]
ENTRYPOINT ["Rscript", "-e", " pr <- plumber::plumb(commandArgs(trailingOnly=TRUE)[1]); pr$run(host='0.0.0.0', port=as.numeric(Sys.getenv('PORT')))"]
CMD ["apiaah/api.R"]
