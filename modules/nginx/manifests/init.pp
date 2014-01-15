# Manage nginx webserver
class nginx {
  package { 'apache2.2-common': ensure => absent, }

  package { 'nginx':
    ensure  => installed,
    require => Package['apache2.2-common'],
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
  }

  file { '/etc/nginx/sites-enabled/default':
    source => 'puppet:///modules/nginx/cat-pictures.conf',
    notify => Service['nginx'],
  }

  file { '/var/www':
    ensure => "directory",
    mode   => 755,
  }

  file { '/var/www/cat-pictures':
    ensure  => "directory",
    mode    => 755,
    require => File['/var/www'],
  }

  file { '/var/www/cat-pictures/index.html':
    source  => 'puppet:///modules/nginx/index.html',
    require => File['/var/www/cat-pictures'],
  }

}

