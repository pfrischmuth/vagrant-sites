class bootstrap {

    # update apt
    exec { "apt-update":
        command => "/usr/bin/apt-get update && /usr/bin/apt-get upgrade -y",
        logoutput => "on_failure"
    }

    # install some useful applications
    package { ["htop", "vim", "git-core", "unzip", "curl", "zsh", "make", "exuberant-ctags", "byobu"]:
        ensure => installed,
        require => Exec["apt-update"]
    }

    exec { "chsh-to-zsh":
        command => "/usr/bin/chsh -s /usr/bin/zsh vagrant",
        require => Package["zsh"]
    }

    exec { "clone-seebi-zshrc":
        command => "/usr/bin/git clone git://github.com/seebi/zshrc.git && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git zshrc/syntax-highlighting && git clone git://github.com/joelthelion/autojump.git zshrc/autojump && git clone git://github.com/seebi/dircolors-solarized.git zshrc/dircolors-solarized && cd zshrc/autojump && git checkout release-v16 && cd /home/vagrant/zshrc && export HOME=/home/vagrant && make install-core",
        cwd => "/home/vagrant",
        path => "/bin:/usr/bin",
        creates => "/home/vagrant/zshrc",
        user => "vagrant",
        provider => "shell",
        logoutput => "on_failure",
        require => [Package["zsh"], Package["git-core"]]
    }
}
