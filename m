Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:44044 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbbKXN1W (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 08:27:22 -0500
Subject: Re: [PATCH 5/6] watchdog: pretimeout: add device specific notifier
 pretimeout governor
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1448089910-11453-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1448089910-11453-6-git-send-email-vladimir_zapolskiy@mentor.com>
 <565405A4.8020200@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <56546564.20207@mentor.com>
Date: Tue, 24 Nov 2015 15:25:56 +0200
MIME-Version: 1.0
In-Reply-To: <565405A4.8020200@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

On 24.11.2015 08:37, Guenter Roeck wrote:
> On 11/20/2015 11:11 PM, Vladimir Zapolskiy wrote:
>> Device watchdog pretimeout governor sends a notification back to a
>> watchdog device for further handling. This governor does nothing, if
>> watchdog driver does not define a pretimeout callback.
>>
> 
> I can not make up my mind - should this be "device" or "driver" specific ?

I was hesitating to select between "device" and "driver", technically
"driver" should be more appropriate, but I'm not aware of users' accepted
terminology, I believe ordinary users more often operate with "devices"
rather than "drivers".

Anyway it is not sufficient for me, I can rename it, if you ask.

Best wishes,
Vladimir

>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>> ---
>>   drivers/watchdog/Kconfig             | 15 +++++++++++
>>   drivers/watchdog/Makefile            |  1 +
>>   drivers/watchdog/pretimeout_device.c | 49 ++++++++++++++++++++++++++++++++++++
>>   include/linux/watchdog.h             |  2 ++
>>   4 files changed, 67 insertions(+)
>>   create mode 100644 drivers/watchdog/pretimeout_device.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 7e9e2bb..6c1f7e1 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1662,6 +1662,13 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_USERSPACE
>>   	  Use userspace notifier watchdog pretimeout governor
>>   	  by default.
>>
>> +config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_DEVICE
>> +	bool "device"
>> +	select WATCHDOG_PRETIMEOUT_GOV_DEVICE
>> +	help
>> +	  Use device specific watchdog pretimeout event handler
>> +	  by default.
>> +
>>   endchoice
>>
>>   config WATCHDOG_PRETIMEOUT_GOV_NOOP
>> @@ -1683,6 +1690,14 @@ config WATCHDOG_PRETIMEOUT_GOV_USERSPACE
>>   	  pretimeout event send a notification to userspace for
>>   	  further handling.
>>
>> +config WATCHDOG_PRETIMEOUT_GOV_DEVICE
>> +	tristate "Own device watchdog pretimeout governor"
>> +	help
>> +	  Device watchdog pretimeout governor sends a notification
>> +	  back to a watchdog device for further handling. This governor
>> +	  does nothing, if watchdog driver does not define a pretimeout
>> +	  callback.
>> +
>>   endif # WATCHDOG_PRETIMEOUT_GOV
>>
>>   endif # WATCHDOG
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 7d6755b..0717b64 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -11,6 +11,7 @@ watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV)	+= watchdog_pretimeout.o
>>   obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)	+= pretimeout_noop.o
>>   obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)	+= pretimeout_panic.o
>>   obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_USERSPACE)	+= pretimeout_userspace.o
>> +obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_DEVICE)	+= pretimeout_device.o
>>
>>   # Only one watchdog can succeed. We probe the ISA/PCI/USB based
>>   # watchdog-cards first, then the architecture specific watchdog
>> diff --git a/drivers/watchdog/pretimeout_device.c b/drivers/watchdog/pretimeout_device.c
>> new file mode 100644
>> index 0000000..4ce992b
>> --- /dev/null
>> +++ b/drivers/watchdog/pretimeout_device.c
>> @@ -0,0 +1,49 @@
>> +/*
>> + * Copyright (C) 2015 Mentor Graphics
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/watchdog.h>
>> +
>> +#include <watchdog_pretimeout.h>
>> +
>> +/**
>> + * pretimeout_device - Run device specific handler on watchdog pretimeout event
>> + * @wdd - watchdog_device
>> + *
>> + */
>> +static void pretimeout_device(struct watchdog_device *wdd)
>> +{
>> +	if (wdd->ops->pretimeout)
>> +		wdd->ops->pretimeout(wdd);
>> +}
>> +
>> +static struct watchdog_governor watchdog_gov_device = {
>> +	.name		= "device",
>> +	.pretimeout	= pretimeout_device,
>> +#ifdef CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_DEVICE
>> +	.is_default	= true,
>> +#endif
>> +};
>> +
>> +static int __init watchdog_gov_device_register(void)
>> +{
>> +	return watchdog_register_governor(&watchdog_gov_device);
>> +}
>> +
>> +static void __exit watchdog_gov_device_unregister(void)
>> +{
>> +	watchdog_unregister_governor(&watchdog_gov_device);
>> +}
>> +module_init(watchdog_gov_device_register);
>> +module_exit(watchdog_gov_device_unregister);
>> +
>> +MODULE_AUTHOR("Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>");
>> +MODULE_DESCRIPTION("Device specific watchdog pretimeout governor");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
>> index 960223e..597dcfb 100644
>> --- a/include/linux/watchdog.h
>> +++ b/include/linux/watchdog.h
>> @@ -27,6 +27,7 @@ struct watchdog_governor;
>>    * @status:	The routine that shows the status of the watchdog device.
>>    * @set_timeout:The routine for setting the watchdog devices timeout value (in seconds).
>>    * @get_timeleft:The routine that gets the time left before a reset (in seconds).
>> + * @pretimeout: The routine that runs driver specific handler of pretimeout event.
>>    * @ref:	The ref operation for dyn. allocated watchdog_device structs
>>    * @unref:	The unref operation for dyn. allocated watchdog_device structs
>>    * @ioctl:	The routines that handles extra ioctl calls.
>> @@ -46,6 +47,7 @@ struct watchdog_ops {
>>   	unsigned int (*status)(struct watchdog_device *);
>>   	int (*set_timeout)(struct watchdog_device *, unsigned int);
>>   	unsigned int (*get_timeleft)(struct watchdog_device *);
>> +	void (*pretimeout)(struct watchdog_device *);
>>   	void (*ref)(struct watchdog_device *);
>>   	void (*unref)(struct watchdog_device *);
>>   	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
>>
> 

