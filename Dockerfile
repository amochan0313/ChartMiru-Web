FROM ubuntu:18.04

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN apt-get update && \
apt-get -y upgrade && \
apt-get -y install \
net-tools \
iputils-ping \
net-tools \
iproute2 \
gnupg \
curl

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
apt-get -y upgrade && \
apt-get -y install yarn

RUN yarn global add vue vuex vue-cli nuxt

# コンテナ内で必要なスクリプトを実行
COPY docker-entrypoint.sh /usr/local/bin
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["tail", "-f", "/dev/null"]

# TODO:バージョンの固定
