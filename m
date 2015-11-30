Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48552 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbbK3SKl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Nov 2015 13:10:41 -0500
Subject: Re: [PATCH v4] Zodiac Aerospace RAVE Switch Watchdog Processor Driver
To: Martyn Welch <martyn.welch@collabora.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>
References: <5655CB45.50305@roeck-us.net>
 <1448471702-29001-1-git-send-email-martyn.welch@collabora.co.uk>
 <565C716B.1090206@roeck-us.net> <565C86DF.3080608@collabora.co.uk>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <565C911B.5010400@roeck-us.net>
Date: Mon, 30 Nov 2015 10:10:35 -0800
MIME-Version: 1.0
In-Reply-To: <565C86DF.3080608@collabora.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/30/2015 09:26 AM, Martyn Welch wrote:
> On 30/11/15 15:55, Guenter Roeck wrote:
>> Hi Martyn,
>>
>> On 11/25/2015 09:15 AM, Martyn Welch wrote:
>>> This patch adds a driver for the Zodiac Aerospace RAVE Watchdog Procesor.
>>> This device implements a watchdog timer, accessible over I2C.
>>>
>> Mostly there, still a few nitpicks and a problem with DT properties.
>>
[ ... ]

>>> +
>>> +static int ziirave_wdt_init_duration(struct i2c_client *client, int
>>> duration)
>>> +{

Separate note: The "duration" parameter here doesn't really add value.
It just reflects the module parameter. It would only make sense if the code
to obtain the duration (either from reset_duration or from DT)
would be in a separate function, such as in

	duration = ziirave_get_duration(client);
	if (duration < 0)
		return duration;
	if (duration) {
		ret = ziirave_wdt_init_duration(client, duration);
		if (ret)
			return ret;
	}

or similar.

>>> +    int ret;
>>> +
>>> +    if (!duration) {
>>> +        /* See if the reset pulse duration is provided in an of_node */
>>> +        if (client->dev.of_node == NULL)
>>> +            return -ENODEV;
>>> +
>> Please write as "if (!client->dev.of_node)" (see checkpatch --strict).
>>
>
> ok
>
>> Also, is it really necessary to mandate DT support ? There is no mandatory
>> property to be read, so this driver would (or should) work fine on a non-DT
>> system.
>>
>
> The error doesn't cause the probe to fail. If it takes that path, it results in a message that the default value is being used and continues with that.
>
>>> +        ret = of_property_read_u32(client->dev.of_node,
>>> +                       "reset-duration-ms", &duration);
>>
>> reset-duration-ms is listed as optional property, thus it should not be
>> an error
>> if it is not provided. Can you set some default in this case ? Or do
>> nothing ?
>>
>
> It takes module parameter, DT entry or falls back to built in default.
>

Hmm, you are right. Problem with that though is that it also accepts _invalid_
parameters.

I think it would be better to only return an error if the value is really wrong,
and abort in that case. Otherwise a duration of, say, 1000, will only result
in "unable to set duration", which is likely going to be overlooked.

The current code not distinguish between "no duration provided", "bad duration",
and "duration not accepted by hardware". It seems to me that the latter two
should be fatal and not just be ignored.

Thanks,
Guenter

