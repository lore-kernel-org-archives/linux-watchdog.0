Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:52254 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbbDSNlq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 19 Apr 2015 09:41:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Sun, 19 Apr 2015 15:41:42 +0200
From: <harald@ccbib.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: <rtc-linux@googlegroups.com>, Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [rtc-linux] [PATCH] watchdog: stmp3xxx: Implement GETBOOTSTATUS
In-Reply-To: <20150417093023.GF29796@piout.net>
References: <1428522355-5164-1-git-send-email-harald@ccbib.org> <20150417093023.GF29796@piout.net>
Message-ID: <3a787a0b2777c4b734a4f153e1a3f7d7@imap.cosmopool.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi!

On Fri, 17 Apr 2015 11:30:23 +0200, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
> 
> On 08/04/2015 at 19:45:55 +0000, Harald Geyer wrote :
>> When the watchdog is enabled, we set a persitent bit. After booting
>> we query the bit and see if the system was reset by the watchdog.
>> 
>> This is somewhat similiar to what the legacy driver from freescale
>            similar ^
> 
>> does. However we use STMP3XXX_RTC_PERSISTENT2 instead of
>> STMP3XXX_RTC_PERSISTENT1. I tried that first, but it seems I can't
>> clear the bit there once it is set. I didn't find any documentation
>> what this register does - only vague hints that it is meant to
>> control the boot ROM.
>> 
>> Part of the code from the legacy driver touching this register
>> is still included. Maybe this is stale, but this patch doesn't
>> touch any of it because I don't know what it really does or is
>> meant to do.
>> 
>> Signed-off-by: Harald Geyer <harald@ccbib.org>
> 
> The RTC part seems ok to me but the driver itself would benefit from a
> few improvements:
>  - use STMP_OFFSET_REG_(SET|CLR) instead of defining _SET and _CLR for
>    STMP3XXX_RTC_CTRL and STMP3XXX_RTC_PERSISTENT0

This should be easy enough.

>  - use syscon instead of passing callbacks to the watchdog driver

I will put looking into this onto my todo list, but I'm not familiar
with syscon yet and it is not obvious to me how to port the rtc driver
to syscon without breaking devicetree backwards compatibility. So I'd
like to defer this for later unless somebody gives me some guidance.

> It would be greatly appreciated if you could do those changes too.

Is it ok if I send the simple cleanup patch and a rebased version of
my original patch without the syscon conversion? This will be more work
for me testing two patch series, but I think GETBOOTSTATUS is an
important feature that I'd like to see supported soon.

TIA,
Harald
 
>> ---
>>  drivers/rtc/rtc-stmp3xxx.c          |   23 +++++++++++++++++++++++
>>  drivers/watchdog/stmp3xxx_rtc_wdt.c |   34
>>  +++++++++++++++++++++++++++++++++-
>>  include/linux/stmp3xxx_rtc_wdt.h    |    2 ++
>>  3 files changed, 58 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
>> index 2939cdc..55ab9ba 100644
>> --- a/drivers/rtc/rtc-stmp3xxx.c
>> +++ b/drivers/rtc/rtc-stmp3xxx.c
>> @@ -30,6 +30,7 @@
>>  #include <linux/of.h>
>>  #include <linux/stmp_device.h>
>>  #include <linux/stmp3xxx_rtc_wdt.h>
>> +#include <linux/watchdog.h>
>>  
>>  #define STMP3XXX_RTC_CTRL			0x0
>>  #define STMP3XXX_RTC_CTRL_SET			0x4
>> @@ -60,6 +61,9 @@
>>  /* missing bitmask in headers */
>>  #define STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER	0x80000000
>>  
>> +#define STMP3XXX_RTC_PERSISTENT2		0x80
>> +#define STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE	0x00000001
>> +
>>  struct stmp3xxx_rtc_data {
>>  	struct rtc_device *rtc;
>>  	void __iomem *io;
>> @@ -81,6 +85,14 @@ struct stmp3xxx_rtc_data {
>>   * registers is atomic.
>>   */
>>  
>> +static void stmp3xxx_wdt_clear_bootstatus(struct device *dev)
>> +{
>> +	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
>> +
>> +	writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
>> +	       STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_CLR +
rtc_data->io);
>> +}
>> +
>>  static void stmp3xxx_wdt_set_timeout(struct device *dev, u32 timeout)
>>  {
>>  	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
>> @@ -91,16 +103,22 @@ static void stmp3xxx_wdt_set_timeout(struct device
>> *dev, u32 timeout)
>>  		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_SET);
>>  		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
>>  		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 +
STMP_OFFSET_REG_SET);
>> +		writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
>> +		       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 +
STMP_OFFSET_REG_SET);
>>  	} else {
>>  		writel(STMP3XXX_RTC_CTRL_WATCHDOGEN,
>>  		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
>>  		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
>>  		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 +
STMP_OFFSET_REG_CLR);
>> +		writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
>> +		       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 +
STMP_OFFSET_REG_CLR);
>>  	}
>>  }
>>  
>>  static struct stmp3xxx_wdt_pdata wdt_pdata = {
>>  	.wdt_set_timeout = stmp3xxx_wdt_set_timeout,
>> +	.wdt_clear_bootstatus = stmp3xxx_wdt_clear_bootstatus,
>> +	.bootstatus = 0,
>>  };
>>  
>>  static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
>> @@ -108,6 +126,8 @@ static void stmp3xxx_wdt_register(struct
>> platform_device *rtc_pdev)
>>  	struct platform_device *wdt_pdev =
>>  		platform_device_alloc("stmp3xxx_rtc_wdt", rtc_pdev->id);
>>  
>> +	stmp3xxx_wdt_clear_bootstatus(&rtc_pdev->dev);
>> +
>>  	if (wdt_pdev) {
>>  		wdt_pdev->dev.parent = &rtc_pdev->dev;
>>  		wdt_pdev->dev.platform_data = &wdt_pdata;
>> @@ -304,6 +324,9 @@ static int stmp3xxx_rtc_probe(struct
platform_device
>> *pdev)
>>  		return err;
>>  	}
>>  
>> +	if (readl(STMP3XXX_RTC_PERSISTENT2 + rtc_data->io) &
>> +			 STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE)
>> +		wdt_pdata.bootstatus |= WDIOF_CARDRESET;
>>  	stmp3xxx_wdt_register(pdev);
>>  	return 0;
>>  }
>> diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c
>> b/drivers/watchdog/stmp3xxx_rtc_wdt.c
>> index a62b1b6..5b3f12a8 100644
>> --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
>> +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
>> @@ -14,6 +14,8 @@
>>  #include <linux/watchdog.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/stmp3xxx_rtc_wdt.h>
>> +#include <linux/notifier.h>
>> +#include <linux/reboot.h>
>>  
>>  #define WDOG_TICK_RATE 1000 /* 1 kHz clock */
>>  #define STMP3XXX_DEFAULT_TIMEOUT 19
>> @@ -50,7 +52,8 @@ static int wdt_set_timeout(struct watchdog_device
>> *wdd, unsigned new_timeout)
>>  }
>>  
>>  static const struct watchdog_info stmp3xxx_wdt_ident = {
>> -	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>> +	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING
|
>> +		WDIOF_CARDRESET,
>>  	.identity = "STMP3XXX RTC Watchdog",
>>  };
>>  
>> @@ -69,13 +72,38 @@ static struct watchdog_device stmp3xxx_wdd = {
>>  	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
>>  };
>>  
>> +static int wdt_notify_sys(struct notifier_block *nb, unsigned long
code,
>> +			  void *unused)
>> +{
>> +	struct device *dev = watchdog_get_drvdata(&stmp3xxx_wdd);
>> +	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(dev);
>> +
>> +	switch (code) {
>> +	case SYS_DOWN:	/* keep enabled, system might crash while going down
*/
>> +		pdata->wdt_clear_bootstatus(dev->parent);
>> +		break;
>> +	case SYS_HALT:  /* allow the system to actually halt */
>> +	case SYS_POWER_OFF:
>> +		wdt_stop(&stmp3xxx_wdd);
>> +		break;
>> +	}
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block wdt_notifier = {
>> +	.notifier_call  = wdt_notify_sys,
>> +};
>> +
>>  static int stmp3xxx_wdt_probe(struct platform_device *pdev)
>>  {
>> +	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(&pdev->dev);
>>  	int ret;
>>  
>>  	watchdog_set_drvdata(&stmp3xxx_wdd, &pdev->dev);
>>  
>>  	stmp3xxx_wdd.timeout = clamp_t(unsigned, heartbeat, 1,
>>  	STMP3XXX_MAX_TIMEOUT);
>> +	stmp3xxx_wdd.bootstatus = pdata->bootstatus;
>>  
>>  	ret = watchdog_register_device(&stmp3xxx_wdd);
>>  	if (ret < 0) {
>> @@ -83,6 +111,9 @@ static int stmp3xxx_wdt_probe(struct platform_device
>> *pdev)
>>  		return ret;
>>  	}
>>  
>> +	if (register_reboot_notifier(&wdt_notifier))
>> +		dev_warn(&pdev->dev, "cannot register reboot notifier\n");
>> +
>>  	dev_info(&pdev->dev, "initialized watchdog with heartbeat %ds\n",
>>  			stmp3xxx_wdd.timeout);
>>  	return 0;
>> @@ -90,6 +121,7 @@ static int stmp3xxx_wdt_probe(struct platform_device
>> *pdev)
>>  
>>  static int stmp3xxx_wdt_remove(struct platform_device *pdev)
>>  {
>> +	unregister_reboot_notifier(&wdt_notifier);
>>  	watchdog_unregister_device(&stmp3xxx_wdd);
>>  	return 0;
>>  }
>> diff --git a/include/linux/stmp3xxx_rtc_wdt.h
>> b/include/linux/stmp3xxx_rtc_wdt.h
>> index 1dd12c9..62dd9e6 100644
>> --- a/include/linux/stmp3xxx_rtc_wdt.h
>> +++ b/include/linux/stmp3xxx_rtc_wdt.h
>> @@ -10,6 +10,8 @@
>>  
>>  struct stmp3xxx_wdt_pdata {
>>  	void (*wdt_set_timeout)(struct device *dev, u32 timeout);
>> +	void (*wdt_clear_bootstatus)(struct device *dev);
>> +	unsigned int bootstatus;
>>  };
>>  
>>  #endif /* __LINUX_STMP3XXX_RTC_WDT_H */
>> -- 
>> 1.7.10.4
>> 
>> -- 
>> -- 
>> You received this message because you are subscribed to "rtc-linux".
>> Membership options at http://groups.google.com/group/rtc-linux .
>> Please read http://groups.google.com/group/rtc-linux/web/checklist
>> before submitting a driver.
>> --- 
>> You received this message because you are subscribed to the Google
>> Groups "rtc-linux" group.
>> To unsubscribe from this group and stop receiving emails from it, send
>> an email to rtc-linux+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
