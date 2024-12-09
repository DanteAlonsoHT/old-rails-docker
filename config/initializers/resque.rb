require 'resque'

Resque.before_first_fork do
  Rails.application.eager_load! # Opcional si necesitas cargar todo
end

# Limitar la carga si el error persiste
Rails.application.config.paths['app/controllers'] = []

Resque.redis = Redis.new(url: ENV.fetch('REDIS_URL', 'redis://redis:6379/0'))
