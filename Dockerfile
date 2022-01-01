FROM node:6.14.2

Expose 8080

Copy --chmod=0777 server.js .
Copy --chmod=0777 testscript.sh .

CMD node server.js
