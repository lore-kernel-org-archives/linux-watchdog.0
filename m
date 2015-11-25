Return-path: <martyn.welch@collabora.co.uk>
Message-ID: <5655DDE4.9060002@collabora.co.uk>
Date: Wed, 25 Nov 2015 16:12:20 +0000
From: Martyn Welch <martyn.welch@collabora.co.uk>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Zodiac Aerospace RAVE Switch Watchdog Processor
 Driver
References: <1448453015-16126-1-git-send-email-martyn.welch@collabora.co.uk> <1448453015-16126-2-git-send-email-martyn.welch@collabora.co.uk> <5655CB45.50305@roeck-us.net> <5655D566.30300@collabora.co.uk> <5655DD5A.8030705@roeck-us.net>
In-Reply-To: <5655DD5A.8030705@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>



On 25/11/15 16:10, Guenter Roeck wrote:
> Hi Martyn,
>
> On 11/25/2015 07:36 AM, Martyn Welch wrote:
>>
> [ ... ]
>
>>>> +
>>>> +#define ZIIRAVE_REASON_POWER_UP    0x0
>>>> +#define ZIIRAVE_REASON_HW_WDT    0x1
>>>> +#define ZIIRAVE_REASON_HOST_REQ    0x4
>>>> +#define ZIIRAVE_REASON_IGL_CFG    0x6
>>>> +#define ZIIRAVE_REASON_IGL_INST    0x7
>>>> +#define ZIIRAVE_REASON_IGL_TRAP    0x8
>>>> +#define ZIIRAVE_REASON_UNKNOWN    0x9
>>>> +
>>>> +static char *ziirave_reasons[] = {"power cycle", "triggered", "host
>>>> request",
>>>> +                  "illegal configuration",
>>>> +                  "illegal instruction", "illegal trap",
>>>> +                  "unknown"};
>>>> +
>>>
>>> I don't see mapping code from the reason values to the array.
>>> "host request" is array index 2 but the defined value is 0x4.
>>>
>>> Am I missing something ?
>>>
>>
>> Whoops, missed that. I guess the simplest thing to do is pad out the
>> array?
>>
> I thought you wanted to check if I really read your code :-).
>
> Yes, padding would probably be the simplest solution, though question is
> what to do with undefined values. Maybe pad with NULL and also check if
> ziirave_reasons[x] is not NULL ?
>

I'd just added a string "error" then needed to do a strcmp() to check, 
NULL is a much better idea.

>
>>>> +    /*
>>>> +     * The default value set in the watchdog should be perfectly
>>>> valid, so
>>>> +     * pass that in if we haven't provided one via the module
>>>> parameter or
>>>> +     * of property.
>>>> +     */
>>>> +    if (w_priv->wdd.timeout == 0) {
>>>> +        val = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_TIMEOUT);
>>>> +        if (val < 0)
>>>> +            return val;
>>>> +
>>>> +        w_priv->wdd.timeout = val;
>>>
>>> What if the returned value is 0 ?
>>>
>>
>> Minimum timeout is 3, device won't accept a value below that and
>> should never return a value
>> below that.
>>
>
> Maybe add the following ?
>
>      if (val < ZIIRAVE_TIMEOUT_MIN)
>          return -ENODEV;
>

Might as well.

Martyn

> Thanks,
> Guenter
>
