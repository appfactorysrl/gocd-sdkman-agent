FROM gocd/gocd-agent-debian-11:v22.2.0

USER root

RUN apt-get update && apt-get install -y bash zip unzip curl wget && rm -rf /var/lib/apt/lists/*
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

USER go

RUN curl -s "https://get.sdkman.io" | bash
RUN source "$HOME/.sdkman/bin/sdkman-init.sh" \
        && sdk install java 11.0.16-amzn \
        && sdk install java 17.0.4-amzn \
        && sdk default java 11.0.16-amzn \
        && sdk install maven \
        && rm -rf $HOME/.sdkman/archives/* \
        && rm -rf $HOME/.sdkman/tmp/*

ENTRYPOINT ["/docker-entrypoint.sh"]
