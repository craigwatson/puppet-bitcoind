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
  Variant[Undef,Array]   $addnode                    = undef,
  Boolean                $allowreceivebyip           = true,
  Variant[Undef,String]  $alertnotify                = undef,
  String                 $bitcoind_cmd               = '/usr/bin/bitcoind',
  Variant[Undef,String]  $bitcoind_datadir           = undef,
  Integer                $bitcoind_nicelevel         = 0,
  Variant[Undef,String]  $bitcoind_pidfile           = undef,
  Variant[Undef,String]  $blocknotify                = undef,
  Variant[Undef,Array]   $connect                    = undef,
  Boolean                $disablewallet              = false,
  Integer                $dbcache                    = 100,
  Boolean                $gen                        = false,
  String                 $group_name                 = 'bitcoind',
  Boolean                $install_gui                = false,
  Integer                $keypool                    = 100,
  Integer                $limitfreerelay             = 15,
  Variant[Undef,String]  $minrelaytxfee              = undef,
  Integer                $maxconnections             = 125,
  Variant[Undef,String]  $maxuploadtarget            = undef,
  String                 $paytxfee                   = '0.00005',
  Boolean                $peerbloomfilters           = true,
  Variant[Undef,String]  $proxy                      = undef,
  Boolean                $server                     = true,
  Boolean                $testnet                    = false,
  Integer                $timeout                    = 5000,
  Boolean                $txindex                    = false,
  Variant[Undef,Array]   $rpcallowip                 = undef,
  Variant[Undef,String]  $rpcconnect                 = undef,
  String                 $rpcpassword                = 'EL5dW6NLpt3A8eeE2KBA9TcFyyVbNvhXfXNBpdB7Rcey',
  Integer                $rpcport                    = 8332,
  Boolean                $rpcssl                     = false,
  String                 $rpcsslcertificatechainfile = 'server.cert',
  String                 $rpcsslciphers              = 'TLSv1+HIGH:!SSLv2:!aNULL:!eNULL:!AH:!3DES:@STRENGTH',
  String                 $rpcsslprivatekeyfile       = 'server.pem',
  Integer                $rpctimeout                 = 30,
  String                 $rpcuser                    = 'bitcoind',
  Boolean                $upnp                       = true,
  Boolean                $use_bitcoin_classic        = false,
  Variant[Undef,String]  $download_bitcoind_version  = undef,
  String                 $download_bitcoind_arch     = 'x86_64-linux-gnu',
  String                 $user_name                  = 'bitcoind',
  String                 $user_home                  = '/home/bitcoind',
  String                 $service_ensure             = 'running',
  Boolean                $service_enable             = true,
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

  if $connect != undef and $addnode != undef {
    fail('Can only use one of $connect and $allowip')
  }

  # Include all subclasses
  include ::bitcoind::params
  include ::bitcoind::account
  include ::bitcoind::install
  include ::bitcoind::config
  include ::bitcoind::service

}
