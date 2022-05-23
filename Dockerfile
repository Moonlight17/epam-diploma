# build stage
FROM node:12-alpine as build-stage
WORKDIR /vue
COPY ./front/package*.json .
RUN npm install
# ENV VUE_APP_URL=qwert
COPY ./front/ .
RUN npm run build



FROM python:3.8.9-alpine as back-stage

WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV POSTGRES_NAME=postgres
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=1q2w3e4r
ENV DATABASE_HOST=postgres-diploma-rds.chao43ndm64b.eu-central-1.rds.amazonaws.com
ENV DATABASE_PORT=5432

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

# install dependencies
COPY ./back/requirements.txt /app/requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt



# copy project
COPY ./back/ .
# COPY ./front/dist/ .
EXPOSE 8000


# production stage
COPY --from=build-stage /vue/dist /app/

# CMD ["python", "manage.py", "makemigrations", "epam"]
# CMD ["python", "manage.py", "migrate", "epam"]


CMD /bin/sh /app/docker-entrypoint.sh
