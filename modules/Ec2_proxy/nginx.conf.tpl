worker_processes 1;

events {
    worker_connections 1024;
}

http {
    upstream backend_servers {
        server ${backend1}:5000;
        server ${backend2}:5000;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://backend_servers;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
    }
}
