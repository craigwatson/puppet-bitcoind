# == Class: bitcoind::install
#
# Installs packages
#
# == Actions:
#
# * Adds the Bitcoin or Bitcoin Classic Apt PPA to the system
# * Installs the bitcoind package
# * Optionally installs the bitcoin-qt package
#
# === Authors:
#
# Craig Watson <craig@cwatson.org>
#
# === Copyright:
#
# Copyright (C) Craig Watson
# Published under the Apache License v2.0
#
class bitcoind::install {

  apt::ppa { 'ppa:bitcoinclassic/bitcoinclassic':
    ensure => $bitcoind::params::classic_ppa_ensure,
    notify => Exec['puppet_uninstall_bitcoind'],
  }

  apt::ppa { 'ppa:bitcoin/bitcoin':
    ensure => $bitcoind::params::core_ppa_ensure,
    notify => Exec['puppet_uninstall_bitcoind'],
  }

  exec { 'puppet_uninstall_bitcoind':
    command     => 'puppet resource service bitcoind ensure=stopped;puppet resource package bitcoind ensure=absent',
    path        => ['/bin/','/sbin/','/usr/bin/','/usr/sbin/','/usr/local/bin/','/opt/puppetlabs/bin/'],
    refreshonly => true,
    before      => Exec['apt_update'],
  }

  package { 'bitcoind':
    ensure  => present,
    require => Exec['apt_update'],
  }

  if $bitcoind::install_gui == true {
    package { 'bitcoin-qt':
      ensure  => present,
      require => Exec['apt_update'],
    }
  }

}
