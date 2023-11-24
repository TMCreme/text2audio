"""
Main FastAPI app that has the web hook
"""
from fastapi import FastAPI, Request, Response
from magnum import Magnum

# from audio_gen import run_audioldm


app = FastAPI()


@app.post("/webhook", status_code=200)
async def webhook(text: str, request: Request, response: Response):
    """The main webhook"""
    print(text)
    # run_audioldm(text)
    return {"result": "ok"}

handler = Magnum(app)
