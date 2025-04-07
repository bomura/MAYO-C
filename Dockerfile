FROM ubuntu:24.04

RUN apt update \
&&  apt install -y \
    cmake \
    build-essential \
    checkinstall \
    zlib1g-dev \
    libssl-dev \
&& apt clean \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /mayo/build
COPY . /mayo
WORKDIR /mayo/build

RUN mkdir ref \
&&  cd ref \
&&  cmake -DMAYO_BUILD_TYPE=ref -DENABLE_AESNI=ON ../../CMakeLists.txt \
&&  make

RUN mkdir avx2 \
&&  cd avx2 \
&&  cmake -DMAYO_BUILD_TYPE=avx2 -DENABLE_AESNI=ON ../../CMakeLists.txt \
&&  make

CMD ["tail", "-f", "/dev/null"]
