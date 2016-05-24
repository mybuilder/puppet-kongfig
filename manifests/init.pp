# Setup kongfig the tool for configuring kong
class kongfig (
  $directory = $kongfig::params::directory,
  $version = $kongfig::params::version,
) inherits kongfig::params {

  validate_absolute_path($directory)
  validate_string($version)

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'kongfig::begin': }
  anchor { 'kongfig::end': }

  Anchor['kongfig::begin'] ->
    class { 'kongfig::install': }->
    class { 'kongfig::config': }->
  Anchor['kongfig::end']
}
