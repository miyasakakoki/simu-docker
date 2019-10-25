# Simutrans server

FROM ubuntu:latest as build-base

# install require packages
RUN apt-get update \
	&& apt-get install -y autoconf build-essential curl libbz2-dev libpng-dev libz-dev subversion unzip sed wget 

WORKDIR /tmp

RUN svn export --username anon  svn://servers.simutrans.org/simutrans/trunk@8588 
RUN mv trunk simutrans

# patch POSIX signal
RUN sed -i -e "s/Received SIGTERM, /Received SIGTERM\", \"/g" simutrans/simsys_posix.cc

# build simutrans
WORKDIR /tmp/simutrans
RUN autoconf \
	&& ./get_lang_files.sh \
	&& ./configure --enable-server \
	&& make -j8

RUN cp -r simutrans /opt/simutrans \
	&& cp sim /opt/simutrans

# get base pak
WORKDIR /opt/simutrans
RUN curl -L -o "/tmp/simupak.zip" "https://downloads.sourceforge.net/project/simutrans/pak64/120-4-1/simupak64-120-4-1.zip" \
	&& unzip /tmp/simupak.zip -d /opt/

# Packing the container
FROM ubuntu:latest
COPY --from=build-base /opt/simutrans /opt/simutrans
WORKDIR /opt/simutrans
ENV SIMUTRANS_PORT=13353
ENV SIMUTRANS_PAK="/opt/simutrans/pak"
ENV SIMUTRANS_SAVEGAME=""
ENV SIMUTRANS_SERVERNAMAE=""
RUN ./sim -server 13353 -lang ja -nosound -nomidi -log 1 -debug 3 -singleuser -objects pak  || echo "init fin....."
COPY start.sh ./start.sh

CMD ["/opt/simutrans/start.sh"]
