#!/bin/bash

# Tentativas de conexão com o banco de dados
MAX_DB_RETRIES=15
DB_RETRY_COUNT=0

echo "Verificando conexão com o banco de dados..."

# Esperar até que o banco de dados esteja disponível
while [ $DB_RETRY_COUNT -lt $MAX_DB_RETRIES ]; do
    # Tentar criar o schema MFMADATABASE
    PGPASSWORD=${PASS_DB} psql -h ${HOST_DB} -U ${USER_DB} -d ${NAME_DB} -c "CREATE SCHEMA IF NOT EXISTS MFMADATABASE;" &>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "Conexão com o banco de dados estabelecida e schema MFMADATABASE criado com sucesso!"
        break
    else
        echo "Aguardando o banco de dados ficar disponível (tentativa $((DB_RETRY_COUNT+1))/$MAX_DB_RETRIES)..."
        DB_RETRY_COUNT=$((DB_RETRY_COUNT+1))
        sleep 3
    fi
    
    if [ $DB_RETRY_COUNT -eq $MAX_DB_RETRIES ]; then
        echo "Não foi possível conectar ao banco de dados após $MAX_DB_RETRIES tentativas."
        # Continuar mesmo sem conseguir criar o schema
    fi
done

./JobSendRecomendation