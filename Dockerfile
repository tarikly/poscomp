FROM node as build-deps
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
ENV NODE_OPTIONS=--openssl-legacy-provider
RUN yarn
COPY . ./
RUN yarn build

FROM nginx:alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
ENV PORT 8080
EXPOSE $PORT
CMD ["nginx", "-g", "daemon off;"]