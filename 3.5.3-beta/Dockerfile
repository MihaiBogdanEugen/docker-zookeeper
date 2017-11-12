FROM mbe1224/debian-oracle-java:stretch-slim-jdk8

ENV LANG="C.UTF-8" \
    ZOOKEEPER_DATA_DIR="/var/lib/zookeeper/data" \
    ZOOKEEPER_DATA_LOG_DIR="/var/lib/zookeeper/log"

ARG PYTHON_VERSION=2.7.13-2
ARG PYTHON_PIP_VERSION=9.0.1
ARG ZOOKEEPER_DIST=zookeeper-3.5.3-beta
ARG ZOOKEEPER_SHA256_SUM=ff236bc10ac1fde0f8425debe38e690a952587941a5a334f9e5bd0480c204fe5

EXPOSE 2181 2888 3888

RUN echo "===> Updating debian ....." && \
    apt-get -qq update && \
    echo "===> Installing gnupg2 curl wget netcat python...." && \
    apt-get install -y apt-transport-https gnupg2 curl wget netcat python=${PYTHON_VERSION} && \
    echo "===> Installing python packages ..."  && \
    curl -fSL "https://bootstrap.pypa.io/get-pip.py" | python && \
    pip install --no-cache-dir --upgrade pip==${PYTHON_PIP_VERSION} && \
    pip install --no-cache-dir jinja2 requests && \
    echo "===> Downloading zookeeper ..."  && \
    wget -q "http://www.apache.org/dist/zookeeper/${ZOOKEEPER_DIST}/${ZOOKEEPER_DIST}.tar.gz" && \
    echo "===> Verifying zookeeper ..."  && \
    echo "${ZOOKEEPER_SHA256_SUM}" "${ZOOKEEPER_DIST}.tar.gz" | sha256sum -c - && \
    wget -q "http://www.apache.org/dist/zookeeper/${ZOOKEEPER_DIST}/${ZOOKEEPER_DIST}.tar.gz.asc" && \
    wget -q "http://apache.org/dist/zookeeper/KEYS" && \
    export GNUPGHOME="$(mktemp -d)" && \
    gpg --import KEYS && \
    gpg --batch --verify "${ZOOKEEPER_DIST}.tar.gz.asc" "${ZOOKEEPER_DIST}.tar.gz" && \
    echo "===> Unpacking zookeeper ..."  && \
    tar -xzf "${ZOOKEEPER_DIST}.tar.gz" -C /opt && \
    rm -r "$GNUPGHOME" "${ZOOKEEPER_DIST}.tar.gz" "${ZOOKEEPER_DIST}.tar.gz.asc" && \
    echo "===> Shortcut created for install folder ..."  && \
    ln -s /opt/$ZOOKEEPER_DIST /opt/zookeeper && \
    echo "===> Removing extra files ..."  && \
    rm -rf  "/opt/zookeeper/bin/README.txt" \
            "/opt/zookeeper/bin/"*.cmd \
            "/opt/zookeeper/conf/configuration.xsl" \
            "/opt/zookeeper/conf/log4j.properties" \
            "/opt/zookeeper/conf/zoo_sample.cfg" \
            "/opt/zookeeper/contrib" \
            "/opt/zookeeper/dist-maven" \
            "/opt/zookeeper/docs" \
            "/opt/zookeeper/lib/cobertura/README.txt" \            
            "/opt/zookeeper/recipes" \
            "/opt/zookeeper/src" \    
            "/opt/zookeeper/build.xml" \
            "/opt/zookeeper/ivy.xml" \
            "/opt/zookeeper/ivysettings.xml" \            
            "/opt/zookeeper/NOTICE.txt" \
            "/opt/zookeeper/README_packaging.txt" \
            "/opt/zookeeper/README.txt" \
            "/opt/zookeeper/$ZOOKEEPER_DIST.jar.asc" \
            "/opt/zookeeper/$ZOOKEEPER_DIST.jar.md5" \
            "/opt/zookeeper/$ZOOKEEPER_DIST.jar.sha1" && \
    apt-get autoremove -y gnupg2 wget && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p $ZOOKEEPER_DATA_DIR $ZOOKEEPER_DATA_LOG_DIR /usr/share/zookeeper /tmp/zookeeper /usr/etc/ /opt/zookeeper/tools /opt/zookeeper/tools/templates && \
    ln -s /opt/zookeeper/conf/ /usr/etc/zookeeper && \
    ln -s /opt/zookeeper/bin/* /usr/bin && \
    ln -s /opt/zookeeper/$ZOOKEEPER_DIST.jar /usr/share/zookeeper/ && \
    ln -s /opt/zookeeper/lib/* /usr/share/zookeeper

COPY "/include/opt/zookeeper/tools/templates/"*.template /opt/zookeeper/tools/templates/
COPY "/include/opt/zookeeper/tools/"*.sh /opt/zookeeper/tools/
COPY /include/usr/local/bin/dub.py /usr/local/bin/dub

RUN chmod a+x "/opt/zookeeper/tools/"*.sh && \
    chmod a+x "usr/local/bin/dub"

CMD ["/opt/zookeeper/tools/run.sh"]