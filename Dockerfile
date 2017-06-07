FROM java:8-jdk

MAINTAINER NGINX Ronald Roy "rjr.redmage@gmail.com"

# Update for new versions
ENV SCALA_VERSION 2.11.11
ENV SBT_VERSION 0.13.15

# Install Scala
## Piping curl directly in tar
RUN \
  curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

# Install scala-ide
RUN \
	curl -O -L http://downloads.typesafe.com/scalaide-pack/4.1.0-vfinal-luna-211-20150525/scala-SDK-4.1.0-vfinal-2.11-linux.gtk.x86_64.tar.gz \
	tar xzvf scala-SDK-4.1.0-vfinal-2.11-linux.gtk.x86_64.tar.gz \
	rm scala-SDK-4.1.0-vfinal-2.11-linux.gtk.x86_64.tar.gz

WORKDIR /eclipse

CMD ./eclipse
