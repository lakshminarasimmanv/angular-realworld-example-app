# Build Stage
FROM --platform=arm64 node:16.18.0-alpine3.16 as build

WORKDIR /app

COPY --chown=node:node . .

STOPSIGNAL SIGQUIT

RUN yarn install && yarn ng build

FROM --platform=arm64 nginx:1.17.1-alpine

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app/dist/ /usr/share/nginx/html/

EXPOSE 80
