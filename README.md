# awnpoll

Fetch weather data from Ambient Weather devices and store in redis.

## How to set up

AWN application and API keys should be stored in ```creds.env```. See
```creds_example.env``` for how this should look like. Set ```creds.env```
access mode to ```600``` and *do not store in source control*.

Run this periodically from cron via:

```* * * * * source /path/to/creds.env && /path/to/awnpoll```

## Device list

Currently only one device is supported. ```awnpoll``` will simply take the data
of the first device for the AWN account.


## Data fields stored:

```awn:last_updated```: Last update timestamp in UTC
```awn:tempf```: Temp in F
```awn:tempc```: Temp in C


