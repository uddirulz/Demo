FROM alpine:latest

RUN apk  add --update && \
    apk  upgrade && \
    apk add ca-certificates && \
    update-ca-certificates

# Install PIP and Boto3 and AWS CLI
RUN apk add py3-pip
RUN pip3 install boto3
RUN pip3 install awscli==1.27.160

ENV JMETER_VERSION "5.5"
ENV JMETER_HOME "/opt/apache/apache-jmeter-${JMETER_VERSION}"
ENV JMETER_BIN "${JMETER_HOME}/bin"
ENV PATH "$PATH:$JMETER_BIN"

# Downloading JMeter
 RUN apk --no-cache add nss && \
     apk add --update openjdk11-jre curl unzip && \
     curl -L https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz --output /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
     tar -zxf /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
     mkdir -p /opt/apache && \
     mv apache-jmeter-${JMETER_VERSION} /opt/apache && \
     rm /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
     rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
