# build stage
FROM node:latest as build-stage
WORKDIR /vue
COPY ./front/package*.json ./
RUN npm install
COPY ./front/ ./
COPY ./front/src/ ./src/
RUN npm run build



FROM python:3.8.9-alpine as back-stage

WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

# install dependencies
COPY ./back/requirements.txt /app/requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt



# copy project
COPY ./back/ .
EXPOSE 8000


# production stage
COPY --from=build-stage /vue/dist /app

# CMD ["python", "manage.py", "makemigrations", "epam"]
# CMD ["python", "manage.py", "migrate", "epam"]


CMD ["python", "manage.py", "runserver", "8000"]
