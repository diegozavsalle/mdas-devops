#cleanup
docker-compose down

#build
docker-compose build

docker-compose up -d && docker-compose logs -f

# test
# se ejecuta directamente en Dockerfile del directorio test