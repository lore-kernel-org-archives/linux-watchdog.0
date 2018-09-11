Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44669 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeILCvL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 11 Sep 2018 22:51:11 -0400
Date: Tue, 11 Sep 2018 14:49:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jeremy Gebben <jgebben@sweptlaser.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: abx80x: add basic watchdog support
Message-ID: <20180911214951.GA23260@roeck-us.net>
References: <20180911172826.7195-1-jgebben@sweptlaser.com>
 <20180911172826.7195-3-jgebben@sweptlaser.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911172826.7195-3-jgebben@sweptlaser.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Sep 11, 2018 at 11:28:26AM -0600, Jeremy Gebben wrote:
> The abx804 and abx805 chips have support for a simple watchdog
> function that can trigger an external reset.
> 
> Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/rtc/Kconfig      |   1 +
>  drivers/rtc/rtc-abx80x.c | 116 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 113 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 7d7be60a2413..bcb0e9eda781 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -187,6 +187,7 @@ config RTC_DRV_ABB5ZES3
>  
>  config RTC_DRV_ABX80X
>  	tristate "Abracon ABx80x"
> +	select WATCHDOG_CORE if WATCHDOG
>  	help
>  	  If you say yes here you get support for Abracon AB080X and AB180X
>  	  families of ultra-low-power  battery- and capacitor-backed real-time
> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 9d49054a0a4a..d8e94edcb0ba 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -17,6 +17,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/rtc.h>
> +#include <linux/watchdog.h>
>  
>  #define ABX8XX_REG_HTH		0x00
>  #define ABX8XX_REG_SC		0x01
> @@ -37,6 +38,7 @@
>  
>  #define ABX8XX_REG_STATUS	0x0f
>  #define ABX8XX_STATUS_AF	BIT(2)
> +#define ABX8XX_STATUS_WDT	BIT(6)
>  
>  #define ABX8XX_REG_CTRL1	0x10
>  #define ABX8XX_CTRL_WRITE	BIT(0)
> @@ -61,6 +63,14 @@
>  #define ABX8XX_OSS_OF		BIT(1)
>  #define ABX8XX_OSS_OMODE	BIT(4)
>  
> +#define ABX8XX_REG_WDT		0x1b
> +#define ABX8XX_WDT_WDS		BIT(7)
> +#define ABX8XX_WDT_BMB_MASK	0x7c
> +#define ABX8XX_WDT_BMB_SHIFT	2
> +#define ABX8XX_WDT_MAX_TIME	(ABX8XX_WDT_BMB_MASK >> ABX8XX_WDT_BMB_SHIFT)
> +#define ABX8XX_WDT_WRB_MASK	0x03
> +#define ABX8XX_WDT_WRB_1HZ	0x02
> +
>  #define ABX8XX_REG_CFG_KEY	0x1f
>  #define ABX8XX_CFG_KEY_OSC	0xa1
>  #define ABX8XX_CFG_KEY_MISC	0x9d
> @@ -80,23 +90,25 @@ enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
>  struct abx80x_cap {
>  	u16 pn;
>  	bool has_tc;
> +	bool has_wdog;
>  };
>  
>  static struct abx80x_cap abx80x_caps[] = {
>  	[AB0801] = {.pn = 0x0801},
>  	[AB0803] = {.pn = 0x0803},
> -	[AB0804] = {.pn = 0x0804, .has_tc = true},
> -	[AB0805] = {.pn = 0x0805, .has_tc = true},
> +	[AB0804] = {.pn = 0x0804, .has_tc = true, .has_wdog = true},
> +	[AB0805] = {.pn = 0x0805, .has_tc = true, .has_wdog = true},
>  	[AB1801] = {.pn = 0x1801},
>  	[AB1803] = {.pn = 0x1803},
> -	[AB1804] = {.pn = 0x1804, .has_tc = true},
> -	[AB1805] = {.pn = 0x1805, .has_tc = true},
> +	[AB1804] = {.pn = 0x1804, .has_tc = true, .has_wdog = true},
> +	[AB1805] = {.pn = 0x1805, .has_tc = true, .has_wdog = true},
>  	[ABX80X] = {.pn = 0}
>  };
>  
>  struct abx80x_priv {
>  	struct rtc_device *rtc;
>  	struct i2c_client *client;
> +	struct watchdog_device wdog;
>  };
>  
>  static int abx80x_is_rc_mode(struct i2c_client *client)
> @@ -234,6 +246,13 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
>  	if (status & ABX8XX_STATUS_AF)
>  		rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
>  
> +	/*
> +	 * It is unclear if we'll get an interrupt before the external
> +	 * reset kicks in.
> +	 */
> +	if (status & ABX8XX_STATUS_WDT)
> +		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
> +
>  	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
>  
>  	return IRQ_HANDLED;
> @@ -535,6 +554,89 @@ static void rtc_calib_remove_sysfs_group(void *_dev)
>  	sysfs_remove_group(&dev->kobj, &rtc_calib_attr_group);
>  }
>  
> +#ifdef CONFIG_WATCHDOG
> +
> +static inline u8 timeout_bits(unsigned int timeout)
> +{
> +	return ((timeout << ABX8XX_WDT_BMB_SHIFT) & ABX8XX_WDT_BMB_MASK) |
> +		 ABX8XX_WDT_WRB_1HZ;
> +}
> +
> +static int __abx80x_wdog_set_timeout(struct watchdog_device *wdog,
> +				     unsigned int timeout)
> +{
> +	struct abx80x_priv *priv = watchdog_get_drvdata(wdog);
> +	u8 val = ABX8XX_WDT_WDS | timeout_bits(timeout);
> +
> +	/*
> +	 * Writing any timeout to the WDT register resets the watchdog timer.
> +	 * Writing 0 disables it.
> +	 */
> +	return i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_WDT, val);
> +}
> +
> +static int abx80x_wdog_set_timeout(struct watchdog_device *wdog,
> +				   unsigned int new_timeout)
> +{
> +	int err = 0;
> +
> +	if (watchdog_hw_running(wdog))
> +		err = __abx80x_wdog_set_timeout(wdog, new_timeout);
> +
> +	if (err == 0)
> +		wdog->timeout = new_timeout;
> +
> +	return err;
> +}
> +
> +static int abx80x_wdog_ping(struct watchdog_device *wdog)
> +{
> +	return __abx80x_wdog_set_timeout(wdog, wdog->timeout);
> +}
> +
> +static int abx80x_wdog_start(struct watchdog_device *wdog)
> +{
> +	return __abx80x_wdog_set_timeout(wdog, wdog->timeout);
> +}
> +
> +static int abx80x_wdog_stop(struct watchdog_device *wdog)
> +{
> +	return __abx80x_wdog_set_timeout(wdog, 0);
> +}
> +
> +static const struct watchdog_info abx80x_wdog_info = {
> +	.identity = "abx80x watchdog",
> +	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> +};
> +
> +static const struct watchdog_ops abx80x_wdog_ops = {
> +	.owner = THIS_MODULE,
> +	.start = abx80x_wdog_start,
> +	.stop = abx80x_wdog_stop,
> +	.ping = abx80x_wdog_ping,
> +	.set_timeout = abx80x_wdog_set_timeout,
> +};
> +
> +static int abx80x_setup_watchdog(struct abx80x_priv *priv)
> +{
> +	priv->wdog.parent = &priv->client->dev;
> +	priv->wdog.ops = &abx80x_wdog_ops;
> +	priv->wdog.info = &abx80x_wdog_info;
> +	priv->wdog.min_timeout = 1;
> +	priv->wdog.max_timeout = ABX8XX_WDT_MAX_TIME;
> +	priv->wdog.timeout = ABX8XX_WDT_MAX_TIME;
> +
> +	watchdog_set_drvdata(&priv->wdog, priv);
> +
> +	return devm_watchdog_register_device(&priv->client->dev, &priv->wdog);
> +}
> +#else
> +static int abx80x_setup_watchdog(struct abx80x_priv *priv)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int abx80x_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -629,6 +731,12 @@ static int abx80x_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, priv);
>  
> +	if (abx80x_caps[part].has_wdog) {
> +		err = abx80x_setup_watchdog(priv);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (client->irq > 0) {
>  		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
>  		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -- 
> 2.17.1
> 
