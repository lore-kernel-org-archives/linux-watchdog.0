Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48317 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161580AbdAEOZz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 5 Jan 2017 09:25:55 -0500
Subject: Re: [PATCH 4/4] watchdog: tangox: Use watchdog core to install
 restart handler
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Mans Rullgard <mans@mansr.com>
References: <1483565318-25578-1-git-send-email-linux@roeck-us.net>
 <1483565318-25578-4-git-send-email-linux@roeck-us.net>
 <df7b5570-a44d-0c25-fedd-03a0891fdff3@sigmadesigns.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a4200f4e-53b5-55de-1cd9-b5ae5f5f9468@roeck-us.net>
Date: Thu, 5 Jan 2017 06:25:50 -0800
MIME-Version: 1.0
In-Reply-To: <df7b5570-a44d-0c25-fedd-03a0891fdff3@sigmadesigns.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/05/2017 01:42 AM, Marc Gonzalez wrote:
> [ Adding Mans ]
>
> Guenter, patch c7ef68c32265 states "Fixes: a3e376d26ace".
> Is that true? I mean, they seem quite orthogonal; then again I know
> nothing of this framework.
>
max_hw_heartbeat_ms must be set for WDOG_HW_RUNNING to work.

Guenter

> Regards.
>
> On 04/01/2017 22:28, Guenter Roeck wrote:
>> Use the infrastructure provided by the watchdog core to install
>> the restart handler.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  drivers/watchdog/tangox_wdt.c | 32 +++++++++++---------------------
>>  1 file changed, 11 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
>> index 202c4b9cc921..49e6e805db7c 100644
>> --- a/drivers/watchdog/tangox_wdt.c
>> +++ b/drivers/watchdog/tangox_wdt.c
>> @@ -15,9 +15,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/moduleparam.h>
>> -#include <linux/notifier.h>
>>  #include <linux/platform_device.h>
>> -#include <linux/reboot.h>
>>  #include <linux/watchdog.h>
>>
>>  #define DEFAULT_TIMEOUT 30
>> @@ -47,7 +45,6 @@ struct tangox_wdt_device {
>>  	void __iomem *base;
>>  	unsigned long clk_rate;
>>  	struct clk *clk;
>> -	struct notifier_block restart;
>>  };
>>
>>  static int tangox_wdt_set_timeout(struct watchdog_device *wdt,
>> @@ -96,24 +93,24 @@ static const struct watchdog_info tangox_wdt_info = {
>>  	.identity = "tangox watchdog",
>>  };
>>
>> +static int tangox_wdt_restart(struct watchdog_device *wdt,
>> +			      unsigned long action, void *data)
>> +{
>> +	struct tangox_wdt_device *dev = watchdog_get_drvdata(wdt);
>> +
>> +	writel(1, dev->base + WD_COUNTER);
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct watchdog_ops tangox_wdt_ops = {
>>  	.start		= tangox_wdt_start,
>>  	.stop		= tangox_wdt_stop,
>>  	.set_timeout	= tangox_wdt_set_timeout,
>>  	.get_timeleft	= tangox_wdt_get_timeleft,
>> +	.restart	= tangox_wdt_restart,
>>  };
>>
>> -static int tangox_wdt_restart(struct notifier_block *nb, unsigned long action,
>> -			      void *data)
>> -{
>> -	struct tangox_wdt_device *dev =
>> -		container_of(nb, struct tangox_wdt_device, restart);
>> -
>> -	writel(1, dev->base + WD_COUNTER);
>> -
>> -	return NOTIFY_DONE;
>> -}
>> -
>>  static int tangox_wdt_probe(struct platform_device *pdev)
>>  {
>>  	struct tangox_wdt_device *dev;
>> @@ -180,12 +177,6 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>>
>>  	platform_set_drvdata(pdev, dev);
>>
>> -	dev->restart.notifier_call = tangox_wdt_restart;
>> -	dev->restart.priority = 128;
>> -	err = register_restart_handler(&dev->restart);
>> -	if (err)
>> -		dev_warn(&pdev->dev, "failed to register restart handler\n");
>> -
>>  	dev_info(&pdev->dev, "SMP86xx/SMP87xx watchdog registered\n");
>>
>>  	return 0;
>> @@ -202,7 +193,6 @@ static int tangox_wdt_remove(struct platform_device *pdev)
>>  	tangox_wdt_stop(&dev->wdt);
>>  	clk_disable_unprepare(dev->clk);
>>
>> -	unregister_restart_handler(&dev->restart);
>>  	watchdog_unregister_device(&dev->wdt);
>>
>>  	return 0;
>>
>

