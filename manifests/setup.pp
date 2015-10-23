# used to create a new kongfig file which is then used to update kong
# see readme for examples
define kongfig::setup (
  $kong_server = undef,
  $kong_port = undef,
  $apis = undef,
  $consumers = undef,
) {
  validate_ipv4_address($kong_server)
  $host = {
    'host' => "${$kong_server}:${$kong_port}",
  }

  validate_integer($kong_port, 65535)

  if $apis {
    validate_array($apis)
    $api_hash = {
      'apis' => $apis
    }
  }

  if $consumers {
    validate_array($consumers)

    $consumer_hash = {
      'consumers' => $consumers
    }
  }

  require kongfig

  $config = "${kongfig::directory}/${name}.json"

  file { $config:
    ensure  => file,
    content => sorted_json(merge($host, $api_hash, $consumer_hash), true, 4),
    require => [File[$kongfig::directory], Package['kongfig']]
  }->
  exec { $name:
    command => "kongfig --path ${config}",
    require => Package['kongfig']
  }
}
