require 'dry-configurable'

module Tilda
  class Config
    extend Dry::Configurable
    setting :public_key
    setting :private_key
  end
end