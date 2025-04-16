#Pull the minimal Ubuntu Image 
FROM ubuntu 
#Install Nginx for webapp html bootstrap 
RUN apt-get -y update && apt-get -y install nginx 
#Copy the whole package here to html location 
COPY . /var/www/html 
#Expose the port for access 
EXPOSE 80/tcp 
#RUN the Nginx server 
CMD ["/usr/sbin/nginx","-g","daemon off;"]  
