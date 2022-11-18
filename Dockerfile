FROM node:14-bullseye-slim

ARG j1_dev_enabled=false

ENV JUPITERONE_DEV_ENABLED=$j1_dev_enabled
ENV JUPITERONE_INTEGRATION_DIR=/opt/jupiterone/integration

RUN apt-get update
RUN apt-get -y install g++ make python

COPY yarn.lock LICENSE ${JUPITERONE_INTEGRATION_DIR}/
COPY docker.package.json ${JUPITERONE_INTEGRATION_DIR}/package.json
COPY src/ ${JUPITERONE_INTEGRATION_DIR}/src
COPY scripts/ ${JUPITERONE_INTEGRATION_DIR}/scripts

WORKDIR  ${JUPITERONE_INTEGRATION_DIR}
RUN yarn install --production

CMD ["yarn", "execute"]