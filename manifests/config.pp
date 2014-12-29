class bitcoind::config {

  file { '/etc/init/bitcoind.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('bitcoind/init.erb'),
    require => Package['bitcoind'],
    notify  => Service['bitcoind'],
  }

  file { "${bitcoind::user_home}/.bitcoin":
    ensure  => directory,
    owner   => $bitcoind::user_name,
    group   => $bitcoind::group_name,
    mode    => '0755',
    require => User['bitcoind'],
  }

  file { "${bitcoind::user_home}/.bitcoin/bitcoin.conf":
    ensure  => file,
    owner   => $bitcoind::user_name,
    group   => $bitcoind::group_name,
    mode    => '0600',
    content => template('bitcoin/bitcoin.conf.erb')
    require => File["${bitcoind::user_home}/.bitcoin"],
    notify  => Service['bitcoind'],
  }

}
