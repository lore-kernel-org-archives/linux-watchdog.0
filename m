Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36828 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdAUTBZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 21 Jan 2017 14:01:25 -0500
Subject: Re: [PATCH] watchdog: softdog: make pretimeout support a compile
 option
To: Wolfram Sang <wsa@the-dreams.de>
References: <20170106084144.22324-1-wsa+renesas@sang-engineering.com>
 <20170110175840.GB13904@roeck-us.net>
 <20170119201452.hv3zkmlhiz7rzb44@ninjato>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Vladimir Zapolskiy <vz@mleia.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <073c43b8-41ae-92c0-957a-0d57b6874066@roeck-us.net>
Date: Sat, 21 Jan 2017 11:01:21 -0800
MIME-Version: 1.0
In-Reply-To: <20170119201452.hv3zkmlhiz7rzb44@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/19/2017 12:14 PM, Wolfram Sang wrote:
>
>>> +#if IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT)
>>>  static void softdog_pretimeout(unsigned long data)
>>
>> I would prefer __maybe_unused here ..
>>
>>>  {
>>>  	watchdog_notify_pretimeout(&softdog_dev);
>>> @@ -82,16 +83,23 @@ static void softdog_pretimeout(unsigned long data)
>>>  static struct timer_list softdog_preticktock =
>>>  		TIMER_INITIALIZER(softdog_pretimeout, 0, 0);
>>>
>>> +static struct timer_list *softdog_preticktock_ptr = &softdog_preticktock;
>>> +#else
>>> +static void *softdog_preticktock_ptr = NULL;
>>> +#endif /* CONFIG_SOFT_WATCHDOG_PRETIMEOUT */
>>> +
>>>  static int softdog_ping(struct watchdog_device *w)
>>>  {
>>>  	if (!mod_timer(&softdog_ticktock, jiffies + (w->timeout * HZ)))
>>>  		__module_get(THIS_MODULE);
>>>
>>> -	if (w->pretimeout)
>>> -		mod_timer(&softdog_preticktock, jiffies +
>>> -			  (w->timeout - w->pretimeout) * HZ);
>>> -	else
>>> -		del_timer(&softdog_preticktock);
>>> +	if (softdog_preticktock_ptr) {
>>
>> and "if (IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT))" here.
>>
>>> +		if (w->pretimeout)
>>> +			mod_timer(softdog_preticktock_ptr, jiffies +
>>> +				  (w->timeout - w->pretimeout) * HZ);
>>> +		else
>>> +			del_timer(softdog_preticktock_ptr);
>>> +	}
>>>
>>>  	return 0;
>>>  }
>>> @@ -101,15 +109,15 @@ static int softdog_stop(struct watchdog_device *w)
>>>  	if (del_timer(&softdog_ticktock))
>>>  		module_put(THIS_MODULE);
>>>
>>> -	del_timer(&softdog_preticktock);
>>> +	if (softdog_preticktock_ptr)
>>
>> Is this conditional needed (assuming we get rid of softdog_preticktock_ptr) ?
>> Ok though if you want to use it to drop the code if not needed.
>
> Yes. I tried a few variations and this is the outcome which I liked
> best, because it is quite readable, keeps all the extra stuff within one
> block and has 0 size penalty when the feature is not enabled.
>
> I'd like to keep it this way unless you have a strong opinion.
>
>
I personally prefer the use of IS_ENABLED over #ifdefs, because it ensures
that the code always compiles, and it doesn't incur any runtime penalties either.

Guenter

