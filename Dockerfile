FROM ubuntu

WORKDIR /opt

RUN apt-get update -y
RUN apt-get install wget gcc make -y
RUN apt-get install libdb-dev libncurses5-dev libgmp-dev autoconf -y

RUN wget https://s3.amazonaws.com/morecobol/gnucobol-3.0-rc1/gnucobol-3.0-rc1.tar.gz \
         https://s3.amazonaws.com/morecobol/gnucobol-3.0-rc1/gnucobol-3.0-rc1.tar.gz.sig \
         https://ftp.gnu.org/gnu/gnu-keyring.gpg
#RUN gpg --verify --keyring ./gnu-keyring.gpg gnucobol-3.0-rc1.tar.gz.sig
RUN tar zxf gnucobol-3.0-rc1.tar.gz

WORKDIR gnucobol-3.0-rc1
RUN ./configure
RUN make
RUN make install
RUN make check
RUN ldconfig

RUN mkdir /neopragma
COPY * /neopragma/

RUN mkdir /neopragma/src

RUN mkdir /neopragma/upload
COPY upload /neopragma/upload


WORKDIR /neopragma

VOLUME ["/neopragma/src"]
CMD ./run-examples