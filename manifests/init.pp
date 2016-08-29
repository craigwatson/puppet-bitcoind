# == Class: bitcoind
#
# Main class containing parameters and validation logic
#
# == Actions:
#
# * Fails on non-Ubuntu operating systems
# * Validates passed parameters
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
class bitcoind (
  $addnode                    = 'not_set',
  $allowreceivebyip           = true,
  $alertnotify                = 'not_set',
  $bitcoind_cmd               = '/usr/bin/bitcoind',
  $bitcoind_datadir           = 'not_set',
  $bitcoind_nicelevel         = 0,
  $bitcoind_pidfile           = 'not_set',
  $blocknotify                = 'not_set',
  $connect                    = 'not_set',
  $disablewallet              = false,
  $dbcache                    = 100,
  $gen                        = false,
  $group_name                 = 'bitcoind',
  $install_gui                = false,
  $keypool                    = 100,
  $limitfreerelay             = 15,
  $minrelaytxfee              = 'not_set',
  $maxconnections             = 125,
  $maxuploadtarget            = 'not_set',
  $paytxfee                   = '0.00005',
  $peerbloomfilters           = true,
  $proxy                      = 'not_set',
  $server                     = true,
  $testnet                    = false,
  $timeout                    = '5000',
  $txindex                    = false,
  $rpcallowip                 = 'not_set',
  $rpcconnect                 = 'not_set',
  $rpcpassword                = 'EL5dW6NLpt3A8eeE2KBA9TcFyyVbNvhXfXNBpdB7Rcey',
  $rpcport                    = '8332',
  $rpcssl                     = false,
  $rpcsslcertificatechainfile = 'server.cert',
  $rpcsslciphers              = 'TLSv1+HIGH:!SSLv2:!aNULL:!eNULL:!AH:!3DES:@STRENGTH',
  $rpcsslprivatekeyfile       = 'server.pem',
  $rpctimeout                 = '30',
  $rpcuser                    = 'bitcoind',
  $upnp                       = true,
  $use_bitcoin_classic        = false,
  $download_bitcoind_version  = 'not_set',
  $download_bitcoind_arch     = 'x64',
  $user_name                  = 'bitcoind',
  $user_home                  = '/home/bitcoind',
  $service_ensure             = running,
  $service_enable             = true,
){

  # Hard-fail on anything that isn't Ubuntu
  if $::operatingsystem != 'Ubuntu' {
    fail('Unsupported operating system')
  }

  # Warn if install_gui and server are both true
  if $install_gui == true and $server == true {
    notify { 'bitcoind warning':
      name     => 'install_gui and server are both set to true, server will be disabled!',
      withpath => true,
    }
  }

  if $rpcallowip != 'not_set' {
    validate_array($rpcallowip)
  }

  if $connect != 'not_set' and $addnode != 'not_set' {
    fail('Can only use one of $connect and $allowip')
  }

  if $connect != 'not_set' {
    validate_array($connect)
  }

  if $addnode != 'not_set' {
    validate_array($addnode)
  }

  if $bitcoind_pidfile != 'not_set' {
    validate_absolute_path($bitcoind_pidfile)
  }

  validate_absolute_path($bitcoind_cmd)
  validate_absolute_path($user_home)

  validate_bool($allowreceivebyip)
  validate_bool($disablewallet)
  validate_bool($gen)
  validate_bool($install_gui)
  validate_bool($testnet)
  validate_bool($txindex)
  validate_bool($rpcssl)
  validate_bool($upnp)
  validate_bool($use_bitcoin_classic)

  validate_string($alertnotify)
  validate_string($bitcoind_datadir)
  validate_string($blocknotify)
  validate_string($download_bitcoind_version)
  validate_string($download_bitcoind_arch)
  validate_string($group_name)
  validate_string($minrelaytxfee)
  validate_string($paytxfee)
  validate_string($proxy)
  validate_string($rpcpassword)
  validate_string($rpcsslcertificatechainfile)
  validate_string($rpcsslciphers)
  validate_string($rpcsslprivatekeyfile)
  validate_string($rpcuser)
  validate_string($user_name)

  # Include all subclasses
  include ::bitcoind::params
  include ::bitcoind::account
  include ::bitcoind::install
  include ::bitcoind::config
  include ::bitcoind::service

  # Class dependencies
  Class['::bitcoind::params'] ->
  Class['::bitcoind::account'] ->
  Class['::bitcoind::install'] ->
  Class['::bitcoind::config'] ->
  Class['::bitcoind::service']

}
