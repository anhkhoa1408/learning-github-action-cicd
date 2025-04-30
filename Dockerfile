FROM node:23-alpine as builder

WORKDIR /app

RUN chown -R node:node /app

USER node

COPY --chown=node:node package*.json /app

RUN npm install

COPY --chown=node:node . .

RUN npm run build

FROM nginx:alpine as runner

COPY --from=builder /app/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]