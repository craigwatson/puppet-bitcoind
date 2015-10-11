# Change Log

## 1.1.3

## TBC - Bug fix (default update)

#### Class: `bitcoind`
  * Changing default value for `paytxfee` variable to `0.00001` (was `0.00`)

## 1.1.2

### 2015-02-17 - Bug fix

#### Class: `bitcoind`
  * Added two missing parameters to control the `bitcoind` Service resource - thanks to [Nate Riffe](https://github.com/inkblot) for the [Pull Request](https://github.com/craigwatson/puppet-bitcoind/pull/1)!

##1.1.1

### 2015-01-22 - Bug fix

#### Template: `init.erb`
  * Moving back up `expect daemon`

##1.1.0

### 2014-12-30 - Minor feature update

#### Class: `bitcoind`
  * Added `bitcoind_nicelevel` parameter (type: int or string, deafult: 0) to be passed to the Upstart init script.

#### Template: `init.erb`
  * Replaced `expect daemon` with `expect fork` and `oom never` with `oom score -500` as per [this StackExchange answer](http://stackoverflow.com/questions/24163172/upstart-script-for-bitcoind-respawn-feature/25731881#25731881)
  * Now uses the --nicelevel switch to pass the nice level of the bitcoind process.

##1.0.1

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
