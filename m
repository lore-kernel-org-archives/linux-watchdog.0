Return-path: <Vladimir_Zapolskiy@mentor.com>
Subject: Re: [PATCH v3 4/6] watchdog: add watchdog pretimeout framework
To: Guenter Roeck <linux@roeck-us.net>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-5-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160607214309.GA17129@roeck-us.net> <57581FB2.10806@mentor.com>
 <57582363.8050406@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <wsa@the-dreams.de>, Robin
 Gong <b38343@freescale.com>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <5758358A.602@mentor.com>
Date: Wed, 8 Jun 2016 18:11:06 +0300
MIME-Version: 1.0
In-Reply-To: <57582363.8050406@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 08.06.2016 16:53, Guenter Roeck wrote:
> On 06/08/2016 06:37 AM, Vladimir Zapolskiy wrote:
> 
>>>>
>>>> +comment "Watchdog Pretimeout Governors"
>>>> +
>>>> +config WATCHDOG_PRETIMEOUT_GOV
>>>> +	bool "Enable watchdog pretimeout governors"
>>>> +	default n
>>>
>>> I don't think 'default n" is needed.
>>>
>>
>> No strict objections, but probably 'default n' may save quite many
>> lines in defconfigs.
>>
> 
> I always wondered why it would be necessary to say "default n".
> What is the difference between "default n" and no explicit default ?
> 

I pointed out that it may have impact on defconfig, but experimentally
it has no effect.

Users of "make oldconfig" get a prompt in both cases as well.

Also I haven't found any difference for silentoldconfig, olddefconfig
and alldefconfig, I assume explicit "default n" and "def_bool n"
can be safely dropped.

--
Best wishes,
Vladimir
