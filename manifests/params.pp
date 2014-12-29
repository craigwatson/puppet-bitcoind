class bitcoind::params {

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
