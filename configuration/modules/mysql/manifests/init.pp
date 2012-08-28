class mysql {

  $mysql_root_pw = $ubuntu::mysql_root_pw
  $mysql_user = $ubuntu::mysql_user
  $mysql_pw = $ubuntu::mysql_pw

  # mysql
  package { "mysql-server": ensure => installed, require => Exec["apt-update"] }
  package { "mysql-client": ensure => installed, require => Exec["apt-update"] }

  # mysql service
  service { "mysql":
    enable => true,
    ensure => running,
    require => Package["mysql-server"],
  }

  # set root password
  exec { "set-mysql-password":
    unless => "mysqladmin -uroot -p${mysql_root_pw} status",
    path => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password ${mysql_root_pw}",
    require => Service["mysql"],
  }

  # add php user
  exec { "grant-all-to-php-user":
        unless => "/usr/bin/mysql -u${$mysql_user} -p${mysql_pw} status",
        command => "/usr/bin/mysql -uroot -p${mysql_root_pw} -e \"grant all on *.* to '${mysql_user}'@'localhost' identified by '${mysql_pw}';\"",
        require => [Service["mysql"], Package['mysql-client'], Exec['set-mysql-password']]
  }
}
