FROM node:6.14.2

Expose 8080

Copy server.js .
Copy testscript.sh .

CMD node server.js
