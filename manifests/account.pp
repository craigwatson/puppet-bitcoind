# == Class: bitcoind::account
#
# This class handles users/groups for the module
#
# == Actions:
#
# * Creates the bitcoin daemon's user and group
#
# === Authors:
#
# Craig Watson <craig@cwatson.org>
#
# === Copyright:
#
# Copyright (C) 2014 Craig Watson
# Published under the Apache License v2.0
#
class bitcoind::account {

  user { $bitcoind::user_name:
    ensure     => present,
    comment    => 'Bitcoin Daemon',
    home       => $bitcoind::user_home,
    managehome => true,
    shell      => '/bin/bash',
    gid        => $bitcoind::group_name,
    require    => Group[$bitcoind::group_name],
  }

  group { $bitcoind::group_name:
    ensure => present,
  }

}
