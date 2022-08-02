FROM python:3.9.13-alpine3.16
ADD main.py /
ADD requirements.txt /
RUN pip install -r requirements.txt
CMD [ "python", "./main.py" ]
