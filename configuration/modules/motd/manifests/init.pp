class motd {

    file { "/etc/motd":
        ensure => present,
        replace => true,
        owner   => "root",
        group   => "root",
        mode    => "0644",
        source => "puppet:///modules/motd/motd",
    }
}

