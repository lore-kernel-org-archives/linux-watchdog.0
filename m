Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47522 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbaILCte (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Sep 2014 22:49:34 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XSGvV-001KH2-Q8
	for linux-watchdog@vger.kernel.org; Fri, 12 Sep 2014 02:49:34 +0000
Message-ID: <54125F1E.3050605@roeck-us.net>
Date: Thu, 11 Sep 2014 19:49:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jingchang Lu <jingchang.lu@freescale.com>
CC: "wim@iguana.be" <wim@iguana.be>,
	Shawn Guo <Shawn.Guo@freescale.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] watchdog: imx2_wdt: add restart handler support
References: <1410421661-15298-1-git-send-email-jingchang.lu@freescale.com> <20140911155522.GB13052@roeck-us.net> <299ae9bd88c049ea833e964e4b5f54a0@BL2PR03MB467.namprd03.prod.outlook.com>
In-Reply-To: <299ae9bd88c049ea833e964e4b5f54a0@BL2PR03MB467.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/11/2014 07:42 PM, Jingchang Lu wrote:
>> -----Original Message-----
>> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
>> Sent: Thursday, September 11, 2014 11:55 PM
>> To: Lu Jingchang-B35083
>> Cc: wim@iguana.be; Guo Shawn-R65073; arnd@arndb.de; linux-
>> watchdog@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH] watchdog: imx2_wdt: add restart handler support
>>
>> On Thu, Sep 11, 2014 at 03:47:41PM +0800, Jingchang Lu wrote:
>>>    Register the watchdog as the system restart function
>>> to the new introducing kernel restart call chain in the
>>> driver instead of providing the restart in machine desc.
>>>    This restart handler function is from the mxc_restart()
>>> in arch/arm/mach-imx/system.c
>>>
>>> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
>>> ---
>>>   drivers/watchdog/imx2_wdt.c | 37 +++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 37 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
>>> index 68c3d37..fa723e8 100644
>>> --- a/drivers/watchdog/imx2_wdt.c
>>> +++ b/drivers/watchdog/imx2_wdt.c
>>> @@ -22,14 +22,17 @@
>>>    */
>>>
>>>   #include <linux/clk.h>
>>> +#include <linux/delay.h>
>>>   #include <linux/init.h>
>>>   #include <linux/io.h>
>>>   #include <linux/jiffies.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/module.h>
>>>   #include <linux/moduleparam.h>
>>> +#include <linux/notifier.h>
>>>   #include <linux/of_address.h>
>>>   #include <linux/platform_device.h>
>>> +#include <linux/reboot.h>
>>>   #include <linux/regmap.h>
>>>   #include <linux/timer.h>
>>>   #include <linux/watchdog.h>
>>> @@ -59,6 +62,7 @@ struct imx2_wdt_device {
>>>   	struct regmap *regmap;
>>>   	struct timer_list timer;	/* Pings the watchdog when closed */
>>>   	struct watchdog_device wdog;
>>> +	struct notifier_block restart_handler;
>>>   };
>>>
>>>   static bool nowayout = WATCHDOG_NOWAYOUT;
>>> @@ -77,6 +81,31 @@ static const struct watchdog_info imx2_wdt_info = {
>>>   	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
>>>   };
>>>
>>> +static int imx2_restart_handler(struct notifier_block *this, unsigned
>> long mode,
>>> +				void *cmd)
>>> +{
>>> +	unsigned int wcr_enable = IMX2_WDT_WCR_WDE;
>>
>> In the original code this value is conditional depending on cpu_is_mx1().
>> Are there any implications for this reset mechanism ? Does mx1 have a
>> different watchdog driver ?
>>
> Hi, Shawn, is this driver also used by the mx1 SoC?
> The imx2_wdt.c says it is for IMX2 and later processors, so when moving the
> restart function, I removed the cpu_is_mx1() condition determination, Thanks.
>
I assumed that the original code would be removed. If you have to keep it
around for mx1, the conversion doesn't seem to make much sense as you
just end up having the code twice. Am I missing something ?

Thanks,
Guenter

