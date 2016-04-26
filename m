Return-path: <knpo@ieee.org>
Subject: Re: [PATCH] watchdog: f71808e_wdt: Fix WDTMOUT_STS register read
To: Guenter Roeck <linux@roeck-us.net>
References: <571E353F.4020303@ieee.org> <571EC716.5020905@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
 Linux Watchdog <linux-watchdog@vger.kernel.org>
From: Knud Poulsen <knpo@ieee.org>
Message-ID: <571F0CB4.1030700@ieee.org>
Date: Tue, 26 Apr 2016 08:37:40 +0200
MIME-Version: 1.0
In-Reply-To: <571EC716.5020905@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 2016-04-26 03:40, Guenter Roeck wrote:
> On 04/25/2016 08:18 AM, Knud Poulsen wrote:
>> Tested and verified on Lanner LEC-3030 Industrial PC (with F81865)
>>
>> Datasheet verified for
>>   F71808, F71858, F71862, F71869, F71869A, F71882, F71889, F81865
>>
>> Datasheet references:
>> F71808A:
>>   http://www.electronicsdatasheets.com/download/534cf560e34e2406135f4658.pdf?format=pdf
>> F71858:
>>   http://www.electronicsdatasheets.com/download/534cf55fe34e2406135f4635.pdf?format=pdf
>> F71862:
>>   http://www.hardwaresecrets.com/datasheets/F71862_V027P.pdf
>> F71869:
>>   http://www.clubedohardware.com.br/datasheets/366451_F71869.pdf
>> F71869A:
>>   http://www.chipset-ic.com/datasheet/F71869AD.pdf
>> F71882:
>>   http://www.digchip.com/datasheets/parts/datasheet/931/F71882-pdf.php
>> F71889:
>>   http://pdf1.alldatasheet.com/datasheet-pdf/view/406312/FINTEK/F71889.html
>> F81865:
>>   http://www.hardwaresecrets.com/datasheets/F81865_V028P.pdf
>>   http://www.alldatasheet.com/datasheet-pdf/pdf/406317/FINTEK/F81865.html
> 
> Nice work tracking those down!

Thanks :), took a while, and you're right: that register has never changed,
I guess no one's ever actually used the WDTMOUT_STS feature, cause it's clearly never
reported the correct state back.

> 
>>
>> Signed-off-by: Knud Poulsen <knpo@ieee.org>
>> ---
>>   drivers/watchdog/f71808e_wdt.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
>> index 016bd93..6a9deac 100644
>> --- a/drivers/watchdog/f71808e_wdt.c
>> +++ b/drivers/watchdog/f71808e_wdt.c
>> @@ -66,7 +66,7 @@
>>
>>   #define F71808FG_FLAG_WDOUT_EN		7
>>
>> -#define F71808FG_FLAG_WDTMOUT_STS	5
>> +#define F71808FG_FLAG_WDTMOUT_STS_BITMASK	0x40 /* Bit 6 */
> 
> For consistency with the rest of the code, please use F71808FG_FLAG_WDTMOUT_STS
> and later BIT(F71808FG_FLAG_WDTMOUT_STS).

Ack

> 
> If you care to send a patch, the usage of F71808FG_FLAG_WDOUT_EN
> is also wrong in one place (in watchdog_is_running()).

No problem, will send separate patch

> 
> Thanks,
> Guenter
> 
>>   #define F71808FG_FLAG_WD_EN		5
>>   #define F71808FG_FLAG_WD_PULSE		4
>>   #define F71808FG_FLAG_WD_UNIT		3
>> @@ -655,7 +655,7 @@ static int __init watchdog_init(int sioaddr)
>>   	superio_select(watchdog.sioaddr, SIO_F71808FG_LD_WDT);
>>
>>   	wdt_conf = superio_inb(sioaddr, F71808FG_REG_WDT_CONF);
>> -	watchdog.caused_reboot = wdt_conf & F71808FG_FLAG_WDTMOUT_STS;
>> +	watchdog.caused_reboot = wdt_conf & F71808FG_FLAG_WDTMOUT_STS_BITMASK;
>>
>>   	superio_exit(sioaddr);
>>
> 
