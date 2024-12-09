# Usa una imagen base con Ruby 1.9.3 para amd64
#FROM --platform=linux/amd64 ruby:1.9.3

#RUN echo "deb http://archive.debian.org/debian jessie main deb http://archive.debian.org/debian-security jessie/updates main" > /etc/apt/sources.list
#RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until
#RUN apt-get install -y nodejs --force-yes

# Establece el directorio de trabajo
#WORKDIR /app

# Exponer el puerto por defecto de Rails
#EXPOSE 3000

# Inicia un shell para que puedas trabajar en la consola
#CMD ["/bin/bash"]


# Usa una imagen base con Ruby 1.9.3 para amd64
# Usa una imagen base con Ruby
FROM ruby:1.9.3

# Actualiza las fuentes para Debian Jessie
RUN echo "deb http://archive.debian.org/debian jessie main\ndeb http://archive.debian.org/debian-security jessie/updates main" > /etc/apt/sources.list
RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

# Instala dependencias del sistema
RUN apt-get update && apt-get install -y --force-yes \
    nodejs \
    postgresql-client \
    libpq-dev \
    build-essential \
    && apt-get clean

# Configura el directorio de trabajo
WORKDIR /app

# Copia los archivos necesarios para instalar las gemas
COPY Gemfile Gemfile.lock /app/

# Instala las dependencias de Bundler
RUN gem install bundler -v '<2.0' && bundle install

# Copia el resto de los archivos del proyecto
COPY . /app

# Expone el puerto 3000 para Rails
EXPOSE 3000

# Copia el script entrypoint
COPY entrypoint.sh /usr/bin/entrypoint.sh

# Configura el script como entrypoint
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

# Comando por defecto para iniciar el contenedor
CMD ["rails", "server", "-b", "0.0.0.0"]
