# Change Log

#1.0.1

### 2014-12-30 - Bug fix

#### Template: `bitcoin.conf.erb`
  * Fixed typo

##1.0.0

### 2014-12-30 - Major improvements and polish

#### Module dependencies
  * Added `puppetlabs/apt` to the dependencies list - this is used in the `bitcoind::install` class to add the Bitcoin PPA.

#### Readme
  * Added full readme!

#### Class: `bitcoind`
  * Added `install_gui` parameter (type: boolean, default: false) to enable installation of the `bitcoin-qt` GUI interface.
  * Moving `bitcoind_pidfile` to `/var/run` in line with convention for pidfiles.
  * Added many parameters to better manage `bitcoind`.

#### Class: `bitcoind::params`
  * Added `datadir` variable, which will either use the configured value from the `bitcoind` class, or default to `.bitcoin` within the user's home directory.

#### Class: `bitcoind::service`
  * Now using variables from `bitcoind::params` for `ensure` and `enable`.

#### Template: `bitcoind.conf.erb`
  * Using Puppet 3 `scope['var']` syntax rather than the older `scope.lookupvar('var')`

#### Template: `init.erb`
  * Adding `datadir` to the script options and using Puppet 3 variable syntax

##0.0.1

### 2014-12-29 - Initial Release
  * Initial release to the Puppet Forge.
