FROM alpine:3.16
LABEL maintainer="Walter Leibbrandt"
LABEL version="0.4.3"
EXPOSE 8080

ARG PVPN_CLI_VER=2.2.12
ENV PVPN_USERNAME=${PVPN_USERNAME} \
    PVPN_USERNAME_FILE=.env \
    PVPN_PASSWORD=${PVPN_PASSWORD} \
    PVPN_PASSWORD_FILE=.env \
    PVPN_TIER=2 \
    PVPN_PROTOCOL=udp \
    PVPN_CMD_ARGS="connect --fastest" \
    PVPN_DEBUG=1 \
    HOST_NETWORK= \
    DNS_SERVERS_OVERRIDE=

COPY app /app
COPY pvpn-cli /root/.pvpn-cli

RUN apk --update add coreutils openvpn privoxy procps python3 runit git \
    && python3 -m ensurepip \
    && pip3 install git+https://github.com/Rafficer/linux-cli-community.git@v$PVPN_CLI_VER

# Ensure the scripts are executable
RUN chmod +x /usr/local/bin/scripts/change_proton_privoxy_server.sh
RUN chmod +x /usr/local/bin/scripts/test-vpn.sh

# Install necessary packages
RUN apk --update --no-cache add coreutils openvpn privoxy procps python3 runit git iptables ip6tables curl \
    && python3 -m ensurepip \
    && pip3 install git+https://github.com/Rafficer/linux-cli-community.git@v$PVPN_CLI_VER

# RUN apk add --no-cache ip6tables iptables curl

# Run the application
CMD ["runsvdir", "/app"]

# # Print the current user
# RUN whoami

# # Print the permissions of /usr/local/sbin/
# RUN ls -ld /usr/local/sbin/

# # Switch to root user if necessary
# USER root

# # Create a directory and change permissions
# RUN mkdir -p /usr/local/sbin && chmod 755 /usr/local/sbin
# RUN mkdir -p /app/proton-privoxy/templates && chmod 755 /app/proton-privoxy/templates

# # Add a script to test VPN connection
# COPY test-vpn.sh /usr/local/sbin/test-vpn.sh
# RUN chmod +x /usr/local/sbin/test-vpn.sh


# RUN apk update && apk add ip6tables iptables --no-cache curl
# RUN docker exec -it proton-privoxy rm -rf /app/proton-privoxy/templates


# CMD ["runsvdir", "/app", "/usr/local/sbin/test-vpn.sh"]



# FROM alpine:latest
# LABEL maintainer="Walter Leibbrandt"
# LABEL version="0.4.3"
# # XXX Copy version to Docker image tag in .github/workflows/docker.yml when changing!

# # Print the current user
# RUN whoami

# # Print the permissions of /usr/local/sbin/
# RUN ls -ld /usr/local/sbin/

# # Switch to root user if necessary
# USER root

# # Create a directory and change permissions
# RUN mkdir -p /usr/local/sbin && chmod 755 /usr/local/sbin
# RUN mkdir -p /app/proton-privoxy/templates && chmod 755 /app/proton-privoxy/templates

# # Add a script to test VPN connection
# COPY test-vpn.sh /usr/local/sbin/test-vpn.sh
# RUN chmod +x /usr/local/sbin/test-vpn.sh

# EXPOSE 8080

# ARG PVPN_CLI_VER=2.2.12
# ENV PVPN_USERNAME=${PVPN_USERNAME} \
#     PVPN_USERNAME_FILE=.env \
#     PVPN_PASSWORD=${PVPN_PASSWORD} \
#     PVPN_PASSWORD_FILE=.env \
#     PVPN_TIER=2 \
#     PVPN_PROTOCOL=udp \
#     PVPN_CMD_ARGS="connect --fastest" \
#     PVPN_DEBUG=1 \
#     HOST_NETWORK= \
#     # 192.168.51.166/24
#     DNS_SERVERS_OVERRIDE=

# COPY app /app
# COPY pvpn-cli /root/.pvpn-cli

# RUN apk --update add coreutils openvpn privoxy procps python3 runit git iptables ip6tables curl \
#     && python3 -m ensurepip \
#     && pip3 install git+https://github.com/Rafficer/linux-cli-community.git@v$PVPN_CLI_VER



# RUN apk update && apk add ip6tables iptables --no-cache curl
# RUN apk add --no-cache curl

# # # Verify ip6tables-save is available
# # RUN which ip6tables-save || (echo "ip6tables-save not found" && exit 1)

# # # Save iptables rules
# # RUN mkdir -p /etc/iptables \
# #     && iptables-save > /etc/iptables/rules.v4 \
# #     && ip6tables-save > /etc/iptables/rules.v6

# # # Check if the symbolic link exists before creating it
# # RUN [ ! -L /app/proton-privoxy/templates ] && ln -s /path/to/source /app/proton-privoxy/templates \
# # || echo "Symbolic link already exists"

# # # Ensure symbolic link creation does not fail
# # RUN [ ! -e /app/proton-privoxy/templates ] || rm -rf /app/proton-privoxy/templates \
# #     && ln -sf /app/proton-privoxy/templates /app/proton-privoxy/templates

# # Check if ip6tables exists, if not install it
# RUN command -v ip6tables >/dev/null 2>&1 || (apk update && apk add ip6tables iptables)

# # Ensure symbolic link creation does not fail
# RUN if [ -L /app/proton-privoxy/templates ]; then \
#         echo "Symbolic link already exists"; \
#     elif [ -e /app/proton-privoxy/templates ]; then \
#         rm -rf /app/proton-privoxy/templates && ln -s /path/to/source /app/proton-privoxy/templates; \
#     else \
#         ln -s /path/to/source /app/proton-privoxy/templates; \
#     fi

# # Ensure the VPN client is properly configured
# RUN /root/.pvpn-cli/pvpn configure --username $PVPN_USERNAME --password $PVPN_PASSWORD

# # # Add a script to test VPN connection
# # COPY test-vpn.sh /usr/local/sbin/test-vpn.sh
# # RUN chmod +x /usr/local/sbin/test-vpn.sh

# CMD ["runsvdir", "/app", "/usr/local/sbin/test-vpn.sh"]

# # Optionally, set the entrypoint to run the script
# ENTRYPOINT ["/usr/local/sbin/test-vpn.sh"]


# Original
# FROM alpine:3.16
# LABEL maintainer="Walter Leibbrandt"
# LABEL version="0.4.3"
# # XXX Copy version to Docker image tag in .github/workflows/docker.yml when changing!

# EXPOSE 8080

# ARG PVPN_CLI_VER=2.2.12
# ENV PVPN_USERNAME= \
#     PVPN_USERNAME_FILE= \
#     PVPN_PASSWORD= \
#     PVPN_PASSWORD_FILE= \
#     PVPN_TIER=2 \
#     PVPN_PROTOCOL=udp \
#     PVPN_CMD_ARGS="connect --fastest" \
#     PVPN_DEBUG= \
#     HOST_NETWORK= \
#     DNS_SERVERS_OVERRIDE=

# COPY app /app
# COPY pvpn-cli /root/.pvpn-cli

# RUN apk --update add coreutils openvpn privoxy procps python3 runit git \
#     && python3 -m ensurepip \
#     && pip3 install git+https://github.com/Rafficer/linux-cli-community.git@v$PVPN_CLI_VER

# CMD ["runsvdir", "/app"]
