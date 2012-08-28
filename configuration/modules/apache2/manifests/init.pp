class apache2 {

    # apache2
    package { ["apache2"]:
        ensure => installed,
        require => Exec["apt-update"]
    }
    service { "apache2":
        ensure => running,
        enable => true,
        hasrestart => true,
        require => Package["apache2"],
    }

    # enable modules
    exec { "enable-mod-rewrite":
        command => "/usr/sbin/a2enmod rewrite ; /etc/init.d/apache2 restart",
        creates => "/etc/apache2/mods-enabled/rewrite.load",
        require => Package["apache2"]
    }

    # copy/enable templates
    file { "/etc/apache2/sites-available/default":
        ensure => present,
        content => template("apache2/default"),
        replace => true
    }
    file { "/etc/apache2/sites-available/vhosts":
        ensure => present,
        content => template("apache2/vhosts"),
        replace => true
    }
    exec { "enable-vhosts":
        path => ["/bin", "/usr/bin"],
        command => "/usr/sbin/a2ensite vhosts ; /etc/init.d/apache2 restart",
        creates => "/etc/apache2/sites-enabled/vhosts",
        require => [Package["apache2"], File["/etc/apache2/sites-available/vhosts"]]
    }
    exec { "apache-restart":
        path => ["/bin", "/usr/bin"],
        command => "/etc/init.d/apache2 restart",
        require => [Package["apache2"], File["/etc/apache2/sites-available/vhosts"], File["/etc/apache2/sites-available/default"]]

    }
}
