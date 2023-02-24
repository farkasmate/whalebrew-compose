#!/bin/env ruby

require 'deep_merge'
require 'yaml'
require 'tempfile'

name = ARGV.shift
user = "#{`id -u`.chomp}:#{`id -g`.chomp}"

DEFAULTS = {
  'services' => {
    'whalebrew' => {
      'init' => true,
      'network_mode' => 'default',
      'user' => user,
      'volumes' => [
        './:/workdir:rw',
      ],
      'working_dir' => '/workdir',
    }
  }
}.freeze

prototype = YAML.load_file(name)
container = prototype['services'].keys.first

config = DEFAULTS.dup
config['services']['whalebrew'].deep_merge!(prototype['services'][container])

Tempfile.open do |tempfile|
  tempfile.write(config.to_yaml)
  tempfile.flush

  system "docker compose --project-directory . --file #{tempfile.path} run --rm whalebrew #{ARGV.join(' ')}"
end
