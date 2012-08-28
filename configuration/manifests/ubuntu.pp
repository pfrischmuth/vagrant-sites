class ubuntu {

    $mysql_user = 'php'
    $mysql_pw = 'php'
    $mysql_root_pw = 'vagrant123'

    include bootstrap
    include motd
    include apache2
    include php5
    include mysql
}

include ubuntu
