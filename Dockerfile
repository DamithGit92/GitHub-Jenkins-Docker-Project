FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get install apache2 -y && apt-get install unzip

ADD https://github.com/startbootstrap/startbootstrap-sb-admin/archive/gh-pages.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip gh-pages.zip
RUN cp -rvf startbootstrap-sb-admin-gh-pages/* .
RUN rm -rf startbootstrap-sb-admin-gh-pages gh-pages.zip
CMD ["apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
