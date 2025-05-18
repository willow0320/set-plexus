# Python 3.12 기반 경량 이미지
FROM python:3.12-slim

# 필수 시스템 도구 설치
RUN apt-get update && apt-get install -y curl build-essential && rm -rf /var/lib/apt/lists/*

# Poetry 2.1.3 설치
ENV POETRY_VERSION=2.1.3
RUN curl -sSL https://install.python-poetry.org | python3 -

# Poetry가 PATH에 들어가도록 설정
ENV PATH="/root/.local/bin:$PATH"

# 작업 디렉토리 설정
WORKDIR /app

# Poetry 설정 (가상환경 비활성화 + 비대화식 설치)
ENV POETRY_VIRTUALENVS_CREATE=false
ENV POETRY_NO_INTERACTION=1

# pyproject.toml 및 poetry.lock 복사 → 의존성 설치 (프로젝트 자체는 설치 안 함)
COPY backend/app/pyproject.toml backend/app/poetry.lock* /app/
RUN poetry install --no-root

# 전체 소스 복사
COPY backend/app /app

# FastAPI 앱 실행
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
