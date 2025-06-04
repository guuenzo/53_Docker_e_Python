FROM python

RUN apt-get update && apt-get install -y \
    unixodbc \
    unixodbc-dev \
    odbcinst \
    libpq-dev \
    curl \
    apt-transport-https \
    gnupg && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18

WORKDIR /app

COPY Flask-API /app/Flask-API

RUN pip install --upgrade pip
RUN pip install Flask Flask-SQLAlchemy PYJWT psycopg2-binary sqlalchemy pyodbc

EXPOSE 8080

CMD ["flask", "--app", "Flask-API.app", "run", "--host=0.0.0.0", "--port=8080"]