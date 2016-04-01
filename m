Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41957 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbcDAMfn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 Apr 2016 08:35:43 -0400
Subject: Re: [PATCH 1/4] watchdog: renesas-wdt: add driver
To: Wolfram Sang <wsa@the-dreams.de>
References: <1459351725-14144-1-git-send-email-wsa@the-dreams.de>
 <1459351725-14144-2-git-send-email-wsa@the-dreams.de>
 <20160330233411.GA24844@roeck-us.net> <20160401113629.GA2513@katana>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56FE6B20.3040209@roeck-us.net>
Date: Fri, 1 Apr 2016 05:35:44 -0700
MIME-Version: 1.0
In-Reply-To: <20160401113629.GA2513@katana>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On 04/01/2016 04:36 AM, Wolfram Sang wrote:
> Hi Guenter,
>
>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>>> +module_param(nowayout, bool, S_IRUGO);
>>
>> Sure you want this parameter readable ? No problem with me, but it is unusual,
>> so I figure it is worth asking.
>
> No reason, will stick to the usual case.
>
>>> +static void rwdt_write(struct rwdt_priv *priv, u32 val, unsigned reg)
>>
>> Please use 'unsigned int' throughout.
>
> Can do. May I ask why?
>

There are people changing unsigned -> unsigned int with coccinelle scripts.
Besides that, checkpatch warns about it.

Sure, I know, checkpatch is just a script, I know that story, but I don't
want to have to deal with the inevitable follow-up patches.

>>> +	rwdt_write(priv, 65536 - wdev->timeout * priv->clks_per_sec, RWTCNT);
>>> +
>>
>> Just wondering, does reading RWTCNT return the remaining timeout ?
>> If so, you could easily implement WDIOC_GETTIMEOUT.
>
> I assume you mean GETTIMELEFT. Tried that, seems to work.
>
Yes, sorry.

Thanks,
Guenter

>> function. In other words, you can just drop rwdt_set_timeout() entirely.
>
> Cool news! Works fine.
>
> Thanks for the prompt review! Will send V2 in a minute.
>
>     Wolfram
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

