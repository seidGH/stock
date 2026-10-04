FROM nginx:alpine

# Copy static HTML file to Nginx default public directory
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
