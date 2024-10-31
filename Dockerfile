FROM ubuntu:20.04

RUN apt-get update && \
	apt-get install -y \
	magic \
	ngspice \
	imagemagick \
	ghostscript \
	python3 \
	python3-matplotlib \
	python3-numpy \
	&& apt-get clean

RUN sed -i 's/<policy domain="coder" rights="none" pattern="PS" \/>/<policy domain="coder" rights="read|write" pattern="PS" \/>/' /etc/ImageMagick-6/policy.xml

ENTRYPOINT ["/bin/sh"]
