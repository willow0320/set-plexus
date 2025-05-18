from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import random

app = FastAPI()

# CORS 허용 (브라우저에서 요청 가능하게 함)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 카드 속성
colors = ["Red", "Green", "Purple"]
shapes = ["Oval", "Squiggle", "Diamond"]
numbers = ["1", "2", "3"]
shadings = ["Solid", "Striped", "Open"]

# 카드 조합 생성
def generate_deck():
    deck = [
        f"{c}.{s}.{n}.{sh}"
        for c in colors
        for s in shapes
        for n in numbers
        for sh in shadings
    ]
    random.shuffle(deck)
    return deck

@app.get("/")
def read_root():
    return {"message": "SET-Plexus 서버가 실행 중입니다!"}

@app.get("/start")
def start_game():
    deck = generate_deck()
    return {"deck": deck[:12]}  # 처음에는 12장만 반환
