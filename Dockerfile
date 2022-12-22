FROM node:16.13.1-alpine3.15 AS build
WORKDIR /src
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm install -g @angular/cli
RUN npm run build --prod 

# WTF https://stackoverflow.com/questions/66391766/angular-nginx-kubernetes-deployment-on-sub-directory-problem

# Failed to load module script: Expected a JavaScript module script but the server responded with a MIME type of "text/html". Strict MIME type checking is enforced for module scripts per HTML spec.

FROM nginx:1.21.5-alpine
WORKDIR /usr/share/nginx/html
COPY --from=build /src/dist/venturini-frontend .
RUN apk add --no-cache gettext bash
# CMD ["/bin/sh",  "-c",  "envsubst < ./assets/env.js.template > ./assets/env.js && exec nginx -g 'daemon off;'"]