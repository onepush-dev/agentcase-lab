# AgentCase Lab on Railway: upstream TngSHoO/agentcase-lab (MIT) pinned to a commit, run behind a Caddy basic-auth proxy
# (Streamlit itself has no authentication). Caddy listens on $PORT; Streamlit stays on 127.0.0.1:8501.
FROM caddy:2 AS caddy

FROM python:3.12-slim
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/agentcase-lab"
ENV AGENTCASE_SHA=a50f9c9234a47f938892681449c59c6357748daf \
    AGENTCASE_DB_PATH=/data/agentcase.db \
    AGENTCASE_USER=admin \
    PYTHONUNBUFFERED=1
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN curl -fsSL https://github.com/TngSHoO/agentcase-lab/archive/${AGENTCASE_SHA}.tar.gz | tar xz --strip-components=1
RUN pip install --no-cache-dir -r requirements.txt
COPY --from=caddy /usr/bin/caddy /usr/local/bin/caddy
COPY railway-start.sh /usr/local/bin/railway-start.sh
RUN chmod +x /usr/local/bin/railway-start.sh && mkdir -p /data
EXPOSE 8080
CMD ["railway-start.sh"]
