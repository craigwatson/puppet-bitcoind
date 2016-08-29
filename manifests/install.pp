# == Class: bitcoind::install
#
# Installs packages
#
# == Actions:
#
# * Adds the Bitcoin or Bitcoin Classic Apt PPA to the system
# * Installs the bitcoind package
# * Optionally installs the bitcoin-qt package
#
# === Authors:
#
# Craig Watson <craig@cwatson.org>
#
# === Copyright:
#
# Copyright (C) Craig Watson
# Published under the Apache License v2.0
#
class bitcoind::install {

  apt::ppa { 'ppa:bitcoinclassic/bitcoinclassic':
    ensure => $::bitcoind::params::classic_ppa_ensure,
    notify => Exec['puppet_uninstall_bitcoind'],
  }

  apt::ppa { 'ppa:bitcoin/bitcoin':
    ensure => $::bitcoind::params::core_ppa_ensure,
    notify => Exec['puppet_uninstall_bitcoind'],
  }

  exec { 'puppet_uninstall_bitcoind':
    command     => 'puppet resource service bitcoind ensure=stopped;puppet resource package bitcoind ensure=absent',
    path        => ['/bin/','/sbin/','/usr/bin/','/usr/sbin/','/usr/local/bin/','/opt/puppetlabs/bin/'],
    notify      => Exec['puppet_bitcoind_clean'],
    refreshonly => true,
  }

  exec { 'puppet_bitcoind_clean':
    command     => '/bin/rm /usr/bin/bitcoin*',
    unless      => '/bin/ls -1 | grep bitcoin',
    refreshonly => true,
  }

  if $::bitcoind::download_bitcoind_version != 'not_set' {

    ensure_package(['wget','gzip'], { ensure => present })

    $filename = "bitcoin-${::bitcoind::download_bitcoind_version}-${::bitcoind::download_bitcoind_arch}-linux-gnu.tar.gz"
    $url      = "https://bitcoin.org/bin/bitcoin-core-${::bitcoind::download_bitcoind_version}/${filename}"

    exec { 'download_bitcoind':
      command => "/usr/bin/wget -qO /tmp/${filename} ${url}",
      require => Package['wget'],
      notify  => Exec['uncompress_bitcoind'],
    }

    exec { 'uncompress_bitcoind':
      command     => "/bin/tar -xf /tmp/${filename}",
      notify      => Exec['install_bitcoind'],
      refreshonly => true,
    }

    exec { 'install_bitcoind':
      command     => "/bin/mv /tmp/bitcoind-${::bitcoind::download_bitcoind_version}/bin/* /usr/bin/",
      require     => Exec['puppet_uninstall_bitcoind'],
      refreshonly => true,
    }

  } else {

    Exec['puppet_uninstall_bitcoind'] {
      before => Exec['apt_update'],
    }

    package { 'bitcoind':
      ensure  => present,
      require => Exec['apt_update'],
    }

    if $::bitcoind::install_gui == true {
      package { 'bitcoin-qt':
        ensure  => present,
        require => Exec['apt_update'],
      }
    }
  }

}
