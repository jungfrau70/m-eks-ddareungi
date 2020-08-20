FROM python:3.6.10

MAINTAINER InHwan Jung "jupyteronline@gmail.com"

COPY ./code /code/

# We copy just the requirements.txt first to leverage Docker cache
ADD ./requirements.txt /code/requirements.txt

WORKDIR /code

RUN pip install -r requirements.txt

CMD [ "python", "app.py" ]
