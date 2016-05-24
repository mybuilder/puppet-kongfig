Puppet module for installing and managing [Kongfig](https://github.com/mybuilder/kongfig) - a tool for [Kong](https://getkong.org/) to allow declarative configuration.

# Kongfig

This module is currently tested on:

 - Debian (8.0, 7.8)
 - Ubuntu (14.04)

It may work on other distros.


## Configuring Kong

Configuring a new api is easy, simply call `kongfig::setup` with an array of apis and consumers you want configured.

```puppet
$apis = [
  {
    'name'       => "test-api",
    'ensure'     => "present",
    'attributes' => {
      'upstream_url' => "http://test-api.internal.example.com",
      'request_host' => "test-api.example.com",
    },
    'plugins'    => [
      { 'name' => 'cors' },
      { 'name' => 'file-log', 'attributes' => { 'config.path' => '/var/log/kong.log' } },
    ]
  },
  {
    'name'       => "old-api",
    'ensure'     => "removed",
    'attributes' => {
      'upstream_url' => "http://old-api.internal.example.com",
      'request_host' => "old-api.example.com",
    },
    'plugins'    => [
      { 'name' => 'cors' },
    ]
  }
]

$consumers = [
  {
    'username' => 'iphone-app',
    'credentials' => [
      {
        'name' => 'key-auth',
        'attributes' => {
          'key' => 'very-secret-key'
        }
      }
    ]
  }
]

kongfig::setup { 'test-api':
  kong_server => '127.0.0.1',
  kong_port   => 8001,
  apis        => $apis,
  consumers   => $consumers
}
```

## Installing Kongfig

Whenever you use `kongfig:setup` it will ensure that the latest version of [Kongfig](https://www.npmjs.com/package/kongfig) is installed.

If you want to install a specific version you can do this

```puppet
class { 'kongfig':
    version   => '1.0.3',
    directory => '/tmp'
  }
```

---
Created by [MyBuilder](http://www.mybuilder.com/) - Check out our [blog](http://tech.mybuilder.com/) for more information and our other open-source projects.
