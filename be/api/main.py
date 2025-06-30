from fastapi import FastAPI
from pathlib import Path
import subprocess
import tempfile
import shutil

app = FastAPI(title="Docs Backend")


@app.get("/healthz")
def health() -> dict[str, str]:
    return {"status": "ok"}


@app.post("/render")
async def render(repo_url: str) -> dict[str, list[str]]:
    """
    Clone a public GitHub repo, run build_docs.sh inside it,
    and list the generated artefacts.
    """
    tmp_dir = Path(tempfile.mkdtemp())
    try:
        subprocess.run(["git", "clone", "--depth", "1", repo_url, tmp_dir], check=True)
        subprocess.run(["./scripts/build_docs.sh"], cwd=tmp_dir, check=True)
        artefacts = [p.name for p in (tmp_dir / "build").iterdir()]
        return {"artefacts": artefacts}
    finally:
        shutil.rmtree(tmp_dir, ignore_errors=True)
