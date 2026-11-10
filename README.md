# AgentCase Lab on Railway

[AgentCase Lab](https://github.com/TngSHoO/agentcase-lab) — replay and root-cause AI agent failures (Streamlit, SQLite, 30 demo cases). Deploy it on Railway with one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template?template=https://github.com/onepush-dev/agentcase-lab)

Independent community packaging of upstream (MIT) at commit `a50f9c9`; not affiliated with the project.

## What you get
- Streamlit app behind a Caddy basic-auth proxy (user `admin`, password = generated `AGENTCASE_PASSWORD`), because Streamlit has no login of its own.
- SQLite database on a Railway volume at `/data`.
- Optional LLM root-cause analysis: set `AGENTCASE_API_KEY` (OpenAI-compatible; `AGENTCASE_API_BASE`, `AGENTCASE_MODEL` also supported).
