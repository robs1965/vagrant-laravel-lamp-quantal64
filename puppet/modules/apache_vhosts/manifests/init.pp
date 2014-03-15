class apache_vhosts {
  
  # make sure sites directory exists and copy over the grok html file
  file {
    '/var/www':
      ensure => directory;

    "/var/www/index.php":
      source  => "puppet:///modules/apache_vhosts/index.php";

    "/var/www/index.html":
      ensure  => absent;
  }

  # enable vhosts here
  apache_vhosts::vhost { ['grok.dev']: }

}