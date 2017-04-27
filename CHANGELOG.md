# Change Log

## 3.0.2

### 2017-04-27 - Bugfix Release

#### Classes: `bitcoind::config` and `bitcoind::install`
  * Fixing another instance of checking against a `not_set` string.

## 3.0.1

### 2017-04-27 - Bugfix Release

#### Class: `bitcoind::params`
  * Fixing check on `$::bitcoind::download_bitcoind_version` to use `undef` rather than `not_set` string.

## 3.0.0

### 2017-03-10 - Major Version Release

#### Puppet 3 Support Removed
  * This module no longer supports Puppet 3. If you require Puppet 3 functionality, please use version [1.0.4 from the Puppet Forge](https://forge.puppet.com/CraigWatson1987/bitcoind/readme), or the [puppet3](https://github.com/craigwatson/puppet-bitcoind/tree/puppet3) branch in Git.

## 2.0.2

### 2016-12-30 - Bugfix Release

#### Class: `bitcoind`
  * Fixing more stdlib deprecation warnings

## 2.0.1

### 2016-12-30 - Bug Fix release

#### Class: `bitcoind`
  * Fixing stdlib deprecation warnings using validate_legacy

## 2.0.0

### 2016-12-23 - Major Release to Support Ubuntu 16.04 LTS (Xenial) and HTTP downloads

#### Class: `bitcoind`
  * Default parameter change - now placing pidfile
  * New parameters for `download_bitcoind_version` and `download_bitcoind_arch`

#### Class: `bitcoind::params`
  * Adding logic to handle init script placement for Systemd/Upstart
  * Ensures PPAs are `absent` when HTTP downloads are being used

#### Class: `bitcoind::config`
  * Using `params` variables for init script

#### Class: `bitcoind::install`
  * Logic to handle download/extraction of gzip downloads

## 1.6.2

### 2016-06-03 - Bug Fix Release

### Template: `bitcoind.conf.erb`
  * Adding missing parameter assignment

## 1.6.1

### 2016-06-03 - Bug Fix Release

### Template: `bitcoind.conf.erb`
  * Correcting typo in template file

### All Classes
  * Updating to use explicit top-scope variables

## 1.6.0

### 2016-06-03 - Feature Update

### Class: `bitcoind`
  * New parameter: `peerbloomfilters` (default: `true`)

### Class: `bitcoind::params`
  * Handling translation of `bitcoind::peerbloomfilters` param

### Template: `bitcoind.conf.erb`
  * Adding `peerbloomfilters` parameter

## 1.5.0

### 2016-03-27 - Feature Update

### Class: `bitcoind`
  * New parameter: `maxuploadtarget` (default: `'not_set'`)

### Template: `bitcoind.conf.erb`
    * Adding new `maxuploadtarget` parameter

## 1.4.2

### 2016-03-14 - Documentation update

### Readme
  * Updated to reflect that Bitcoin **Core** is the default, not **Classic**.
  * Added section on fork migration.

## 1.4.1

### 2016-03-14 - Feature update

### Class: `bitcoind`
  * New parameter: `use_bitcoin_classic` (default: `false`)

### Class: `bitcoind::install`
  * Conditionally adding the Bitcoin Classic PPA
  * New `exec` resource to stop the `bitcoind` service and purge the `bitcoind` package _before_ the new PPA is activated - this allows in-place switching from Core to Classic, or vice versa.

## 1.3.0

### 2016-02-16 - Feature update

### Class: `bitcoind`
  * New parameter for `dbcache` options

### Template: `bitcoind.conf.erb`
  * Adding new `dbcache` parameter, and adding existing (but so far unused!) `upnp` parameter

## 1.2.1

### 2016-01-14 - Bug fix

### Class: `bitcoind`
  * Changed the default value for the `paytxfee` parameter so `bitcoind` will start with default values

## 1.2.0

### 2016-01-11 - Feature update

### Class: `bitcoind`
  * New parameters for `minrelaytxfee` and `limitfreerelay` options

### Template: `bitcoind.conf.erb`
  * Adding new parameters into template

## 1.1.4

### 2016-01-05 - Bug fix

### Template: `bitcoind.conf.erb`
  * Corrected wrong variable for `keypool` parameter

### 1.1.3

### 2015-10-11 - Bug fix

#### Class: `bitcoind`
  * Changing default value for `paytxfee` variable to `0.00001` (was `0.00`)

#### Class: `bitcoind::install`
  * Reworked logic to ensure that the PPA has been added and `apt-get update` has been run before installing packages

### 1.1.2

### 2015-02-17 - Bug fix

#### Class: `bitcoind`
  * Added two missing parameters to control the `bitcoind` Service resource - thanks to [Nate Riffe](https://github.com/inkblot) for the [Pull Request](https://github.com/craigwatson/puppet-bitcoind/pull/1)!

## 1.1.1

### 2015-01-22 - Bug fix

#### Template: `init.erb`
  * Moving back up `expect daemon`

## 1.1.0

### 2014-12-30 - Minor feature update

#### Class: `bitcoind`
  * Added `bitcoind_nicelevel` parameter (type: int or string, deafult: 0) to be passed to the Upstart init script.

#### Template: `init.erb`
  * Replaced `expect daemon` with `expect fork` and `oom never` with `oom score -500` as per [this StackExchange answer](http://stackoverflow.com/questions/24163172/upstart-script-for-bitcoind-respawn-feature/25731881#25731881)
  * Now uses the --nicelevel switch to pass the nice level of the bitcoind process.

## 1.0.1

### 2014-12-30 - Bug fix

#### Template: `bitcoin.conf.erb`
  * Fixed typo

## 1.0.0

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

## 0.0.1

### 2014-12-29 - Initial Release
  * Initial release to the Puppet Forge.
