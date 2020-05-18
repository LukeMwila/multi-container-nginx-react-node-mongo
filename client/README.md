# Client

## Run tests in Docker
docker build -t react-test . -f Dockerfile.dev
docker run -e CI=true -p 3000:3000 react-test