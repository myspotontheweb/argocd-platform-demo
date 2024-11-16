#!/usr/bin/env bash
set -euo pipefail

eksctl create cluster -f $(dirname $0)/config/${1:-default}.yaml