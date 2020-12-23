FROM steamcmd/steamcmd AS steambuild
LABEL maintainer="helightdev@gmail.com"

ARG SYNAPSE_VERSION="v.2.3.2"
ARG MULTIADMIN_VERSION="3.3.0"
ARG APPID=996560
USER root
RUN mkdir -p /scpsl
RUN apt-get update && apt-get install wget unzip -y
RUN steamcmd +login anonymous +force_install_dir /scpsl \
    +app_update $APPID validate +quit
RUN wget https://github.com/SynapseSL/Synapse/releases/download/$SYNAPSE_VERSION/Synapse2.zip && unzip -d /buf/ Synapse2.zip
RUN wget https://github.com/ServerMod/MultiAdmin/releases/download/$MULTIADMIN_VERSION/MultiAdmin.exe && mv ./MultiAdmin.exe /scpsl

FROM mono AS runner
RUN apt-get update && apt-get upgrade -y
RUN groupadd -r scpsl && useradd -rmg scpsl scpsl
COPY --chown=scpsl:scpsl --from=steambuild /scpsl /scpsl
COPY --chown=scpsl:scpsl --from=steambuild /buf /buf
RUN mkdir /Synapse /vancfg && chown -hR scpsl:scpsl /Synapse /vancfg
VOLUME /Synapse
VOLUME /vancfg
USER scpsl
RUN mkdir -p /home/scpsl/.config/"SCP Secret Laboratory"/config ~/.config/
RUN ln -s /Synapse /home/scpsl/.config/Synapse
RUN ln -s /vancfg /home/scpsl/.config/"SCP Secret Laboratory"/config/7777
RUN mv buf/Assembly-CSharp.dll /scpsl/SCPSL_Data/Managed/Assembly-CSharp.dll
RUN cp -R /buf/Synapse/. /Synapse

WORKDIR /scpsl
EXPOSE 7777/udp
ENTRYPOINT cp -nR /buf/Synapse/. /Synapse && mono MultiAdmin.exe -p 7777