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

To verify your slybroadcast Username and Password.

``` ruby

Slybroadcast::Client.credentials = { c_uid: 'example@email.com',  c_password: 'xxx'  }
result = Slybroadcast::Client.verify

result.success?
true

result.failed?
false

```

### Send a Campaign

Campaign submission with audio file previously uploaded.

``` ruby

result = Slybroadcast::Client.campaign_call_status(
  c_phone: "+16173999981, +16173999982, +16173999983",
  c_record_audio: "Meetup1",
  c_callerID: "+16173999980",
  c_date: "now",
  mobile_only: "1"
)

result.success?
true

result.session_id
1234567788



result.failed?
false

result.error
"Bad Audio, can't download"
```

Campaign submission using a client's audio file.

``` ruby

result = Slybroadcast::Client.campaign_call_status(
  c_phone: "+16173999981, +16173999982, +16173999983",
  c_url: "https://user_audio_url",
  c_callerID: "+16173999980",
  c_date: "now",
  mobile_only: "1",
  c_audio: "mp3"
)

result.success?
true

result.session_id
1234567788



result.failed?
false

result.error
"Bad Audio, can't download"
```

