# == Class: bitcoind::service
#
# Manages the bitcoind service
#
# == Actions:
#
# None
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
class bitcoind::service {

  service { 'bitcoind':
    ensure  => $bitcoind::service_ensure,
    enable  => $bitcoind::service_enable,
    require => File['/etc/init/bitcoind.conf'],
  }
}
