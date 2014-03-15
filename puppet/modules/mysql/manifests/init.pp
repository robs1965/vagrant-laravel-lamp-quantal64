class mysql {

  # make sure mysql is installed
  package { ['mysql-server']:
    ensure => present;
  }

  # make sure mysql is running
  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server'];
  }

  # overwrite the default configuration
  file { '/etc/mysql/my.cnf':
    source  => 'puppet:///modules/mysql/my.cnf',
    require => Package['mysql-server'],
    notify  => Service['mysql'];
  }

  # make sure the root password is set properly
  exec { 'set-mysql-password':
    unless  => 'mysqladmin -uroot -proot status',
    command => "mysqladmin -uroot password root",
    path    => ['/bin', '/usr/bin'],
    require => Service['mysql'];
  }

  # optionally, load a site sql file
  # exec { 'load sql file':
  #   command => 'mysql -u root -proot < /vagrant/sites/dynamic.sql',
  #   path    => ['/bin', '/usr/bin'],
  #   require => Exec['set-mysql-password'];
  # }
  
}