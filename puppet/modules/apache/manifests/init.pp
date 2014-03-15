class apache {
  
  # make sure apache is installed
  package { ['apache2', 'apache2-mpm-prefork']:
    ensure => present;
  }

  # make sure apache is running
  service { 'apache2':
    ensure  => running,
    require => Package['apache2'];
  }

  # add apache config files
  apache::conf { ['apache2.conf', 'envvars', 'ports.conf']: }

}