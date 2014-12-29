class bitcoind::service {

  service { 'bitcoind':
    ensure  => running,
    enable  => true,
    require => File['/etc/init/bitcoind.conf'],
  }

}
