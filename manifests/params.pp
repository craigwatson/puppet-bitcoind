class bitcoind::params {

  if $bitcoind::bitcoind_datadir == 'not_set' {
    $datadir = "${bitcoind::user_home}/.bitcoin"
  } else {
    $datadir = $bitcoind::bitcoind_datadir
  }

  if $bitcoind::install_gui == true {
    $server         = 0
    $service_ensure = stopped
    $service_enable = false
  } else {

    if $bitcoind::server == true {
      $server = 1
    } else {
      $server = 0
    }

    $service_ensure = running
    $service_enable = true
  }

  if $bitcoind::disablewallet == true {
    $disablewallet = 1
  } else {
    $disablewallet = 0
  }

  if $bitcoind::txindex == true {
    $txindex = 1
  } else {
    $txindex = 0
  }

  if $bitcoind::upnp == true {
    $upnp = 1
  } else {
    $upnp = 0
  }

  if $bitcoind::testnet == true {
    $testnet = 1
  } else {
    $testnet = 0
  }

  if $bitcoind::rpcssl == true {
    $rpcssl = 1
  } else {
    $rpcssl = 0
  }

  if $bitcoind::gen == true {
    $gen = 1
  } else {
    $gen = 0
  }

  if $bitcoind::allowreceivebyip == true {
    $allowreceivebyip = 1
  } else {
    $allowreceivebyip = 0
  }

}
