NAME := dns
SHELL := /bin/bash

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

.PHONY: bootstrap
bootstrap:
	@echo "Bootstraping..."
	set -e && ./script/bootstrap

.PHONY: validate
validate:
	@echo "Validating..."
	set -e && ./script/validate

.PHONY: plan
plan:
	@echo "Planning..."
	set -e && ./script/plan
