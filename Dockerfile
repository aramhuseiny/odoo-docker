FROM ubuntu:22.04

ENV TZ=Etc/UTC
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /opt/odoo/

ENV VIRTUAL_ENV=/opt/odoo/venv


RUN apt update -y\
    && apt upgrade -y
RUN apt install tzdata

RUN apt install -y git python3-pip build-essential wget python3-dev python3-venv 
RUN apt install -y python3-wheel libfreetype6-dev libxml2-dev libzip-dev libldap2-dev libsasl2-dev 
RUN apt install -y python3-setuptools node-less libjpeg-dev zlib1g-dev libpq-dev 
RUN apt install -y libxslt1-dev 
RUN apt install -y libldap2-dev 
RUN apt install -y libtiff5-dev 
RUN apt install -y libjpeg8-dev 
RUN apt install -y libopenjp2-7-dev
RUN apt install -y liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev


RUN wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
RUN  dpkg -i ./libssl1.1_1.1.0g-2ubuntu4_amd64.deb
RUN  rm -i libssl1.1_1.1.0g-2ubuntu4_amd64.deb
#RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
COPY wkhtmltox_0.12.5-1.bionic_amd64.deb .

RUN apt install -y ./wkhtmltox_0.12.5-1.bionic_amd64.deb

RUN apt-get install -y python3-pypdf2 python3-psycopg2
# RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

RUN apt-get install -y npm
# RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g less less-plugin-clean-css
RUN apt-get install -y node-less

# install rtl css
RUN npm install -g rtlcss

# create log directory
RUN mkdir -p /var/log/odoo/

# RUN chown odoo:odoo -R /var/log/odoo/

COPY odoo /opt/odoo

# RUN chown odoo:odoo -R /opt/odoo/

# USER odoo

RUN cd /opt/odoo

# RUN python3 -m venv  $VIRTUAL_ENV

# ENV PATH="$VIRTUAL_ENV/bin:$PATH"


RUN pip install wheel

RUN pip install -Ur /opt/odoo/requirements.txt


EXPOSE 8069 8072

CMD [ "python3", "/opt/odoo/odoo-bin",  "-c", "/etc/odoo/odoo.conf"]