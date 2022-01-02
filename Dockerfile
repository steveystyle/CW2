FROM node:6.14.2

Expose 8000

Copy server.js .

CMD node server.js
