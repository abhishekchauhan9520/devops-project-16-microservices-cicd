FROM node:22-alpine
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install --omit=dev --ignore-scripts
COPY index.js ./
EXPOSE 6000
HEALTHCHECK --interval=15s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q -O - http://127.0.0.1:6000/health | grep -q 'healthy'
CMD ["node", "index.js"]
