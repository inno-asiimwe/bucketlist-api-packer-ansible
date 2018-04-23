#!/bin/bash
cd /var/www/bucketlist-api-gcp
source .env
gunicorn run:app -b localhost:8000