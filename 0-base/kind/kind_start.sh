#/bin/bash

set -e

cd "$(dirname $0)"

kind create cluster --config mononode-kind-cluster.yaml --name clinic

# Get context
kubectl cluster-info --context kind-clinic
