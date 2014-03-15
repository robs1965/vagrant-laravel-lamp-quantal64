class php {

  # install php and desired extensions
  package { ['php5',
             'php5-cli',
             'libapache2-mod-php5',
             'php5-curl',
             'php5-gd',
             'php5-imagick',
             'php5-mcrypt',
             'php5-memcache',
             'php5-mysql',
             'php5-xdebug']:
    ensure => present;
  }

  # setup php configuration
  file {
    '/etc/php5/apache2':
      ensure => directory,
      before => File ['/etc/php5/apache2/php.ini'];
  
    '/etc/php5/apache2/php.ini':
      source  => 'puppet:///modules/php/php-apache2.ini',
      require => Package['php5'];
  
    '/etc/php5/cli':
      ensure => directory,
      before => File ['/etc/php5/cli/php.ini'];
  
    '/etc/php5/cli/php.ini':
      source  => 'puppet:///modules/php/php-cli.ini',
      require => Package['php5-cli'];
  }

  # make sure curl is installed
  package { ['curl']:
    ensure => present;
  }

  # download composer to tmp directory
  exec { 'download_composer':
    command     => '/usr/bin/curl -s http://getcomposer.org/installer | /usr/bin/php',
    cwd         => '/tmp',
    require     => [
      Package['curl', 'php5-cli']
    ],
    creates     => '/tmp/composer.phar'
  }

  # move composer to /usr/local/bin
  file { '/usr/local/bin/composer':
    ensure      => present,
    source      => '/tmp/composer.phar',
    require     => [ Exec['download_composer'] ],
    group       => 'staff',
    mode        => '0755',
  }

  # download laravel installer to tmp directory
  exec { 'download_laravel_installer':
    command     => '/usr/bin/curl -o ./laravel.phar http://laravel.com/laravel.phar',
    cwd         => '/tmp',
    require     => [
      Package['curl']
    ],
    creates     => '/tmp/laravel.phar'
  }

  # move laravel installer to /usr/local/bin
  file { '/usr/local/bin/laravel':
    ensure      => present,
    source      => '/tmp/laravel.phar',
    require     => [ Exec['download_laravel_installer'] ],
    group       => 'staff',
    mode        => '0755',
  }

}
