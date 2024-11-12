docker build -t extra .
docker run -d -p 8097:80 extra


docker system prune -a --volumes -f
docker stop $(docker ps -q)
