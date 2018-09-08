package { 'httpd':
  ensure => present,
  before => File['/var/www/html/index.html'],
}

file { '/var/www/html/index.html':
  ensure => file,
  mode   => '0755',
  source => 'puppet:///modules/httpd/index.html',
  notify => Service['httpd'],
}

service { 'httpd':
  ensure    => running,
  enable    => true,
  subscribe => File['/var/www/html/index.html'],
}

