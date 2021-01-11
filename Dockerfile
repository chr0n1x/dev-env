FROM alpine:3.8

# first line of adds are for hg, rest for vim
RUN apk update && \
    apk add automake autoconf g++ pcre-dev xz-dev zlib-dev \
            bash curl git make vim python3 python3-dev alpine-sdk && \
    pip3 install --user msgpack pynvim

# copied from https://github.com/Ketouem/ag-alpine/blob/master/Dockerfile
RUN git clone --depth 1 --single-branch \
    --branch 2.2.0 https://github.com/ggreer/the_silver_searcher.git
WORKDIR ./the_silver_searcher
RUN ./build.sh && chmod +x ./ag && mv ./ag /usr/bin/.

ADD     . /root/tmp
WORKDIR /root/tmp
RUN     make hard-install && rm -rf /root/.vimrc-install-bootstrap /root/tmp

ENTRYPOINT ["bash"]
