# puppet-bitcoind

[![Build Status](https://secure.travis-ci.org/craigwatson/puppet-bitcoind.png?branch=master)](http://travis-ci.org/craigwatson/puppet-bitcoind)
[![Puppet Forge](http://img.shields.io/puppetforge/v/CraigWatson1987/bitcoind.svg)](https://forge.puppetlabs.com/CraigWatson1987/bitcoind)

#### Table of Contents

1. [Overview - What is the puppet-bitcoind module?](#overview)
1. [Module Description - What does the module do?](#module-description)
1. [Setup - The basics of getting started with puppet-bitcoind](#setup)
    * [What puppet-bitcoind affects](#what-puppet-bitcoind-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet-bitcoind](#beginning-with-puppet-bitcoind)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Overview

This Puppet module installs and configures the `bitcoind` daemon, and can optionally install the `bitcoin-qt` GUI - though this will disable the service/daemon.

## Puppet 3 Support

**Please note that the master branch of this module does not support Puppet 3!**

On 31st December 2016, support for Puppet 3.x was withdrawn. As such, this module no longer supports Puppet 3, and is actively being migrated to Puppet 4 syntax.

If you require Puppet 3 compatibility, please use version [2.0.2 from the Puppet Forge](https://forge.puppet.com/CraigWatson1987/bitcoind/readme), or the [puppet3](https://github.com/craigwatson/puppet-bitcoind/tree/puppet3) branch in Git.

### Using Alternative Repositories

This module can handle the installation of the Bitcoin daemon from any Ubuntu PPA repository. To use a third-party repository (e.g. Bitcoin Classic or UASF), simply set the `ppa_name` and `package_name` parameters - the default is to install Bitcoin Core from the official PPA.

## Module Description

  * Adds the requested PPA (see above) and installs `bitcoind`
  * Creates a (configurable) system user and group
  * Places an Upstart init script (Systemd in Ubuntu 16.04 and later)
  * Configures the `bitcoin.conf` configuration file
  * Enables and starts the `bitcoind` daemon/service

## Setup

### Beginning with puppet-bitcoind

To accept default class parameters (correct in most situations):

    include bitcoind

## Usage

To use the an alternative Ubuntu PPA repository, specify an RPC user/password and disable wallet functionality:

    class { 'bitcoind':
      disablewallet              => true,
      rpcallowip                 => ['123.456.789.100'],
      rpcuser                    => 'oliver'
      rpcpassword                => 'youvegottopickapocketortwo',
      ppa_name                   => 'luke-jr/bitcoin-core-bip148-unofficial-builds',
      package_name               => 'bitcoin',
    }

## Reference

### `bitcoin.conf` Configuration Parameters

  * For detailed explanations of the parameters used to configure the `bitcoind` daemon, see here: https://en.bitcoin.it/wiki/Running_bitcoind

### Classes

#### `bitcoind::account`

  * Creates the system user which runs the `bitcoind` service, and also a group for the user to belong to.

#### `bitcoind::config`

  * Places the `bitcoin.conf` configuration file and init script

#### `bitcoind::install`

  * Optionally adds the requested PPA to the system
  * Installs the bitcoind package
  * Optionally installs the bitcoin-qt package

#### `bitcoind::params`

  * Disables server if install_gui passed to the module

#### `bitcoind::service`

## Limitations

### Supported Operating Systems

* Ubuntu - 16.06 (Xenial), 14.04 (Trusty) and 12.04 LTS (Precise)

### Donations

Donations are welcomed via Bitcoin to 1JJ5STJpzyDbvNiStqsfycCuoNFPgWd2Ho

## Development

* Copyright (C) Craig Watson - <craig@cwatson.org>
* Distributed under the terms of the Apache License v2.0 - see LICENSE file for details.
* Further contributions and testing reports are extremely welcome - please submit a pull request or issue on [GitHub](https://github.com/craigwatson/puppet-bitcoind)
