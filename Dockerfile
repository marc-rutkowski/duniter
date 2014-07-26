FROM node
MAINTAINER Caner Candan <caner@candan.fr>

ENV PGP_KEY_TYPE	default
ENV PGP_KEY_LENGTH	default
ENV PGP_SUBKEY_TYPE	default
ENV PGP_SUBKEY_LENGTH	default
ENV PGP_REAL_NAME	docker_node
ENV PGP_COMMENT		it's a docker test node
ENV PGP_EMAIL		docker@docker
ENV PGP_EXPIRE_DATE	0
ENV PGP_PASSPHRASE	abc

ENV CURRENCY_NAME			test
ENV PORT_NUMBER				8033
ENV REMOTE_HOST				ucoin-test.xyz
ENV REMOTE_IPV4				0.0.0.0
ENV REMOTE_PORT				8033
ENV AMENDMENTS_DAEMON			ON
ENV AMENDMENTS_START			1406283438
ENV AMENDMENTS_FREQUENCY		86400
ENV UNIVERSAL_DIVIDEND_FREQUENCY	86400
ENV AMENDMENTS_CONSENSUS		0.67
ENV FIRST_UNIVERSAL_DIVIDEND_VALUE	100
ENV MONETARY_MASS_GROWTH_PERCENT	0.0074
ENV COMMUNITY_CHANGES_ALGORITHM		AnyKey

ENV MONGO_DB_NAME	ucoin_default

COPY share/docker/run.sh /usr/src/app/
COPY share/docker/setup.sh /usr/src/app/

ADD . /usr/src/app
WORKDIR /usr/src/app

RUN npm install . -g

EXPOSE 8033

CMD [ "sh", "run.sh" ]
