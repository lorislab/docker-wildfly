FROM jboss/wildfly:13.0.0.Final as build

ADD https://github.com/liquibase/liquibase/releases/download/liquibase-parent-3.6.2/liquibase-3.6.2-bin.tar.gz /opt/liquibase/

USER root
RUN mkdir /opt/database
RUN cd /opt/liquibase/ \
	&& tar -xvzf liquibase-*-bin.tar.gz \
	&& chown -R jboss:root /opt/liquibase/ \
        && cp /opt/liquibase/sdk/lib-sdk/slf4j-api-*.jar /opt/liquibase/lib \
        && rm -rf /opt/liquibase/sdk

FROM jboss/wildfly:13.0.0.Final

COPY --chown=jboss:root --from=build /opt/liquibase /opt/liquibase
