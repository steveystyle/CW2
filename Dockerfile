FROM node:6.14.2

Expose 8080

Copy testscript.sh .
Copy server.js .

CMD node server.js
