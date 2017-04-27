# == Class: bitcoind::config
#
# This class handles the main configuration files for the module
#
# == Actions:
#
# * Creates the init script, data directory and bitcoind configuration file
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

  if $::bitcoind::download_bitcoind_version != undef {
    File[$::bitcoind::params::init_path] {
      require => Exec['clean_downloaded_bitcoind'],
    }
  } else {
    File[$::bitcoind::params::init_path] {
      require => Package['bitcoind'],
    }
  }

  file { $::bitcoind::params::init_path:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("bitcoind/init/${::bitcoind::params::init_template}"),
    notify  => Service['bitcoind'],
  }

  file { $::bitcoind::params::datadir:
    ensure  => directory,
    owner   => $::bitcoind::user_name,
    group   => $::bitcoind::group_name,
    mode    => '0755',
    require => User['bitcoind'],
  }

  file { "${::bitcoind::params::datadir}/bitcoin.conf":
    ensure  => file,
    owner   => $::bitcoind::user_name,
    group   => $::bitcoind::group_name,
    mode    => '0600',
    content => template('bitcoind/bitcoin.conf.erb'),
    require => File[$::bitcoind::params::datadir],
    notify  => Service['bitcoind'],
  }

}
