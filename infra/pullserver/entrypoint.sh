#!/usr/bin/env bash
set -euo pipefail

USER_NAME="${SFTP_USER:-user1}"
USER_UID="${SFTP_UID:-1000}"
USER_GID="${SFTP_GID:-1000}"

# Where the user is chrooted to
CHROOT_DIR="/data"
UPLOAD_DIR="${CHROOT_DIR}/upload"

PUBKEY_FILE="/keys/cloud_key.pub"

# 1) Generate host keys if missing
ssh-keygen -A >/dev/null 2>&1 || true

# 2) Create group/user if not exist
if ! getent group "${USER_GID}" >/dev/null 2>&1; then
  groupadd -g "${USER_GID}" "${USER_NAME}" || true
fi

if ! id -u "${USER_NAME}" >/dev/null 2>&1; then
  useradd -m -u "${USER_UID}" -g "${USER_GID}" -s /usr/sbin/nologin "${USER_NAME}"
fi

# 3) Prepare chroot (must be owned by root, not writable by user)
mkdir -p "${CHROOT_DIR}" "${UPLOAD_DIR}"
chown root:root "${CHROOT_DIR}"
chmod 755 "${CHROOT_DIR}"

# Upload dir is writable for the user
chown "${USER_UID}:${USER_GID}" "${UPLOAD_DIR}"
chmod 755 "${UPLOAD_DIR}"

# 4) Install authorized_keys
if [[ ! -f "${PUBKEY_FILE}" ]]; then
  echo "ERROR: Missing public key: ${PUBKEY_FILE}"
  echo "Mount your key into /keys/${USER_NAME}.pub"
  exit 1
fi

install -d -m 700 -o "${USER_UID}" -g "${USER_GID}" "/home/${USER_NAME}/.ssh"
install -m 600 -o "${USER_UID}" -g "${USER_GID}" "${PUBKEY_FILE}" "/home/${USER_NAME}/.ssh/authorized_keys"

# 5) Enforce SFTP-only + chroot for this user
# Add a Match block once (idempotent-ish)
if ! grep -q "Match User ${USER_NAME}" /etc/ssh/sshd_config; then
  cat >> /etc/ssh/sshd_config <<EOF

Match User ${USER_NAME}
  ChrootDirectory ${CHROOT_DIR}
  ForceCommand internal-sftp
  AllowTcpForwarding no
  X11Forwarding no
EOF
fi

exec /usr/sbin/sshd -D -e
