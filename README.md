# puppet-bitcoind

[![Build Status](https://secure.travis-ci.org/craigwatson/puppet-bitcoind.png?branch=master)](http://travis-ci.org/craigwatson/puppet-bitcoind)
[![Puppet Forge](http://img.shields.io/puppetforge/v/CraigWatson1987/bitcoinds.svg)](https://forge.puppetlabs.com/CraigWatson1987/bitcoind)

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

## Module Description

  * Adds the Bitcoin PPA from `ppa:bitcoin/bitcoin` and installs `bitcoind`
  * Creates a (configurable) system user and group
  * Places an Upstart init script in `/etc/init`
  * Configures the `bitcoin.conf` configuration file
  * Enables and starts the `bitcoind` daemon/service

## Setup

### Beginning with puppet-bitcoind

To accept default class parameters (correct in most situations):

    include bitcoind

## Usage

To specify an RPC user/password, disable the wallet functionality, set an allowed RPC IP address and SSL key/cert:

    class { 'bitcoind':
      disablewallet              => true,
      rpcallowip                 => ['123.456.789.100'],
      rpcuser                    => 'oliver'
      rpcpassword                => 'youvegottopickapocketortwoboys',
      rpcssl                     => true,
      rpcsslcertificatechainfile => '/path/to/certificate.pem',
      rpcsslprivatekeyfile       => '/path/to/private.key',
    }

## Reference

### `bitcoin.conf` Configuration Parameters

  * For detailed explanations of the parameters used to configure the `bitcoind` daemon, see here: https://en.bitcoin.it/wiki/Running_bitcoind

### Classes

#### `bitcoind::account`

  * Creates the system user which runs the `bitcoind` service, and also a group for the user to belong to.

#### `bitcoind::config`

  * Places the `bitcoin.conf` configuration file and Upstart script

#### `bitcoind::install`

  * Adds the Bitcoin Apt PPA to the system
  * Installs the bitcoind package
  * Optionally installs the bitcoin-qt package

#### `bitcoind::params`

  * Disables server if install_gui passed to the module

#### `bitcoind::service`

## Limitations

### Supported Operating Systems

* Ubuntu - 14.04 (Trusty) and 12.04 LTS (Precise)

## Development

* Copyright (C) 2013 Craig Watson - <craig@cwatson.org>
* Distributed under the terms of the Apache License v2.0 - see LICENSE file for details.
* Further contributions and testing reports are extremely welcome - please submit a pull request or issue on [GitHub](https://github.com/craigwatson/puppet-bitcoind)
