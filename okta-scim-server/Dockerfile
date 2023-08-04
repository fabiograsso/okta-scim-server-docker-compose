FROM python:3.10-alpine

WORKDIR /usr/src/app

COPY okta-scim-flask/* ./
COPY ./startup.sh ./

RUN apk add --no-cache postgresql-libs && \
    apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
    pip install --no-cache-dir -r requirements.txt && \
    apk --purge del .build-deps && \
    sed -i 's/localhost/db/' app.py  && \
    sed -i 's/app.run(debug=True)/app.run(debug=True,host="0.0.0.0")/'  app.py  && \
    chmod +x startup.sh  

# CMD [ "python", "./app.py" ]
CMD ["/bin/sh","-c","./startup.sh"]