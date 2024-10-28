#!/bin/bash

# Establecer KAFKA_HOME si no está ya establecido
export KAFKA_HOME=${KAFKA_HOME:-/opt/kafka}

# Iniciar Zookeeper en segundo plano
$KAFKA_HOME/bin/zookeeper-server-start.sh -daemon $KAFKA_HOME/config/zookeeper.properties

# Esperar a que Zookeeper inicie
echo "Esperando a que Zookeeper inicie..."
while ! nc -z localhost 2181; do
  sleep 1
done
echo "Zookeeper iniciado."

# Iniciar Kafka en segundo plano
$KAFKA_HOME/bin/kafka-server-start.sh -daemon $KAFKA_HOME/config/server.properties

# Esperar a que Kafka inicie
echo "Esperando a que Kafka inicie..."
while ! nc -z localhost 9092; do
  sleep 1
done
echo "Kafka iniciado."

# Crear el topic si no existe
echo "Creando el topic 'invernadero'..."
$KAFKA_HOME/bin/kafka-topics.sh --create --if-not-exists --topic invernadero --partitions 4 --bootstrap-server localhost:9092

# Iniciar el conector en modo standalone
echo "Iniciando Kafka Connect..."
$KAFKA_HOME/bin/connect-standalone.sh $KAFKA_HOME/config/connect-standalone.properties $KAFKA_HOME/config/connect-mqtt-source.properties
