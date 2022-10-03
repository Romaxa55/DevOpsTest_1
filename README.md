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


Реализация 
1) "Hello world" (Python) -> Поднимаем Web Server на Flask на порту 8080/tcp.
man - https://www.digitalocean.com/community/tutorials/how-to-make-a-web-application-using-flask-in-python-3
2) Прикручиваем Prometheus
man - https://github.com/rycus86/prometheus_flask_exporter
Тестим что все работает 
- http://127.0.0.1:8080
- http://127.0.0.1:8080/metrics
3) Dockerfile - Соберем наш образ приклада в докере https://github.com/docker-library/python/blob/9fd031d91ced6ddc1bf1f0f34b893ad82fa0d010/3.11-rc/alpine3.16/Dockerfile
4) 