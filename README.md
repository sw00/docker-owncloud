docker-owncloud
===============

Owncloud in a docker image.

`docker run -p 127.0.0.1:9000:80 -d --name owncloud -v /var/data/owncloud:/var/www/owncloud/data sw00/owncloud`


	server {
	        listen 80;
	        server_name cloud.rigmarolesoup.com;
	        return 301 https://$host$request_uri;
	}

	server {
	        listen 443;
	        server_name cloud.rigmarolesoup.com;

	        ssl on;
	        ssl_certificate /etc/nginx/certs/rigmarolesoup.com.crt;
	        ssl_certificate_key /etc/nginx/certs/rigmarolesoup.com.key;

	        location / {
	                proxy_pass http://127.0.0.1:49153;
	                proxy_redirect off;
	                proxy_buffering off;
	                proxy_set_header        Host    $host;
	                proxy_set_header        X-Real-IP       $remote_addr;
	                proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;

	                add_header Front-End-Https on;
	                #include /etc/nginx/proxy_params;
	        }
	}