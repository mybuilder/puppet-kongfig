# Setup config directory
class kongfig::config {
  file { $kongfig::directory:
    ensure => directory,
    owner  => 'root',
  }
}
