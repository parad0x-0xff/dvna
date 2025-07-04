# Damn Vulnerable NodeJS Application

FROM node:carbon
LABEL MAINTAINER "Subash SN"

WORKDIR /app

RUN groupadd -r appgroup && useradd --no-create-home -r -g appgroup appuser

# Copia primeiro os arquivos de dependência para aproveitar o cache do Docker
COPY package*.json ./
RUN npm install

# Copia o restante dos arquivos da aplicação
COPY . .

# Define as permissões corretas e o proprietário dos arquivos
RUN chown -R appuser:appgroup /app && chmod +x /app/entrypoint.sh

# Muda para o usuário não-root
USER appuser

CMD ["bash", "/app/entrypoint.sh"]