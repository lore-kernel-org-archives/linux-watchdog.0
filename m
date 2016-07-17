Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43702 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751174AbcGQTmJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 15:42:09 -0400
Date: Sun, 17 Jul 2016 21:42:06 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] watchdog: Add a device managed API for watchdog_register_device()
Message-ID: <20160717194206.GA32613@spo001.leaseweb.nl>
References: <1464363234-9777-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464363234-9777-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Neil,

> This helps in reducing code in .remove callbacks and sometimes
> dropping .remove callbacks entirely.
> 
> Changes since v1 at http://lkml.kernel.org/r/1464251510-15554-1-git-send-email-narmstrong@baylibre.com :
> - Fix brackets in devm_watchdog_register_device()
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/driver-model/devres.txt |  3 +++
>  drivers/watchdog/watchdog_core.c      | 37 +++++++++++++++++++++++++++++++++++
>  include/linux/watchdog.h              |  3 +++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index c63eea0..589296b 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -357,3 +357,6 @@ SLAVE DMA ENGINE
>  
>  SPI
>    devm_spi_register_master()
> +
> +WATCHDOG
> +  devm_watchdog_register_device()
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 981a668..7c5e3dc 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -329,6 +329,43 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
>  
>  EXPORT_SYMBOL_GPL(watchdog_unregister_device);
>  
> +static void devm_watchdog_unregister_device(struct device *dev, void *res)
> +{
> +	watchdog_unregister_device(*(struct watchdog_device **)res);
> +}
> +
> +/**
> + * devm_watchdog_register_device() - resource managed watchdog_register_device()
> + * @dev: device that is registering this watchdog device
> + * @wdd: watchdog device
> + *
> + * Managed watchdog_register_device(). For watchdog device registered by this
> + * function,  watchdog_unregister_device() is automatically called on driver
> + * detach. See watchdog_register_device() for more information.
> + */
> +int devm_watchdog_register_device(struct device *dev,
> +				struct watchdog_device *wdd)
> +{
> +	struct watchdog_device **rcwdd;
> +	int ret;
> +
> +	rcwdd = devres_alloc(devm_watchdog_unregister_device, sizeof(*wdd),
> +			     GFP_KERNEL);
> +	if (!rcwdd)
> +		return -ENOMEM;
> +
> +	ret = watchdog_register_device(wdd);
> +	if (!ret) {
> +		*rcwdd = wdd;
> +		devres_add(dev, rcwdd);
> +	} else {
> +		devres_free(rcwdd);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_watchdog_register_device);
> +
>  static int __init watchdog_deferred_registration(void)
>  {
>  	mutex_lock(&wtd_deferred_reg_mutex);
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 51732d6c..6b75e38 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -180,4 +180,7 @@ extern int watchdog_init_timeout(struct watchdog_device *wdd,
>  extern int watchdog_register_device(struct watchdog_device *);
>  extern void watchdog_unregister_device(struct watchdog_device *);
>  
> +/* devres register variant */
> +int devm_watchdog_register_device(struct device *dev, struct watchdog_device *);
> +
>  #endif  /* ifndef _LINUX_WATCHDOG_H */
> -- 
> 2.7.0
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

