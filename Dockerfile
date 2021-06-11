FROM ubuntu:20.04

# sourceを使うためにbashに変更
RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh

RUN apt-get update;\
    apt-get install -y git ninja-build python3
RUN mkdir ${HOME}/tools;\
    cd ${HOME}/tools;\
    git clone https://github.com/espressif/esp-idf.git;\
    cd esp-idf;\
    git checkout release/v4.2;\
    git submodule update --init;\
    export IDF_PATH=${HOME}/tools/esp-idf;\
    ./install.sh;\
    . ./export.sh
RUN cd; git clone https://github.com/project-chip/connectedhomeip.git;\
    cd connectedhomeip;\
    git checkout c5fff8531346609d3e4e75ea4ab7efba2d90a7f0;\
    source ./scripts/bootstrap.sh;\
    source ./scripts/activate.sh

# bashからshに戻す
RUN rm /bin/sh && mv /bin/sh_tmp /bin/sh