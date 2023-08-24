NAME := dns
SHELL := /bin/bash

# Variables
MK_cloudflare_token=$(CLOUDFLARE_TOKEN)
.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Usage: make [Target] [Environment Variables]"
	@echo ""
	@echo "Targets:"
	@echo "  help             Show this help message"
	@echo "  bootstrap        Bootstrap the project"
	@echo "  validate         Validate configuration"
	@echo ""
	@echo ""

export_credentials:
	@echo "Exporting credentials..."
	set -e && export CLOUDFLARE_TOKEN=$(MK_cloudflare_token)

.PHONY: bootstrap
bootstrap:
	@echo "Bootstraping..."
	set -e && ./script/bootstrap

.PHONY: validate
validate: export_credentials
	@echo "Validating..."
	set -e && ./script/validate

.PHONY: plan
plan: export_credentials
	@echo "Planning..."
	set -e && ./script/plan
