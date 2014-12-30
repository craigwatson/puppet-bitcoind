class bitcoind::service {

  service { 'bitcoind':
    ensure  => $bitcoind::service_ensure,
    enable  => $bitcoind::service_enable,
    require => File['/etc/init/bitcoind.conf'],
  }
}
