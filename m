Return-path: <knpo@ieee.org>
Subject: Re: [PATCH v2] watchdog: f71808e_wdt: Add F81865 support
To: Guenter Roeck <linux@roeck-us.net>
References: <571A0F95.6000509@ieee.org> <571A2C4F.8020304@roeck-us.net>
 <571A2E2E.4020406@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
 Linux Watchdog <linux-watchdog@vger.kernel.org>
From: Knud Poulsen <knpo@ieee.org>
Message-ID: <571A32FA.7000105@ieee.org>
Date: Fri, 22 Apr 2016 16:19:38 +0200
MIME-Version: 1.0
In-Reply-To: <571A2E2E.4020406@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>



On 2016-04-22 15:59, Guenter Roeck wrote:
> On 04/22/2016 06:51 AM, Guenter Roeck wrote:
>> On 04/22/2016 04:48 AM, Knud Poulsen wrote:
>>> Adds watchdog support for Fintek F81865 Super-IO chip to
>>> Fintek wdt driver (f71808e_wdt)
>>>
>>> Tested and verified on Lanner LEC-3030 Industrial PC
>>>
>>> Datasheet references:
>>> http://www.hardwaresecrets.com/datasheets/F81865_V028P.pdf
>>> http://www.alldatasheet.com/datasheet-pdf/pdf/406317/FINTEK/F81865.html
>>>
>>> Signed-off-by: Knud Poulsen <knpo@ieee.org>
>>> ---
>>>   drivers/watchdog/f71808e_wdt.c | 31 +++++++++++++++++++++++++++----
>>>   1 file changed, 27 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
>>> index 016bd93..4133cd3 100644
>>> --- a/drivers/watchdog/f71808e_wdt.c
>>> +++ b/drivers/watchdog/f71808e_wdt.c
>>> @@ -59,6 +59,7 @@
>>>   #define SIO_F71869A_ID        0x1007    /* Chipset ID */
>>>   #define SIO_F71882_ID        0x0541    /* Chipset ID */
>>>   #define SIO_F71889_ID        0x0723    /* Chipset ID */
>>> +#define SIO_F81865_ID        0x0704    /* Chipset ID */
>>>
>>>   #define F71808FG_REG_WDO_CONF        0xf0
>>>   #define F71808FG_REG_WDT_CONF        0xf5
>>> @@ -71,6 +72,10 @@
>>>   #define F71808FG_FLAG_WD_PULSE        4
>>>   #define F71808FG_FLAG_WD_UNIT        3
>>>
>>> +#define F81865_REG_WDO_CONF        0xfa
>>> +#define F81865_FLAG_WDOUT_EN        0
>>> +#define F81865_FLAG_WDTMOUT_STS        6
>>> +
> [ ... ]
> 
>>>
>>>       wdt_conf = superio_inb(sioaddr, F71808FG_REG_WDT_CONF);
>>> -    watchdog.caused_reboot = wdt_conf & F71808FG_FLAG_WDTMOUT_STS;
>>> +
>>> +    if (watchdog.type == f81865)
>>> +        watchdog.caused_reboot = wdt_conf & F81865_FLAG_WDTMOUT_STS;
>>> +    else
>>> +        watchdog.caused_reboot = wdt_conf & F71808FG_FLAG_WDTMOUT_STS;
>>>
>> Are you sure this one is correct ? The bit configuration is exactly the same
>> as with other chips supported by this driver. Actually, I don't see an indication
>> in any of the datasheets I have which would suggest that reading bit 5 means
>> that the last reboot occurred due to a watchdog timeout. As far as I can see,
>> it just means that the watchdog is enabled.
>>
>> Am I missing something here ?
>>
> After another look, I am even more confused. F81865_FLAG_WDTMOUT_STS and
> F71808FG_FLAG_WDTMOUT_STS are bit maps, not bits.
> 
> 5 = 0b0101, 6 = 0b0110. Bit 0/1 select the pulse width, bit 2 selects
> the output polarity of RSTOUT. What does this have to do with the reboot cause ?

You're right, great catch!!, I didn't grok the bit-map, not bit-index part here
and got thrown by the 6 vs 5 in the datasheet vs the existing code, *Doh*

ps3 en route.

BR,
Knud

> 
> Thanks,
> Guenter
> 
