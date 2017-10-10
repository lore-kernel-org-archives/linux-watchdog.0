Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34203 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756138AbdJJNlS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Oct 2017 09:41:18 -0400
Subject: Re: [PATCH] rtc: ds1374: wdt:support suspend/resume for watchdog
To: "winton.liu" <18502523564@163.com>, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <1507641172-6099-1-git-send-email-18502523564@163.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8b80788f-5906-38a5-4b40-0a78f0ab55d9@roeck-us.net>
Date: Tue, 10 Oct 2017 06:41:15 -0700
MIME-Version: 1.0
In-Reply-To: <1507641172-6099-1-git-send-email-18502523564@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/10/2017 06:12 AM, winton.liu wrote:
> When enable CONFIG_RTC_DRV_DS1374_WDT use as watchdog,
> in suspend mode, watchdog is still working but no daemon
> patting the watchdog. The system will reboot if timeout.
> 
> Add support suspend/resume for watchdog.
> suspend: disable the watchdog
> resume: disable existing watchdog, reload watchdog timer, enable watchdog
> 
> Signed-off-by: winton.liu <18502523564@163.com>
> ---
>   drivers/rtc/rtc-ds1374.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> index 38a2e9e..642e31d 100644
> --- a/drivers/rtc/rtc-ds1374.c
> +++ b/drivers/rtc/rtc-ds1374.c
> @@ -437,6 +437,29 @@ static void ds1374_wdt_ping(void)
>   		pr_info("WD TICK FAIL!!!!!!!!!! %i\n", ret);
>   }
>   
> +static void ds1374_wdt_resume(void)
> +{
> +	int ret = -ENOIOCTLCMD;

Useless initialization (yes, I can see that this is widely done in the driver,
but that doesn't make it better).

> +	int cr;
> +
> +	cr = i2c_smbus_read_byte_data(save_client, DS1374_REG_CR);
> +
> +	/* Disable any existing watchdog/alarm before setting the new one */
> +	cr &= ~DS1374_REG_CR_WACE;
> +
> +	i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
> +
> +	/* Reload watchdog timer */
> +	ds1374_wdt_ping();
> +
> +	/* Enable watchdog timer */
> +	cr |= DS1374_REG_CR_WACE | DS1374_REG_CR_WDALM;
> +	cr &= ~DS1374_REG_CR_AIE;
> +
> +	ret = i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
> +
Extra empty line. Also, returns void, so what is the point of assigning
the result to ret ?

> +}

Unless I am missing something, this unconditionally starts the watchdog
at resume time. So if it was not running before, it will be started anyway,
and the system will reboot since there will be no ping.

I assume it is guaranteed that the chip doesn't forget the previously
configured timeout on resume.

Overall the driver would really benefit from a conversion to the watchdog
subsystem.

> +
>   static void ds1374_wdt_disable(void)
>   {
>   	int ret = -ENOIOCTLCMD;
> @@ -690,6 +713,10 @@ static int ds1374_suspend(struct device *dev)
>   {
>   	struct i2c_client *client = to_i2c_client(dev);
>   
> +#ifdef CONFIG_RTC_DRV_DS1374_WDT
> +	ds1374_wdt_disable();
> +#endif
> +
>   	if (client->irq > 0 && device_may_wakeup(&client->dev))
>   		enable_irq_wake(client->irq);
>   	return 0;
> @@ -699,6 +726,10 @@ static int ds1374_resume(struct device *dev)
>   {
>   	struct i2c_client *client = to_i2c_client(dev);
>   
> +#ifdef CONFIG_RTC_DRV_DS1374_WDT
> +	ds1374_wdt_resume();
> +#endif
> +
>   	if (client->irq > 0 && device_may_wakeup(&client->dev))
>   		disable_irq_wake(client->irq);
>   	return 0;
> 

