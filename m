Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36722 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbKXGg1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 01:36:27 -0500
Subject: Re: [PATCH 6/6] watchdog: pretimeout: add ping watchdog pretimeout
 governor
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1448089910-11453-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1448089910-11453-7-git-send-email-vladimir_zapolskiy@mentor.com>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56540567.1020803@roeck-us.net>
Date: Mon, 23 Nov 2015 22:36:23 -0800
MIME-Version: 1.0
In-Reply-To: <1448089910-11453-7-git-send-email-vladimir_zapolskiy@mentor.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/20/2015 11:11 PM, Vladimir Zapolskiy wrote:
> Ping watchdog pretimeout governor, on watchdog pretimeout event ping
> watchdog device. Use this watchdog pretimeout governor with caution,
> it may humiliate watchdog work, however it may be helpful in some
> particular situations, for instance if once started watchdog can not
> be stopped, but reboot caused by the watchdog is undesired.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>   drivers/watchdog/Kconfig           | 16 +++++++++++++
>   drivers/watchdog/Makefile          |  1 +
>   drivers/watchdog/pretimeout_ping.c | 48 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 65 insertions(+)
>   create mode 100644 drivers/watchdog/pretimeout_ping.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 6c1f7e1..cb0885a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1669,6 +1669,12 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_DEVICE
>   	  Use device specific watchdog pretimeout event handler
>   	  by default.
>
> +config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PING
> +	bool "ping"
> +	select WATCHDOG_PRETIMEOUT_GOV_PING
> +	help
> +	  Use ping watchdog pretimeout event handler by default.
> +
>   endchoice
>
>   config WATCHDOG_PRETIMEOUT_GOV_NOOP
> @@ -1698,6 +1704,16 @@ config WATCHDOG_PRETIMEOUT_GOV_DEVICE
>   	  does nothing, if watchdog driver does not define a pretimeout
>   	  callback.
>
> +config WATCHDOG_PRETIMEOUT_GOV_PING
> +	tristate "Ping watchdog pretimeout governor"
> +	help
> +	  Ping watchdog pretimeout governor, on watchdog pretimeout
> +	  event ping watchdog device. Use this watchdog pretimeout
> +	  governor with caution, it may humiliate watchdog work,
> +	  however it may be helpful in some particular situations,
> +	  for instance if once started watchdog can not be stopped,
> +	  but reboot caused by the watchdog is undesired.
> +

This one will be unnecessary once the pending infrastructure enhancements
are accepted. The watchdog core will then handle the ping.
I don't think this should be left to user space, as it _would_ defeat
the watchdog's purpose if the watchdog application fails to ping
the watchdog.

Thanks,
Guenter


>   endif # WATCHDOG_PRETIMEOUT_GOV
>
>   endif # WATCHDOG
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 0717b64..bbf6af8 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)	+= pretimeout_noop.o
>   obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)	+= pretimeout_panic.o
>   obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_USERSPACE)	+= pretimeout_userspace.o
>   obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_DEVICE)	+= pretimeout_device.o
> +obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PING)	+= pretimeout_ping.o
>
>   # Only one watchdog can succeed. We probe the ISA/PCI/USB based
>   # watchdog-cards first, then the architecture specific watchdog
> diff --git a/drivers/watchdog/pretimeout_ping.c b/drivers/watchdog/pretimeout_ping.c
> new file mode 100644
> index 0000000..0d55205
> --- /dev/null
> +++ b/drivers/watchdog/pretimeout_ping.c
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright (C) 2015 Mentor Graphics
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/watchdog.h>
> +
> +#include <watchdog_pretimeout.h>
> +
> +/**
> + * pretimeout_ping - Ping watchdog on pretimeout event
> + * @wdd - watchdog_device
> + *
> + */
> +static void pretimeout_ping(struct watchdog_device *wdd)
> +{
> +	wdd->ops->ping(wdd);
> +}
> +
> +static struct watchdog_governor watchdog_gov_ping = {
> +	.name		= "ping",
> +	.pretimeout	= pretimeout_ping,
> +#ifdef CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PING
> +	.is_default	= true,
> +#endif
> +};
> +
> +static int __init watchdog_gov_ping_register(void)
> +{
> +	return watchdog_register_governor(&watchdog_gov_ping);
> +}
> +
> +static void __exit watchdog_gov_ping_unregister(void)
> +{
> +	watchdog_unregister_governor(&watchdog_gov_ping);
> +}
> +module_init(watchdog_gov_ping_register);
> +module_exit(watchdog_gov_ping_unregister);
> +
> +MODULE_AUTHOR("Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>");
> +MODULE_DESCRIPTION("Ping watchdog pretimeout governor");
> +MODULE_LICENSE("GPL");
>

