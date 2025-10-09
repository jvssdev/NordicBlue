#!/usr/bin/env bash

set -euo pipefail

echo "Removing sudo from the system..."

# Remove sudo but keep necessary dependencies
rpm-ostree override remove sudo || true

echo "sudo removed. The system will use run0."
