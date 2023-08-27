FROM node as build
WORKDIR /usr/src/app
# COPY ./package.json ./package-lock.json ./
COPY . .
RUN npm install
# RUN npm run build


# FROM node
EXPOSE 3000
# WORKDIR /usr/src/app
# COPY --from=build /usr/src/app/build ./
CMD [ "npm","start" ]
