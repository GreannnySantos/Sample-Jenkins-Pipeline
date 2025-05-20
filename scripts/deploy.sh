#!/bin/bash

ENV=$1

if [ -z "$ENV" ]; then
  echo "Usage: $0 <environment>"
  exit 1
fi

echo "Deploying to $ENV environment..."
# Simulate different steps for different environments
case $ENV in
  dev)
    echo "Running dev-specific deployment steps..."
    ;;
  prod)
    echo "Running production deployment steps..."
    echo "Notifying monitoring tools..."
    ;;
  *)
    echo "Unknown environment: $ENV"
    exit 1
    ;;
esac

echo "Deployment to $ENV completed successfully."
