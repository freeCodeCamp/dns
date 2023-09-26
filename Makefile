NAME := dns
SHELL := /bin/bash

# Define the paths to the scripts
BOOTSTRAP_SCRIPT := ./script/01-bootstrap
DUMP_SCRIPT := ./script/02-dump
VALIDATE_SCRIPT := ./script/03-validate
PLAN_SCRIPT := ./script/04-plan
APPLY_SCRIPT := ./script/05-apply

# Default target when 'make' is run without arguments
.DEFAULT_GOAL := help

# -------------------
# Target Definitions
# -------------------

# Displays the help message
.PHONY: help
help:
	@echo "Usage: make [Target] [Environment Variables]"
	@echo ""
	@echo "Available Targets:"
	@echo "  help       - Show this help message."
	@echo "  bootstrap  - Bootstrap the project."
	@echo "  dump       - Dump configuration."
	@echo "  validate   - Validate configuration."
	@echo "  plan       - Plan configuration."
	@echo "  apply      - Apply configuration."
	@echo ""

# Bootstraps the project
.PHONY: bootstrap
bootstrap:
	@echo "Bootstrapping..."
	@$(BOOTSTRAP_SCRIPT) || { echo "Bootstrap script failed!"; exit 1; }

# Dumps configuration after taking user input
.PHONY: dump
dump:
	@echo "Dumping..."
	@if [ -z "$(zone)" ]; then \
		read -p "Enter zone name: " zone; \
	fi; \
	if [ -z "$(provider)" ]; then \
		read -p "Enter provider name: " provider; \
	fi; \
	$(DUMP_SCRIPT) $$zone $$provider || { echo "Dump script failed!"; exit 1; }

# Validates the configuration
.PHONY: validate
validate:
	@echo "Validating..."
	@$(VALIDATE_SCRIPT) || { echo "Validate script failed!"; exit 1; }

# Plans the configuration
.PHONY: plan
plan:
	@echo "Planning..."
	@$(PLAN_SCRIPT) || { echo "Plan script failed!"; exit 1; }

# Applies the configuration
.PHONY: apply
apply:
	@echo "Applying..."
	@$(APPLY_SCRIPT) || { echo "Apply script failed!"; exit 1; }
