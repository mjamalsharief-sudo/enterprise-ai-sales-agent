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
