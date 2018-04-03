FROM alpine:3.7

ENV SERVER_ADDR     0.0.0.0
ENV SERVER_PORT     51344
ENV LOCAL_ADDR      0.0.0.0
ENV LOCAL_PORT      51344
ENV PASSWORD        psw
ENV METHOD          aes-128-cfb
ENV PROTOCOL        auth_aes128_md5
ENV OBFS            tls1.2_ticket_auth_compatible
ENV OBFS_PARAM      www.msn.com
ENV TIMEOUT         300
ENV DNS_ADDR        8.8.8.8
ENV DNS_ADDR_2      8.8.4.4

ARG BRANCH=manyuser
ARG WORK=~


RUN apk --no-cache add python \
    libsodium \
    wget


RUN mkdir -p $WORK && \
    wget -qO- --no-check-certificate https://github.com/zyt717/shadowsocksr/archive/$BRANCH.tar.gz | tar -xzf - -C $WORK


WORKDIR $WORK/shadowsocksr-$BRANCH/shadowsocks


EXPOSE $SERVER_PORT
CMD python local.py -s $SERVER_ADDR -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -b $LOCAL_ADDR -l $LOCAL_PORT -g $OBFS_PARAM
