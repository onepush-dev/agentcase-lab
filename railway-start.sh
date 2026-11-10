#!/bin/sh
set -e
: "${PORT:=8080}"
: "${AGENTCASE_PASSWORD:?AGENTCASE_PASSWORD is required}"
mkdir -p /data
export HASH="$(caddy hash-password --plaintext "$AGENTCASE_PASSWORD")"
cat > /tmp/Caddyfile <<CADDY
{
  admin off
}
:$PORT {
  handle /_stcore/health {
    reverse_proxy 127.0.0.1:8501
  }
  handle {
    basic_auth {
      $AGENTCASE_USER {env.HASH}
    }
    reverse_proxy 127.0.0.1:8501
  }
}
CADDY
cd /app
streamlit run app.py --server.address=127.0.0.1 --server.port=8501 --server.headless=true --browser.gatherUsageStats=false --server.enableXsrfProtection=false &
exec caddy run --config /tmp/Caddyfile --adapter caddyfile
