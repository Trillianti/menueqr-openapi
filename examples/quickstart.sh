#!/usr/bin/env bash
set -euo pipefail

: "${MENUQR_API_BASE:?Set MENUQR_API_BASE}"
: "${MENUQR_PROVIDER:?Set MENUQR_PROVIDER}"
: "${MENUQR_RESTAURANT_ID:?Set MENUQR_RESTAURANT_ID}"
: "${MENUQR_POS_API_KEY:?Set MENUQR_POS_API_KEY}"

BASE="${MENUQR_API_BASE}/api/open/pos/${MENUQR_PROVIDER}/${MENUQR_RESTAURANT_ID}"

curl "${BASE}" \
  -H "x-menuqr-pos-api-key: ${MENUQR_POS_API_KEY}"

curl "${BASE}/menu" \
  -H "x-menuqr-pos-api-key: ${MENUQR_POS_API_KEY}"

curl "${BASE}/orders?status=pending&limit=10" \
  -H "x-menuqr-pos-api-key: ${MENUQR_POS_API_KEY}"
