FROM alpine:3.13 AS agbuild

# copied from https://github.com/Ketouem/ag-alpine/blob/master/Dockerfile
RUN apk update && \
    apk add make git automake autoconf g++ pcre-dev xz-dev zlib-dev
RUN git clone --depth 1 --single-branch \
    --branch 2.2.0 https://github.com/ggreer/the_silver_searcher.git
WORKDIR ./the_silver_searcher
RUN CFLAGS="-fcommon -D_GNU_SOURCE -lpthread" ./build.sh

FROM alpine:3.13 AS devenv

RUN apk update && \
    apk add make zsh neovim git coreutils curl \
            python3 py-pip alpine-sdk python3-dev pcre-dev && \
    sed -i 's/ash/zsh/g' /etc/passwd && \
    pip install pynvim neovim

COPY --from=agbuild ./the_silver_searcher/ag .
RUN chmod +x ./ag && mv ./ag /usr/bin/.

ADD     . /root/Code/chr0n1x/dev-env
WORKDIR /root/Code/chr0n1x/dev-env
RUN     make

ENTRYPOINT ["zsh"]
