# Backend

## Run tests in Docker
docker build -t node-test . -f Dockerfile.dev
docker run -e CI=true -p 3001:3001 node-test