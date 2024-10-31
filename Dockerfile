FROM ubuntu:20.04

RUN apt-get update && \
	apt-get install -y \
	magic \
	ngspice \
	&& apt-get clean

ENTRYPOINT ["/bin/sh"]
