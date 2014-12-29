class bitcoind::install {
  apt::ppa { 'ppa:bitcoin/bitcoin':
  }

  package { 'bitcoind':
    ensure  => present,
    require => Apt::Ppa['ppa:bitcoin/bitcoin'],
  }
}
