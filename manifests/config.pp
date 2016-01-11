# == Class: bitcoind::config
#
# This class handles the main configuration files for the module
#
# == Actions:
#
# * Creates the upstart script, data directory and bitcoind configuration file
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
class bitcoind::config {

  file { '/etc/init/bitcoind.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('bitcoind/init.erb'),
    require => Package['bitcoind'],
    notify  => Service['bitcoind'],
  }

  file { $bitcoind::params::datadir:
    ensure  => directory,
    owner   => $bitcoind::user_name,
    group   => $bitcoind::group_name,
    mode    => '0755',
    require => User['bitcoind'],
  }

  file { "${bitcoind::params::datadir}/bitcoin.conf":
    ensure  => file,
    owner   => $bitcoind::user_name,
    group   => $bitcoind::group_name,
    mode    => '0600',
    content => template('bitcoind/bitcoin.conf.erb'),
    require => File[$bitcoind::params::datadir],
    notify  => Service['bitcoind'],
  }

}
