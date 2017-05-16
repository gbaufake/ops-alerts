#!/bin/bash

curl -k \
  -H "Hawkular-Tenant: ${HAWKULAR_TENANT}" \
  -H "Authorization: Bearer ${HAWKULAR_TOKEN}" \
  -H "Content-Type: application/json" \
  -d @${AUTOMATION_SCRIPTS_DIR}autoresolve-trigger.json \
  https://${HAWKULAR_HOST}/hawkular/alerts/import/all
