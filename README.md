## vagrant-sites ##

Default web development environment with Vagrant, Apache, MySQL, PHP, etc.

### Usage ###

1. Link `Vagrantfile` and the `configuration` directory to the directory, which
   should become your `DocumentRoot`. For example:

    ln -s ~/Projects/github/pfrischmuth/vagrant-sites/Vagrantfile
    ~/Sites/Vagrantfile
    ln -s ~/Projects/github/pfrischmuth/vagrant-sites/configuration
    ~/Sites/configuration

2. Run `vagrant up` in the directory where the `Vagrantfile` (link) resides.
3. Visit `192.168.10.10` or `192.168.10.10/phpmyadmin`.

### Optional Stuff ###

- You can add virtual host configuration to the vhosts file under
  `configuration/modules/apache2/templates`. Make sure to adjust the
  `ServerName` and your `/etc/hosts` accordingly. You should also run `vagrant
  provision` after modifying this file.

