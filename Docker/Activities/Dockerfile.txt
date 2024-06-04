#Specify base image, node 18-alpine is version, where node js is there in it(node is a image, where the version is..18)
FROM node:18-alpine

#Set the working directory
WORKDIR /usr/app

#copy files to container
#this means copy package.json(source) to container(dest)
#COPY source destination 
#=>copy package.json /usr/app (its the other way)
COPY package.json ./

#Install dependencies,install whatever is in package.json
RUN npm install

#copy rest of the files
# first ./ is copy the current folder(SimpleWeb) to (2nd)  destination's current folder(/usr/app)
COPY ./ ./

#Start web server
CMD ["npm","start"]

