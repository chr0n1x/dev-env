FROM alpine:3.7

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

WORKDIR    /root
ENTRYPOINT ["bash"]
