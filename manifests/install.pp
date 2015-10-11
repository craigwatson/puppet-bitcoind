# == Class: bitcoind::install
#
# Installs packages
#
# == Actions:
#
# * Adds the Bitcoin Apt PPA to the system
# * Installs the bitcoind package
# * Optionally installs the bitcoin-qt package
#
# === Authors:
#
# Craig Watson <craig@cwatson.org>
#
# === Copyright:
#
# Copyright (C) 2014 Craig Watson
# Published under the Apache License v2.0
#
class bitcoind::install {

  apt::ppa { 'ppa:bitcoin/bitcoin': }

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
