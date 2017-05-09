slybroadcast
=========

A minimal Slybroadcast Ruby client implementation.

See slybroadcast.com for information about this product.

Usage
-----------

``` ruby

require './lib/slybroadcast'
Slybroadcast::Client.credentials = { c_uid: 'example@email.com',  c_password: 'xxx'  }

```

or

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

Posibles Params

Param name   | Definition    | Example
------------ | ------------- | -----------
*c_uid* | Your Email Address | value="admin@mobile-sphere.com"
*c_password* | Your Password | value="12345678"
*c_url* | URL for audio file if recorded elsewhere | value="http://www.yoursite.com/wav"
*c_audio* | Audio file type (WAV or Mp3) | value="WAV"
*c_record_audio* | Audio file name if recorded through the Slybroadcast Recording Center | name="MeetupRecording1"
*c_phone* | Destination phone numbers | MAX: 10,000 per submission | value="6173999980,6173999981"
*session_id* | Session/Campaign ID | value="9123456789"
*c_callerID* | Caller ID of campaign | value="6173999980"
*c_date* | Date/Time of delivery (EST) YYYY-MM-DD HH:MM:SS Must use military time format | value="2015-12-31 15:00:00" value="now"
*mobile_only* | Campaign sent to mobile numbers only | value="1"
*c_endtime* | End Time for campaign (EST) HH:MM:SS | Must use military time format value="17:59:59"
*c_sys_audio_name* | Use ONLY if sending the system file name of your audio file | value="r18904b140407197964.wav"
*c_dispo_url* | URL that will receive call status post backs | value=https://www.yoursite.com/results"


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

To receive a status of each call, MobileSphere uses webhook. The POST HTTP Form method is used. Clients should provide a URL to which each call status data can be posted automatically. This is optional.

Example: *c_dispo_url* = "https://www.yoursite.com/results"

If *c_dispo_url* is provided, each call status is sent back using POST
and you can use Slybroadcast::Utilities.callback_parser to parse this
POST

``` ruby

Slybroadcast::Utilities.callback_parser(body) do |session_id, phone_number, status, failure_reason, delivery_time, carrier|
  puts "#{session_id}, #{phone_number}, #{status}, #{failure_reason}, #{delivery_time}, #{carrier}"
end


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
