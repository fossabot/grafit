FROM python:3.6

LABEL Name=grafit Version=0.0.1
EXPOSE 8000

# Using pipenv:
COPY ./Pipfile Pipfile
COPY ./Pipfile.lock Pipfile.lock
RUN pip install pipenv
RUN pipenv install --system --deploy --ignore-pipfile

COPY . /code
WORKDIR /code

# Migrates the database, uploads staticfiles
# TODO run with gunicorn
CMD ./backend/manage.py migrate && \
    ./backend/manage.py runserver 0.0.0.0:8000
