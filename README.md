slybroadcast
=========

A minimal Slybroadcast Ruby client implementation

Usage
-----------

``` ruby

require './lib/slybroadcast'
Slybroadcast::Client.credentials = { c_uid: 'example@email.com',  c_password: 'xxx'  }

```

## or

``` ruby

Slybroadcast::Client.verify({ c_uid: 'user@example.com', c_password: 'secret' })

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

### Pause Campaign

To temporarily pause a campaign or session, but not cancel it.

``` ruby

result = Slybroadcast::Client.campaign_pause(session_id: "6045428032")

result.success?
true

result.session_id
1234567788



result.failed?
false

result.error
"already finished"

```

### Resume Campaign

To resume a campaign.

``` ruby

result = Slybroadcast::Client.campaign_resume(session_id: "6045428032")

result.success?
true

result.session_id
1234567788



result.failed?
false

result.error
"already finished"

```

### Cancel Campaign

To cancel a campaign.

``` ruby

result = Slybroadcast::Client.campaign_cancel(session_id: "6045428032")

result.success?
true

result.session_id
1234567788



result.failed?
false

result.error
"already finished"

```

### Request Account Message Balance

To request the number of remaining messages in your account.

``` ruby

result = Slybroadcast::Client.account_message_balance

result.success?
true

result.remaining_messages
"12345"

result.pending_messages
"123"



result.failed?
false

```

### Retrieve a List of all Audio Files

To view a full list of your audio files.

``` ruby

result = Slybroadcast::Client.list_audio_files

result.success?
true

result.list
[
  {:system_file_name=>"170425242023265.wav", :audio_file_name=>"123456", :created=>"2017-04-25 22:42:25"},
  {:system_file_name=>"294b755.wav", :audio_file_name=>"recording20160425-31049-1mq2hk7", :created=>"2017-05-03 20:39:11"},
  {:system_file_name=>"15213094.wav", :audio_file_name=>"Test01", :created=>"2017-05-03 20:38:16"}
]


result.failed?
false

```
