FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN sudo apt update -y && apt install apache2 && apt install -y

ADD https://github.com/startbootstrap/startbootstrap-sb-admin/archive/gh-pages.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip startbootstrap-sb-admin-gh-pages.zip
RUN cp -rvf startbootstrap-sb-admin-gh-pages/* .
RUN rm -rf startbootstrap-sb-admin-gh-pages startbootstrap-sb-admin-gh-pages.zip
CMD ["apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
