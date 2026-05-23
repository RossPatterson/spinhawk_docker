# Dockerfile for a container to run Hercules 3.x "Spinhawk" 

# We're pinned to 24.04 "noble" because later GCC versions can't compile
# Spinhawk.
FROM ubuntu:noble

RUN apt-get update && \
	apt-get install --no-install-recommends -y \
		autoconf automake bash build-essential ca-certificates dos2unix \
		gawk git libbz2-dev m4 unzip wget zip zlib1g-dev

# Build Hercules
RUN <<EOF
	set -x
	set -e

    mkdir -p ~/build_herc
    cd ~/build_herc
    git clone https://github.com/RossPatterson/spinhawk.git
    cd spinhawk
	# This branch is Release 3.13 + fix for Hyperion Issue 782.
	git switch h_0782
	git log HEAD...release-3.13
    ./util/bldlvlck
	chmod a+x autogen.sh
    ./autogen.sh
    ./configure --prefix=/usr/local/hercules
    make
    make check
    make install
    cd
    rm -rf ~/build_herc
    echo "export PATH=\"\$PATH:/usr/local/hercules/bin\"" > /usr/local/hercules/setup.sh
    echo "export LD_LIBRARY_PATH=\"\${LD_LIBRARY_PATH:+LD_LIBRARY_PATH:}/usr/local/hercules/lib\"" >> /usr/local/hercules/setup.sh
EOF

WORKDIR     /usr/local/hercules/
EXPOSE      3270 8038 3505
ENTRYPOINT  ["bash"]
