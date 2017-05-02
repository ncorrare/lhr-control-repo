class profile::base {

  include ::ntp
  include ::apt

  package { ['curl','oracle-java8-installer','libapparmor-dev']:
    ensure  => present,
    require => Exec['acceptterms'],
  }

  apt::key { 'OracleJava':
    id      => 'EEA14886',
    server  => 'keyserver.ubuntu.com',
  }

  apt::source { 'puppetlabs':
    location => 'http://ppa.launchpad.net/webupd8team/java/ubuntu',
    release  => 'trusty',
    repos    => 'main',
    key      => {
      'id'     => 'EEA14886',
      'server' => 'keyserver.ubuntu.com',
    },
    notify  => Exec['acceptterms'],
  }

  exec { 'acceptterms':
    command     => '/bin/bash -c "echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections"',
    refreshonly => true,
  }
  
  exec { 'dockerinstall':
    command => '/usr/bin/curl -sSL get.docker.com | /bin/sh',
    creates => '/usr/bin/docker',
  }

  user { 'ncorrare':
    managehome => true,
    password   => '$6$wg6hZoXB$Ilj.WHrNHD.4apIzxOeuu7gBeMFG.vhQWOlWM39O87hcS52yH7LINjP8d72eGVUx9bFKkXRW10BH0PObe1/qC.',
    groups     => ["sudo"],
    group      => ncorrare,
  }
  
  group { 'ncorrare':
    ensure => 'present',
  }

}
