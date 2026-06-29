FROM node:20-alpine

WORKDIR /usr/src/app

# Copia os arquivos de dependência e instala
COPY package*.json ./
RUN npm install

# Copia o restante do código do servidor
COPY . .

# Expõe a porta interna do Express
EXPOSE 3000

CMD [ "npm", "run", "dev" ]