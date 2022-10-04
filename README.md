# DevOpsTest - Тестовое задание 

### Описание 
Реализовать тривиальное HTTP "Hello, world!" веб-приложение на любом удобном Вам языке программирования и завернуть его в cloud native окружение.  
- Требования Dockerfile, который докеризует приложение; 
- Приложение должно иметь health-check u ready-check; 
- Приложение должно предоставлять metrics endpoint для Prometheus (метрики - на Ваше усмотрение); 
- Grafana dashboard с визуализацией метрик; 
- docker-compose.yml, который запускает приложение со всем необходимым окружением (Prometheus & Grafana).  

Временем и инструментом для выполнение тестового задания Вы не ограничены. Любые другие аспекты реализации, которые не указаны в требованиях, могут быть выполнены на Ваше усмотрение.  Будет плюсом Kubernetes спеки приложения, либо Helm-чарт, для запуска его в Minikube (в дополнение к docker-compose.yml); 

Е2Е-тесты, которые проверяют корректность докеризации приложения.  
Результат Тестовое задание должно быть предоставлено в виде ссылки на публичный репозиторий (Github, Bitbucket, Gitlab) с исходным кодом. 
Приветствуется README.md файл с обзором реализации и/или шагами по запуску. 

## Основная задача

1) "Hello world" (Python) -> Поднимаем Web Server на Flask на порту 8080/tcp.
man - https://www.digitalocean.com/community/tutorials/how-to-make-a-web-application-using-flask-in-python-3
2) Прикручиваем Prometheus.
man - https://github.com/rycus86/prometheus_flask_exporter
Тестим что все работает 
- http://127.0.0.1:8080
- http://127.0.0.1:8080/metrics
3) Dockerfile - Соберем наш образ приклада в докере https://github.com/docker-library/python/blob/9fd031d91ced6ddc1bf1f0f34b893ad82fa0d010/3.11-rc/alpine3.16/Dockerfile
4) Пишем docker-composer, прикручиваем графану, prometheus, wait.
Тестим docker compose up или docker compose up -d
![Alt text](img/img1.png?raw=true "docker-composer")
Проверяем наши сервисы
- Графана http://localhost:3000/login admin:admin
![Alt text](img/img2.png?raw=true "Grafana")

- Hello world http://localhost:8080/metrics
![Alt text](img/img3.png?raw=true "Hello World")

- Прометеус http://localhost:9090/
![Alt text](img/img4.png?raw=true "Prometheus")

## Доп задача
Ставим миникуб
https://kubernetes.io/ru/docs/tasks/tools/install-minikube/
и ставим реджестри
https://gist.github.com/trisberg/37c97b6cc53def9a3e38be6143786589

helm - 
https://github.com/helm/helm/releases

Упростим задачу и сконвертируем наш docker-composer в helm chart
https://github.com/metal3d/katenary

По инструкции подготовим наш Docker-compose убрав из него volumes
https://www.digitalocean.com/community/tutorials/how-to-migrate-a-docker-compose-workflow-to-kubernetes


```bash
kompose convert -c -f docker-compose-k8s.yml -o charts 
```

Прогоняем тест
```bash
helm template charts charts
```

Деплоим и поднгимаем gui кубера и сервисов
```bash
helm install charts charts
minikube dashboard --url
minikube service --all
```
```bash
NAME                           READY   STATUS    RESTARTS      AGE
grafana-5bb7bc8fbc-ft7s2       1/1     Running   2 (27m ago)   55m
hello-world-69d4556c6f-8ztm7   1/1     Running   0             9m20s
prometheus-86b79b9ccf-v9msb    1/1     Running   3 (27m ago)   55m
```
Profit
График есть
![Alt text](img/img5.png?raw=true "Prometheus")
Поды запущены
![Alt text](img/img6.png?raw=true "Prometheus")


P.S. Можно также настроить Liveness, Readiness и Startup проб
Просто дописать манифест по инструкции...
https://kubernetes.io/ru/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/
