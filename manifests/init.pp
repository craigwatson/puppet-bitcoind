class bitcoind (
  $addnode                    = 'not_set',
  $allowreceivebyip           = true,
  $bitcoind_cmd               = '/usr/bin/bitcoind',
  $bitcoind_pidfile           = '/home/bitcoind/bitcoind.pid',
  $connect                    = 'not_set',
  $gen                        = false,
  $group_name                 = 'bitcoind',
  $keypool                    = 100,
  $maxconnections             = 125,
  $paytxfee                   = '0.00',
  $proxy                      = 'not_set',
  $testnet                    = false,
  $rpcallowip                 = 'not_set',
  $rpcconnect                 = 'not_set',
  $rpcpassword                = 'EL5dW6NLpt3A8eeE2KBA9TcFyyVbNvhXfXNBpdB7Rcey',
  $rpcport                    = '8332',
  $rpcssl                     = false,
  $rpcsslcertificatechainfile = '',
  $rpcsslciphers              = 'TLSv1+HIGH:!SSLv2:!aNULL:!eNULL:!AH:!3DES:@STRENGTH',
  $rpcsslprivatekeyfile       = '',
  $rpctimeout                 = '30',
  $rpcuser                    = 'bitcoind',
  $user_name                  = 'bitcoind',
  $user_home                  = '/home/bitcoind',
){

  # Hard-fail on anything that isn't Ubuntu
  if $::operatingsystem != 'Ubuntu' {
    fail('Unsupported operatingsystem')
  }

  # Validate parameters
  if $rpcallowip != 'not_set' {
    validate_array($rpcallowip)
  }

  if $connect != 'not_set' and $addnode != 'not_set' {
    fail('Can only use one of $connect and $allowip')
  }

  if $connect != not_set {
    validate_array($connect)
  }

  if $addnode != not_set {
    validate_array($addnode)
  }

  validate_string($group_name)
  validate_string($paytxfee)
  validate_string($rpcconnect)
  validate_string($rpcpassword)
  validate_string($rpcport)
  validate_string($rpctimeout)
  validate_string($rpcsslcertificatechainfile)
  validate_string($rpcsslciphers)
  validate_string($rpcsslprivatekeyfile)
  validate_string($rpcuser)
  validate_string($user_name)
  validate_absolute_path($bitcoind_cmd)
  validate_absolute_path($bitcoind_pidfile)
  validate_absolute_path($user_home)
  validate_bool($allowreceivebyip)
  validate_bool($gen)
  validate_bool($rpcssl)
  validate_bool($testnet)

  # Include all subclasses
  include bitcoind::params
  include bitcoind::account
  include bitcoind::install
  include bitcoind::config
  include bitcoind::service

  # Class dependencies
  Class['bitcoind::params'] ->
  Class['bitcoind::account'] ->
  Class['bitcoind::install'] ->
  Class['bitcoind::config'] ->
  Class['bitcoind::service']

}
