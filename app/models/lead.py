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
