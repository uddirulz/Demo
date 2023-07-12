FROM alpine:3.18.2

RUN apk --no-cache add ca-certificates==20230506-r0 && \
    rm -rf /var/cache/apk/*
    
# Install PIP and Boto3 and AWS CLIRUN
RUN apk --no-cache add py3-pip==23.1.2-r0 && \
    rm -rf /var/cache/apk/* && \
    pip3 install --no-cache-dir awscli==1.27.163 && \
    pip3 install --no-cache-dir boto3==1.26.163
    pip3 install --no-cache-dir pandas
    pip3 install --no-cache-dir openpyxml
    
ENV JMETER_VERSION "5.6"
ENV JMETER_HOME "/opt/apache/apache-jmeter-${JMETER_VERSION}"
ENV JMETER_BIN "${JMETER_HOME}/bin"
ENV PATH "$PATH:$JMETER_BIN"

# Downloading JMeter 
RUN apk --no-cache add nss==3.91-r0 && \
    apk --no-cache add openjdk17-jre==17.0.7_p7-r1 curl==8.1.2-r0 unzip==6.0-r14 && \
    curl -L https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz --output /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
    curl -L https://jmeter-plugins.org/files/packages/jmeter-datadog-backend-listener-0.3.1.zip --output /tmp/datadog-backend-listener.zip && \
    curl -L https://jmeter-plugins.org/files/packages/tilln-junit-1.1.zip --output /tmp/junit-reporter.zip && \
    tar -zxf /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
    mkdir -p /opt/apache && \
    mv apache-jmeter-${JMETER_VERSION} /opt/apache && \
    unzip -o /tmp/datadog-backend-listener.zip -d ${JMETER_HOME} && \
    unzip -o /tmp/junit-reporter.zip -d ${JMETER_HOME} && \
    rm ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-*.jar && \
    rm /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
    rm /tmp/datadog-backend-listener.zip && \
    rm /tmp/junit-reporter.zip && \
    rm -rf /var/cache/apk/*
    
WORKDIR ${JMETER_HOME}

ENTRYPOINT ["sh"]
