# Menggunakan image Nginx dasar
FROM nginx:latest

# Menyalin konfigurasi atau file lain ke dalam container
COPY ./html /usr/share/nginx/html
