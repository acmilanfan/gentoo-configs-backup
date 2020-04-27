#!/bin/bash
eix-sync

if [[ $1 == fast ]]; then
	EXCLUDE_PKGS="gentoo-sources chromium libreoffice wine-staging firefox llvm gcc rust"
    echo Fast emerge
    echo Exclude $EXCLUDE_PKGS
else
    echo Full emerge
fi

emerge -avuDN --with-bdeps=y --changed-deps --complete-graph=y --keep-going --exclude="${EXCLUDE_PKGS}" --verbose-conflicts --quiet-build @world
smart-live-rebuild -- -av --with-bdeps=y --complete-graph=y
emerge -av @preserved-rebuild
emerge -av --depclean
revdep-rebuild
eclean -d distfiles
