# docker-projeto2-cluster
Projeto de criação de um cluster Swarm utilizando o Vagrant

Além do proposto pelo instrutor, foi criado um lazy provision para criar o serviço do apache no master node. Para execução, seguir os comandos: 
``` 
vagrant up
vagrant provision --provision-with "start-service"
```
