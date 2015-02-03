# dsbaars-seleniumwin

#### Table of Contents

1. [Overview](#overview)
2. [Setup](#setup)
    * [What seleniumwin affects](#what-seleniumwin-affects)
    * [Setup requirements](#setup-requirements)
3. [Usage](#usage)
4. [Reference](#reference)
5. [Limitations](#limitations)
6. [Contributing](#contributing)

## Overview

Configures Selenium on Windows, downloads IEDriver + Standalone server and creates batch-file to register to hub
This module is at a very early stage, so does not contain any tests or linting. Also this is my first Windows puppet-module, and only supports Windows 8.1 and IE 11.
I use it on modern.ie myself.

## Setup

### What seleniumwin affects

* It will create C:\Selenium for all selenium related files
* It adds C:\Selenium to the `PATH`-environment variable.

### Setup Requirements

It is assumed you already have Java SDK installed on your system

## Usage

```puppet
class { 'seleniumwin':
    version        => '2.44'
    filename       => 'IEDriverServer_Win32_2.44.0.zip',
    filenameServer => 'selenium-server-standalone-2.44.0.jar',
    hubUrl         => 'http://192.168.1.101:4444'
}
```
## Reference

Has only one class at the moment, so no complex stuff yet.

## Limitations

Only tested on Windows 8.1 and IE 11 (modern.ie). Might work on other Windows-environments too.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `feature/add-new-manifest`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request
