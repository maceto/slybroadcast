slybroadcast
=========

A minimal Slybroadcast Ruby client implementation

Usage
-----------

``` ruby

require './lib/slybroadcast'
Slybroadcast::Client.credentials = { c_uid: 'example@email.com',  c_password: 'xxx'  }

```

### Verify Username and Password

To verify your slybroadcast Username and Password, the following parameters are required.

``` ruby

Slybroadcast::Client.credentials = { c_uid: 'example@email.com',  c_password: 'xxx'  }
Slybroadcast::Client.verify

```
