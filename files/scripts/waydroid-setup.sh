#!/usr/bin/env bash

set -oue pipefail

systemctl --user start waydroid-container
waydroid session start
