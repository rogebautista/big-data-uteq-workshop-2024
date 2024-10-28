# Utilizar la imagen base de Jupyter con PySpark
FROM jupyter/pyspark-notebook:latest

# Establecer las variables de entorno necesarias
ENV PYSPARK_PYTHON=python3
ENV SPARK_HOME=/usr/local/spark

# Copiar los JARs necesarios al directorio de JARs de Spark
COPY jars/*.jar $SPARK_HOME/jars/

# Instalar paquetes adicionales si es necesario
# RUN pip install <paquetes_adicionales>

# Copiar cualquier script o archivo necesario (opcional)
# COPY your_script.py /home/jovyan/work/your_script.py

# Exponer el puerto de Jupyter Notebook
EXPOSE 8888

# Comando por defecto para iniciar Jupyter Notebook
CMD ["start-notebook.sh"]
