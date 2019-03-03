docker build -t sozonivka2018/multi-client:latest -t sozonivka2018/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sozonivka2018/multi-server:latest -t sozonivka2018/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sozonivka2018/multi-worker:latest -t sozonivka2018/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sozonivka2018/multi-client:latest
docker push sozonivka2018/multi-server:latest
docker push sozonivka2018/multi-worker:latest
docker push sozonivka2018/multi-client:$SHA
docker push sozonivka2018/multi-server:$SHA
docker push sozonivka2018/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sozonivka2018/multi-server:$SHA
kubectl set image deployments/client-deployment client=sozonivka2018/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sozonivka2018/multi-worker:$SHA
