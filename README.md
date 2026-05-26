# awnpoll

Fetch weather data from Ambient Weather devices and store in redis.

## How to set up

AWN application and API keys should be stored in ```creds.env```. See
```creds_example.env``` for how this should look like. Set ```creds.env```
access mode to ```600``` and *do not store in source control*.

Run this periodically from cron via:

```* * * * * source /path/to/creds.env && /path/to/do_poll```

## Device list

Currently only one device is supported. ```do_poll.sh``` will simply take the
data of the first device for the AWN account.

