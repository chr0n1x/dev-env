FROM alpine:3.8

RUN apk update
RUN apk add bash curl git make vim

# vim & dein setup
ADD vimrc /root/.vimrc
RUN curl \
    https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh \
    > /root/installer.sh
RUN sh /root/installer.sh /root/.cache/dein && rm /root/installer.sh

ADD temp-vimrc /root/temp-vimrc
RUN vim --not-a-term -n -u /root/temp-vimrc -c "silent! call dein#install()|q"
RUN vim --not-a-term -n -u /root/.vimrc -c "silent! call dein#install()|q"
RUN rm /root/temp-vimrc

# copied from https://github.com/Ketouem/ag-alpine/blob/master/Dockerfile
RUN apk --update add git automake autoconf make g++ pcre-dev xz-dev
RUN git clone --depth 1 --single-branch --branch 2.0.0 https://github.com/ggreer/the_silver_searcher.git
WORKDIR ./the_silver_searcher
RUN ./build.sh
RUN chmod +x ./ag && mv ./ag /usr/bin/.

WORKDIR    /root
ENTRYPOINT ["bash"]
