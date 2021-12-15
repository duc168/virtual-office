FROM node:14.18.2 as build-stage
WORKDIR /source
COPY . .
RUN npm install
RUN mv server/tsconfig.server.json server/tsconfig.json
RUN npm run build-server
RUN mv server/tsconfig.json server/tsconfig.server.json

# FROM nginx:stable-alpine
# COPY --from=build-stage /source-code/build/ /usr/share/nginx/html
# COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
FROM node:14.18.2
WORKDIR /game-server
COPY --from=build-stage /source/server-production/ .
ENV PORT=8080
EXPOSE 8080
CMD ["node", "index.js"]