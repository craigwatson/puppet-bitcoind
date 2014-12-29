class bitcoind::account {

  user { $bitcoind::user_name:
    ensure      => present,
    comment     => 'Bitcoin Daemon',
    home        => $bitcoind::user_home,
    manage_home => true,
    shell       => '/bin/bash',
    gid         => $bitcoind::group_name,
    require     => Group[$bitcoind::group_name],
  }

  group { $bitcoind::group_name:
    ensure => present,
  }

}
