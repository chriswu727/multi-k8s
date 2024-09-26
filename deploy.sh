docker build -t chriswyc/multi-client:latest -t chriswyc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chriswyc/multi-server:latest -t chriswyc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chriswyc/multi-worker:latest -t chriswyc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chriswyc/multi-client:latest
docker push chriswyc/multi-server:latest
docker push chriswyc/multi-worker:latest

docker push chriswyc/multi-client:$SHA
docker push chriswyc/multi-server:$SHA
docker push chriswyc/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=chriswyc/multi-server:$SHA
kubectl set image deployments/client-deployment client=chriswyc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chriswyc/multi-worker:$SHA