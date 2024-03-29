# allows enabling of apache modules
define apache::module() {
  file { "/etc/apache2/mods-enabled/${name}":
    ensure  => link,
    target  => "/etc/apache2/mods-available/${name}",
    require => Package['apache2'],
    notify  => Service['apache2'];
  }
}