# Comandos Docker Swarm - HuertoHogar

## Inicialización del Swarm (solo en Manager)
```bash
docker swarm init --advertise-addr IP_PRIVADA_MANAGER
```
Copiar el comando de join que aparece

## Agregar Workers
```bash
docker swarm join --token SWMTKN-1-xxxxx IP_MANAGER:2377
```

## Verificar nodos
```bash
docker node ls
```

## Desplegar stack
```bash
docker stack deploy -c docker-compose.swarm.yml huertohogar
```

## Ver servicios
```bash
docker service ls
```

## Ver réplicas de un servicio
```bash
docker service ps huertohogar_usuarios-ms
docker service ps huertohogar_core-ms
docker service ps huertohogar_carrito-ms
```

## Escalar servicios
```bash
docker service scale huertohogar_core-ms=3
```
Verificar escalado:
```bash
docker service ps huertohogar_core-ms
```
Regresar a 2 réplicas:
```bash
docker service scale huertohogar_core-ms=2
```

## Ver logs
```bash
docker service logs huertohogar_usuarios-ms
docker service logs -f huertohogar_core-ms
```

## Actualizar servicio
```bash
docker service update --image nachovn114/huertohogar-usuarios:latest huertohogar_usuarios-ms
```

## Eliminar stack
```bash
docker stack rm huertohogar
```
