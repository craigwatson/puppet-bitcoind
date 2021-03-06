# == Class: bitcoind::params
#
# Non-passed class parameters
#
# == Actions:
#
# * Disables server if install_gui passed to the module
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
class bitcoind::params {

  if (versioncmp($facts['os']['release']['major'],'16.04') >= 0) {
    $init_path     = '/etc/systemd/system/bitcoind.service'
    $init_template = 'systemd.erb'
  } else {
    $init_path     = '/etc/init/bitcoind.conf'
    $init_template = 'upstart.erb'
  }

  if $::bitcoind::download_bitcoind_version != undef {
    $ppa_ensure = absent
  } else {
    $ppa_ensure = present
  }

  if $::bitcoind::bitcoind_datadir != undef {
    $datadir = $::bitcoind::bitcoind_datadir
  } else {
    $datadir = "${bitcoind::user_home}/.bitcoin"
  }

  if $::bitcoind::bitcoind_pidfile != undef {
    $pidfile = $::bitcoind::bitcoind_pidfile
  } else {
    $pidfile = "${::bitcoind::params::datadir}/bitcoind.pid"
  }

  if $::bitcoind::install_gui == true {
    $server         = 0
    $service_ensure = stopped
    $service_enable = false
  } else {

    if $::bitcoind::server == true {
      $server = 1
    } else {
      $server = 0
    }

    $service_ensure = running
    $service_enable = true
  }

  if $::bitcoind::peerbloomfilters == true {
    $peerbloomfilters = 1
  } else {
    $peerbloomfilters = 0
  }

  if $::bitcoind::disablewallet == true {
    $disablewallet = 1
  } else {
    $disablewallet = 0
  }

  if $::bitcoind::txindex == true {
    $txindex = 1
  } else {
    $txindex = 0
  }

  if $::bitcoind::upnp == true {
    $upnp = 1
  } else {
    $upnp = 0
  }

  if $::bitcoind::testnet == true {
    $testnet = 1
  } else {
    $testnet = 0
  }

  if $::bitcoind::rpcssl == true {
    $rpcssl = 1
  } else {
    $rpcssl = 0
  }

  if $::bitcoind::gen == true {
    $gen = 1
  } else {
    $gen = 0
  }

  if $::bitcoind::allowreceivebyip == true {
    $allowreceivebyip = 1
  } else {
    $allowreceivebyip = 0
  }

}
