FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd

# Harden sshd defaults
RUN sed -i 's|^#\?Subsystem\s\+sftp\s\+.*|Subsystem sftp internal-sftp|' /etc/ssh/sshd_config && \
    { \
      echo "PasswordAuthentication no"; \
      echo "PermitRootLogin no"; \
      echo "PubkeyAuthentication yes"; \
      echo "KbdInteractiveAuthentication no"; \
      echo "ChallengeResponseAuthentication no"; \
      echo "UsePAM no"; \
      echo "AllowTcpForwarding no"; \
      echo "X11Forwarding no"; \
      echo "PrintMotd no"; \
      echo "LogLevel VERBOSE"; \
    } >> /etc/ssh/sshd_config

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]


