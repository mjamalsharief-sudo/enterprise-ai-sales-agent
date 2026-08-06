#!/bin/bash

###############################################################################
# Phase 3 - Lead Webhook Setup
#
# Purpose:
# Creates the first working API for the Enterprise AI Sales Agent.
#
# What this script does:
# 1. Creates Lead Pydantic model
# 2. Creates LangGraph state model
# 3. Creates webhook endpoint
# 4. Updates FastAPI app
# 5. Creates logging configuration
# 6. Creates unit tests
# 7. Runs tests
# 8. Creates Git commit
###############################################################################

set -e

echo "========================================="
echo " Enterprise AI Sales Agent - Phase 3"
echo "========================================="

###############################################################################
# Create __init__.py files
###############################################################################

touch app/__init__.py
touch app/models/__init__.py
touch app/webhooks/__init__.py
touch app/graphs/__init__.py
touch app/core/__init__.py
touch tests/__init__.py

###############################################################################
# Lead Model
###############################################################################

cat > app/models/lead.py <<'EOF'
from pydantic import BaseModel, EmailStr, HttpUrl
from typing import Optional

class Lead(BaseModel):
    first_name: str
    last_name: str
    email: EmailStr
    company: str
    website: Optional[HttpUrl] = None
    job_title: Optional[str] = None
    industry: Optional[str] = None
EOF

###############################################################################
# LangGraph State
###############################################################################

cat > app/graphs/lead_graph.py <<'EOF'
from typing import TypedDict
from uuid import uuid4

class LeadWorkflowState(TypedDict):
    workflow_id: str
    status: str

def create_state():
    return LeadWorkflowState(
        workflow_id=str(uuid4()),
        status="Lead Received"
    )
EOF

###############################################################################
# Logger
###############################################################################

cat > app/core/logger.py <<'EOF'
import logging

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s"
)

logger = logging.getLogger("enterprise-ai-sales-agent")
EOF

###############################################################################
# Webhook
###############################################################################

cat > app/webhooks/lead_webhook.py <<'EOF'
from fastapi import APIRouter
from app.models.lead import Lead
from app.graphs.lead_graph import create_state
from app.core.logger import logger

router = APIRouter()

@router.post("/new-lead")
async def receive_new_lead(lead: Lead):

    logger.info("Lead received from %s", lead.company)

    state = create_state()

    return {
        "success": True,
        "message": "Lead accepted",
        "workflow": state,
        "lead": lead.model_dump()
    }
EOF

###############################################################################
# Main Application
###############################################################################

cat > app/main.py <<'EOF'
from fastapi import FastAPI
from app.webhooks.lead_webhook import router

app = FastAPI(
    title="Enterprise AI Sales Agent",
    version="0.1.0"
)

@app.get("/")
async def home():
    return {
        "status":"running",
        "application":"Enterprise AI Sales Agent"
    }

@app.get("/health")
async def health():
    return {
        "status":"healthy"
    }

app.include_router(
    router,
    prefix="/webhooks",
    tags=["Lead Webhooks"]
)
EOF

###############################################################################
# Unit Test
###############################################################################

mkdir -p tests

cat > tests/test_health.py <<'EOF'
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"
EOF

###############################################################################
# Install testing dependencies
###############################################################################

python -m pip install email-validator pytest httpx

###############################################################################
# Run tests
###############################################################################

pytest

###############################################################################
# Git Commit
###############################################################################

git add .

git commit -m "Phase 3 - Lead webhook and workflow initialization" || true

echo ""
echo "==========================================="
echo " Phase 3 Completed Successfully!"
echo "==========================================="
echo ""
echo "Start server:"
echo "python -m uvicorn app.main:app --reload"
echo ""
echo "Swagger:"
echo "http://127.0.0.1:8000/docs"
echo ""
echo "Webhook:"
echo "POST http://127.0.0.1:8000/webhooks/new-lead"
echo ""