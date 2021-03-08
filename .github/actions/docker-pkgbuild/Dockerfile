FROM archlinux:base-devel

# Update packages.
RUN pacman -Syu --noconfirm --ignore linux --ignore linux-firmware --needed base-devel

# Ensure wheel group exists (seriously??)
RUN groupadd -f -r wheel

# Create an unprivileged user.
RUN useradd -m -G wheel -s /bin/bash pkguser

# Grant group wheel sudo rights without password.
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

RUN chown -R pkguser: \$GITHUB_WORKSPACE

# Set user.
USER pkguser

ENTRYPOINT ["ls", "master/.github/actions/docker-pkgbuild/"]
