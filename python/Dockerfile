FROM python:3.9.18-alpine3.18

ENV PYTHONUNBUFFERED=1

# Install dependencies
RUN \
    # Install curl
    #apk add --no-cache curl && \
    # Install postgres utilities which are required by `psycopg2` lib being used by app
    #apk add --no-cache postgresql-libs && \
    #apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
    # Install Python packages required by the app
    pip install psycopg2-binary
    #apk --purge del .build-deps

WORKDIR /usr/app/src
COPY extract.py ./
COPY /raw_data ./raw_data
CMD [ "python", "./extract.py"]
