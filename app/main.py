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
