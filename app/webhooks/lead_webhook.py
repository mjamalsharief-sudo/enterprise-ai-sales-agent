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
