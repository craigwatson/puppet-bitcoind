class bitcoind::install {

  apt::ppa { 'ppa:bitcoin/bitcoin': }

  package { 'bitcoind':
    ensure  => present,
    require => Apt::Ppa['ppa:bitcoin/bitcoin'],
  }

  if $bitcoind::install_gui == true {
    package { 'bitcoin-qt':
      ensure  => present,
      require => Apt::Ppa['ppa:bitcoin/bitcoin'],
    }
  }

}
