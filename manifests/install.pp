#Install latest version of kongfig from npm
class kongfig::install {
  package { 'kongfig':
    ensure   => $kongfig::version,
    provider => 'npm',
  }
}
