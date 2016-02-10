FROM armhfbuild/alpine:3.3
MAINTAINER Taylor McClure github.com/taylorsmcclure

ENV NODE_VER=4.2.4-r1 \
    PYTHON_VER=2.7.11-r3 \
    GIT_VER=2.6.4-r0  \
    AWSCLI_VER=1.10.0 \
    PIP_VER=7.1.2-r0 \
    G_VER=5.3.0-r0  \
    MAKE_VER=4.1-r0 \
    LIBXML2_VER=2.9.3-r0 \
    S3_BUCKET= \
    AWS_ACCESS= \
    AWS_SECRET=

RUN apk update \
    && apk add --no-cache --virtual temp-pkgs g++=$G_VER make=$MAKE_VER libxml2-dev=$LIBXML2_VER git=$GIT_VER py-pip=$PIP_VER \
    && pip install awscli==$AWSCLI_VER \
    && apk add --no-cache python=$PYTHON_VER nodejs=$NODE_VER \
    && mkdir -p /discordbot \
    && addgroup -S discordbot \
    && adduser -h /discordbot -s /sbin/nologin -S discordbot -g discordbot \
    && git clone https://github.com/chalda/DiscordBot.git /discordbot \
    && mkdir -p /root/.aws \
    && touch /root/.aws/credentials \
    && echo -e "[default]\naws_access_key_id=$AWS_ACCESS\naws_secret_access_key=$AWS_SECRET" > /root/.aws/credentials \
    && aws s3 cp s3://$S3_BUCKET/discord/auth.json /discordbot/auth.json \
    && pip uninstall --yes awscli \
    && rm -rf /root/.aws \
    && npm i /discordbot \
    && cp -rf /node_modules/DiscordBot/* /discordbot/ \
    && chown -R discordbot:discordbot /discordbot \
    && rm -rf /node_modules \
    && apk del --purge temp-pkgs

USER discordbot
WORKDIR "/discordbot"
ENTRYPOINT ["/usr/bin/node", "discord_bot.js"]
