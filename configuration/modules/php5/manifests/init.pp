class php5 {

    # php related packages
    package { ["php5", "libapache2-mod-php5", "php5-mysql", "php5-cli", "php5-common", "php5-xdebug"]:
        ensure => installed,
        require => Exec["apt-update"]
    }
    # "php5-odbc", "php5-suhosin"

    package { ["phpmyadmin"]:
        ensure => installed,
        require => Package["php5"]
    }

    exec { "symlink-phpmyadmin":
        cwd => "/etc/phpmyadmin",
        creates => "/etc/apache2/conf.d/phpmyadmin.conf ",
        command => "/bin/ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf.d/phpmyadmin.conf ; /etc/init.d/apache2 restart",
        require => Package["phpmyadmin"]
    }

    # xdebug
    file { "/etc/php5/conf.d/xdebug.ini":
        ensure => present,
        replace => true,
        owner   => "root",
        group   => "root",
        mode    => "0644",
        source => "puppet:///modules/php5/xdebug.ini",
        require => Package["php5-xdebug"]
    }
}

