Return-path: <harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Mon, 05 Oct 2015 18:01:42 +0200
From: <harald@ccbib.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Wim Van Sebroeck <wim@iguana.be>, <rtc-linux@googlegroups.com>,
 <linux-watchdog@vger.kernel.org>, <kernel@pengutronix.de>,
 Wolfram Sang <wsa@the-dreams.de>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCHv2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
In-Reply-To: <561168F2.8090701@roeck-us.net>
References: <1443909258-24914-1-git-send-email-harald@ccbib.org> <561168F2.8090701@roeck-us.net>
Message-ID: <38ca74ac3e371018f9184f2147873bcc@imap.cosmopool.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, 4 Oct 2015 10:59:14 -0700, Guenter Roeck <linux@roeck-us.net>
wrote:
> On 10/03/2015 02:54 PM, Harald Geyer wrote:
>> When the watchdog is enabled, we set a persitent bit. After booting
>> we query the bit and see if the system was reset by the watchdog.
>>
>> This is somewhat similar to what the legacy driver from freescale
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
> 
> You should describe what you are doing, not how.

Ok, I'll try to improve.

> The reason for using persistent2 might be worth a comment in the
> code;

Ok.

> it does not belong into the description.

I think the motivation for a change and why I came out the way it
is, belong into the description of the change.

> This should be two patches, one to introduce boot status and one
> to register the notifier in the watchdog driver. The notifier patch
> should possibly come first.

Good point.

>> +	switch (code) {
>> +	case SYS_DOWN:	/* keep enabled, system might crash while going down
*/
>> +		pdata->wdt_clear_bootstatus(dev->parent);
> 
> If the system may crash while going down, which may cause a watchdog
reset,
> why clear the boot status here ?

Because if we don't clear the bootstatus then GETBOOTSTATUS would report a
watchdog reset even after nominal reboots.

Ideally we would use quite some more persistent bits to track why a system
rebooted, but AFAIK the kernel has no infrastructure for this yet. Also of
course user space should disable the watchdog before rebooting or halting
the system.

The patch is the closest I could get to the behaviour I expect, on a
device
that doesn't natively support GETBOOTSTATUS. If a different behaviour is
commonly expected, then tell me what it is.


Thanks,
Harald

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
>>   static int stmp3xxx_wdt_probe(struct platform_device *pdev)
>>   {
>> +	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(&pdev->dev);
>>   	int ret;
>>
>>   	watchdog_set_drvdata(&stmp3xxx_wdd, &pdev->dev);
>>
>>   	stmp3xxx_wdd.timeout = clamp_t(unsigned, heartbeat, 1,
>>   	STMP3XXX_MAX_TIMEOUT);
>>   	stmp3xxx_wdd.parent = &pdev->dev;
>> +	stmp3xxx_wdd.bootstatus = pdata->bootstatus;
>>
>>   	ret = watchdog_register_device(&stmp3xxx_wdd);
>>   	if (ret < 0) {
>> @@ -84,6 +112,9 @@ static int stmp3xxx_wdt_probe(struct platform_device
>> *pdev)
>>   		return ret;
>>   	}
>>
>> +	if (register_reboot_notifier(&wdt_notifier))
>> +		dev_warn(&pdev->dev, "cannot register reboot notifier\n");
>> +
>>   	dev_info(&pdev->dev, "initialized watchdog with heartbeat %ds\n",
>>   			stmp3xxx_wdd.timeout);
>>   	return 0;
>> @@ -91,6 +122,7 @@ static int stmp3xxx_wdt_probe(struct platform_device
>> *pdev)
>>
>>   static int stmp3xxx_wdt_remove(struct platform_device *pdev)
>>   {
>> +	unregister_reboot_notifier(&wdt_notifier);
>>   	watchdog_unregister_device(&stmp3xxx_wdd);
>>   	return 0;
>>   }
>> diff --git a/include/linux/stmp3xxx_rtc_wdt.h
>> b/include/linux/stmp3xxx_rtc_wdt.h
>> index 1dd12c9..62dd9e6 100644
>> --- a/include/linux/stmp3xxx_rtc_wdt.h
>> +++ b/include/linux/stmp3xxx_rtc_wdt.h
>> @@ -10,6 +10,8 @@
>>
>>   struct stmp3xxx_wdt_pdata {
>>   	void (*wdt_set_timeout)(struct device *dev, u32 timeout);
>> +	void (*wdt_clear_bootstatus)(struct device *dev);
>> +	unsigned int bootstatus;
>>   };
>>
>>   #endif /* __LINUX_STMP3XXX_RTC_WDT_H */
>>
