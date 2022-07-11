#using nginx as base image and creating a new image with user defined content and running as a normal user.
FROM nginx:latest
#creating normal user and group 
RUN groupadd -r nginxuser && useradd -r -g nginxuser nginxuser
#removed "user nginx;" line from nginx.conf file and replacing it.  
COPY ./nginx.conf /etc/nginx/nginx.conf
#replacing index.html with modified page content
COPY ./index.html /usr/share/nginx/html/index.html
# modifying file permission for nginx, so that a normal user can start nginx //ref - https://medium.com/kocsistem/how-to-run-nginx-for-root-non-root-5ceb13db6d41
RUN     chown -R nginxuser:nginxuser /var/cache/nginx && \
        chown -R nginxuser:nginxuser /var/log/nginx && \
        chown -R nginxuser:nginxuser /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R nginxuser:nginxuser /var/run/nginx.pid
EXPOSE 80
#switching to normal user
USER nginxuser   
