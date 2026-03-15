FROM python:3.13.3-slim
WORKDIR /app

RUN pip install uv

COPY . ./

RUN groupadd --gid 1000 mcp && \
    useradd --uid 1000 --gid 1000 --create-home mcp && \
    chown -R mcp:mcp /app

RUN uv pip install --system -e .
RUN chmod +x entrypoint.py

ENV PYTHONPATH=/app/src:$PYTHONPATH

USER mcp

ENTRYPOINT ["python", "./entrypoint.py"]
