from .main import app  # noqa: F401

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("be.api.main:app", host="0.0.0.0", port=8000, reload=False)
