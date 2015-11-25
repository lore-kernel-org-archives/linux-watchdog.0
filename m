Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33705 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbbKYQKE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 11:10:04 -0500
Subject: Re: [PATCH v3 2/2] Zodiac Aerospace RAVE Switch Watchdog Processor
 Driver
To: Martyn Welch <martyn.welch@collabora.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1448453015-16126-1-git-send-email-martyn.welch@collabora.co.uk>
 <1448453015-16126-2-git-send-email-martyn.welch@collabora.co.uk>
 <5655CB45.50305@roeck-us.net> <5655D566.30300@collabora.co.uk>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5655DD5A.8030705@roeck-us.net>
Date: Wed, 25 Nov 2015 08:10:02 -0800
MIME-Version: 1.0
In-Reply-To: <5655D566.30300@collabora.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Martyn,

On 11/25/2015 07:36 AM, Martyn Welch wrote:
>
[ ... ]

>>> +
>>> +#define ZIIRAVE_REASON_POWER_UP    0x0
>>> +#define ZIIRAVE_REASON_HW_WDT    0x1
>>> +#define ZIIRAVE_REASON_HOST_REQ    0x4
>>> +#define ZIIRAVE_REASON_IGL_CFG    0x6
>>> +#define ZIIRAVE_REASON_IGL_INST    0x7
>>> +#define ZIIRAVE_REASON_IGL_TRAP    0x8
>>> +#define ZIIRAVE_REASON_UNKNOWN    0x9
>>> +
>>> +static char *ziirave_reasons[] = {"power cycle", "triggered", "host request",
>>> +                  "illegal configuration",
>>> +                  "illegal instruction", "illegal trap",
>>> +                  "unknown"};
>>> +
>>
>> I don't see mapping code from the reason values to the array.
>> "host request" is array index 2 but the defined value is 0x4.
>>
>> Am I missing something ?
>>
>
> Whoops, missed that. I guess the simplest thing to do is pad out the array?
>
I thought you wanted to check if I really read your code :-).

Yes, padding would probably be the simplest solution, though question is
what to do with undefined values. Maybe pad with NULL and also check if
ziirave_reasons[x] is not NULL ?


>>> +    /*
>>> +     * The default value set in the watchdog should be perfectly valid, so
>>> +     * pass that in if we haven't provided one via the module parameter or
>>> +     * of property.
>>> +     */
>>> +    if (w_priv->wdd.timeout == 0) {
>>> +        val = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_TIMEOUT);
>>> +        if (val < 0)
>>> +            return val;
>>> +
>>> +        w_priv->wdd.timeout = val;
>>
>> What if the returned value is 0 ?
>>
>
> Minimum timeout is 3, device won't accept a value below that and should never return a value
> below that.
>

Maybe add the following ?

	if (val < ZIIRAVE_TIMEOUT_MIN)
		return -ENODEV;

Thanks,
Guenter

