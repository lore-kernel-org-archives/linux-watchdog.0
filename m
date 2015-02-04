Return-path: <blogic@openwrt.org>
Message-ID: <54D2293D.8000100@openwrt.org>
Date: Wed, 04 Feb 2015 15:14:21 +0100
From: John Crispin <blogic@openwrt.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, Paul Bolle <pebolle@tiscali.nl>,
 John Crispin <blogic@openwrt.org>
CC: Wim Van Sebroeck <wim@iguana.be>, Ralf Baechle <ralf@linux-mips.org>,
 Valentin Rothberg <valentinrothberg@gmail.com>,
 linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
 linux-kernel@vger.kernel.org
Subject: Re: watchdog: SOC_MT7621?
References: <1423044809.23894.65.camel@x220> <54D1F248.4090406@openwrt.org>      <1423047893.23022.13.camel@x220> <54D1FE0F.3030308@openwrt.org> <1423052553.30076.6.camel@tiscali.nl> <54D225D6.6040603@roeck-us.net>
In-Reply-To: <54D225D6.6040603@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>



On 04/02/2015 14:59, Guenter Roeck wrote:
> On 02/04/2015 04:22 AM, Paul Bolle wrote:
>> John Crispin schreef op wo 04-02-2015 om 12:10 [+0100]:
>>> i think wim should just drop it and we leave it in openwrt with the
>>> other 1/2 million patches that we have. i prefer to upstream the stuff
>>> without feeling pressured to hurry up, that kills the fun.
>>
>> Once code is mainlined you'll get fixes written for you, updates done
>> for you, etc. But you'll also get pointed at defects that require you to
>> fix them yourself, or see the code removed eventually.
>>
>>> @Wim, can you drop the patch please ?
>>
>> Why should Wim drop more than the
>>      || SOC_MT7621
>>
>> snippet?
>>
> 
> Question is if the driver works with MT7620 as advertised. Either case
> it would be odd if the driver advertises itself as MT7621 but only works
> for MT7620, so I think it should be dropped entirely for now.
> 
> Wim, should I possibly ask Stephen to include my watchdog-next branch
> in his -next builds ? This would help us catching such problems earlier.
> 
> Thanks,
> Guenter
> 
> 
> 


it wont work on mt7620 but on mt7628 which is a subtype on mt7620. both
share the soc_mt7620.c inside arch/mips/ralink/ we rely on runtime
detection between the 2 and on the dts loading the correct driver.

mt7620 and mt7628 are both hidden behind the SOC_MT7620 symbol. the
﻿depends on SOC_MT7620 part is correct and working. but i agree, just
drop it, i will simply carry it around with us in openwrt. one driver
more wont make a difference.

	John
