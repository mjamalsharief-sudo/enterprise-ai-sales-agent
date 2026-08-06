#!/bin/bash

###############################################################################
# Enterprise AI Sales Agent
#
# Script 01
#
# Purpose:
# Prepare the project folder on macOS.
#
# This script is SAFE.
# It only creates folders and files.
###############################################################################

echo ""
echo "========================================"
echo " Enterprise AI Sales Agent Bootstrap"
echo "========================================"
echo ""

###############################################################################
# STEP 1
# Move to Documents folder
###############################################################################

echo "Step 1 - Moving to Documents..."

cd ~/Documents

###############################################################################
# STEP 2
# Create parent folder
###############################################################################

echo "Step 2 - Creating Enterprise-AI folder..."

mkdir -p Enterprise-AI

###############################################################################
# STEP 3
# Enter folder
###############################################################################

cd Enterprise-AI

###############################################################################
# STEP 4
# Create project
###############################################################################

echo "Creating project..."

mkdir -p enterprise-ai-sales-agent

cd enterprise-ai-sales-agent

###############################################################################
# STEP 5
# Initialize Git
###############################################################################

echo "Initializing Git..."

git init

###############################################################################
# STEP 6
# Create folders
###############################################################################

echo "Creating folder structure..."

mkdir -p \
app/api \
app/core \
app/agents \
app/graphs \
app/models \
app/services \
app/utils \
app/webhooks \
app/security \
app/email \
app/approval \
app/memory \
app/vectordb \
app/embeddings \
app/monitoring \
configs \
docs \
tests \
docker \
kubernetes \
scripts \
examples \
logs \
prompts \
diagrams \
.github/workflows

###############################################################################
# STEP 7
# Create empty files
###############################################################################

echo "Creating starter files..."

touch README.md
touch LICENSE
touch .gitignore
touch .env.example
touch requirements.txt
touch pyproject.toml
touch docker-compose.yml
touch Dockerfile
touch Makefile

###############################################################################
# STEP 8
# Create Python files
###############################################################################

touch app/main.py

touch app/core/config.py
touch app/core/logger.py
touch app/core/settings.py

touch app/models/lead.py

touch app/webhooks/lead_webhook.py

touch app/graphs/lead_graph.py

###############################################################################
# STEP 9
# Display folder tree
###############################################################################

echo ""
echo "Project Structure:"
echo ""

tree

echo ""
echo "Bootstrap Complete!"
echo ""