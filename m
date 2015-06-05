Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45426 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbbFEIJZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Jun 2015 04:09:25 -0400
Message-ID: <55715930.1040500@roeck-us.net>
Date: Fri, 05 Jun 2015 01:09:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] gpio_wdt: change initcall level
References: <1433445690-22560-1-git-send-email-jtheou@adeneo-embedded.us>	<5571276F.5080405@roeck-us.net> <20150604230544.f1b73361d284da4d1d66d93d@adeneo-embedded.us>
In-Reply-To: <20150604230544.f1b73361d284da4d1d66d93d@adeneo-embedded.us>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/04/2015 11:05 PM, Jean-Baptiste Theou wrote:
> Hi Guenter,
>
> I based my work on the work done in mpc8xxx_wdt.c, which is in mainline.
>
Yes, you mentioned that before. However, that is a driver for a specific
chip, not a generic driver like this one. That driver is only messy for
one chip. Your driver. on the other side, changes the logic of a generic
driver, and I am not even sure if it would work as implemented. One key
logical change is that if the driver is built into the kernel, it will
not report an error if watchdog_register_device fails. That may be
acceptable for a dedicated driver, but I don't think it is acceptable
to impose this onto a generic driver. Also, I suspect that if it ever
happens that there is more than one such watchdog in the system, and
the driver is built as module, it would fail all over the place and try
to register each driver instance multiple times.

Plus, you call both gpio_wdt_init_late and gpio_wdt_remove_late before
the functions are declared, and I don't see any forward declarations.
That suggests that you will see at least warnings if not errors
if you compile the driver as module, which in turn doesn't make me feel
very comfortable about the level of compile testing you have done,
much less runtime testing.

A more generic solution might be to improve watchdog_register_device
and let it handle the situation where a driver registers early
(for example by queuing the request to register the misc device
if that is the problem).

Guenter

> The point of my patch is for a built-in scenario.
> I have an external chip who controls the watchdog, and it need to have
> it IN pin toggle within 1.6s, otherwise it trigger the watchdog.
>
> With a default gpio_wdt built-in module, module_init initcall level is
> too late, and the board reboot (the watchdog cannot be disabled, I am
> using "always-running" property of this module.)
>
> The point of my patch is to start the watchdog at arch_init call level,
> and the "tweak" for late init is due to the fact that miscdev is not
> ready at the level of initcall, as explained on the comment.
>
> If there is some part that aren't clear and if you have a better idea
> on how to raise the level of initcall for this module, on a cleaner
> way, I am all hears.
>
> Best regards,
>
> On Thu, 4 Jun 2015 21:37:03 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
>
>> On 06/04/2015 12:21 PM, Jean-Baptiste Theou wrote:
>>> gpio_wdt may need to start the GPIO toggle as soon as possible,
>>> when the watchdog cannot be disabled. Raise the initcall to
>>> arch_initcall.
>>>
>>> We need to split the initiation, because of miscdev, as done in
>>> mpc8xxx_wdt.c
>>>
>>> Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
>>> ---
>>>    drivers/watchdog/gpio_wdt.c | 78 ++++++++++++++++++++++++++++++++++++++++++---
>>>    1 file changed, 74 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
>>> index cbc313d..8ecfe7e 100644
>>> --- a/drivers/watchdog/gpio_wdt.c
>>> +++ b/drivers/watchdog/gpio_wdt.c
>>> @@ -14,6 +14,7 @@
>>>    #include <linux/module.h>
>>>    #include <linux/notifier.h>
>>>    #include <linux/of_gpio.h>
>>> +#include <linux/of_platform.h>
>>>    #include <linux/platform_device.h>
>>>    #include <linux/reboot.h>
>>>    #include <linux/watchdog.h>
>>> @@ -223,10 +224,11 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>>>
>>>    	setup_timer(&priv->timer, gpio_wdt_hwping, (unsigned long)&priv->wdd);
>>>
>>> -	ret = watchdog_register_device(&priv->wdd);
>>> +#ifdef MODULE
>>> +	ret = gpio_wdt_init_late();
>>>    	if (ret)
>>>    		return ret;
>>> -
>>> +#endif
>>>    	priv->notifier.notifier_call = gpio_wdt_notify_sys;
>>>    	ret = register_reboot_notifier(&priv->notifier);
>>>    	if (ret)
>>> @@ -235,10 +237,13 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>>>    	if (priv->always_running)
>>>    		gpio_wdt_start_impl(priv);
>>>
>>> +	platform_set_drvdata(pdev, priv);
>>>    	return 0;
>>>
>>>    error_unregister:
>>> -	watchdog_unregister_device(&priv->wdd);
>>> +#ifdef MODULE
>>> +	ret = gpio_wdt_remove_late(&priv->wdd);
>>> +#endif
>>>    	return ret;
>>>    }
>>>
>>> @@ -267,7 +272,72 @@ static struct platform_driver gpio_wdt_driver = {
>>>    	.probe	= gpio_wdt_probe,
>>>    	.remove	= gpio_wdt_remove,
>>>    };
>>> -module_platform_driver(gpio_wdt_driver);
>>> +
>>> +/*
>>> + * We do wdt initialization in two steps: arch_initcall probes the wdt
>>> + * very early to start pinging the watchdog (misc devices are not yet
>>> + * available), and later module_init() just registers the misc device.
>>> + */
>>> +static int gpio_wdt_init_late(void)
>>> +{
>>> +	struct platform_device *pdev;
>>> +	struct device_node *wdt_node;
>>> +	struct gpio_wdt_priv *priv;
>>> +	int ret;
>>> +
>>> +	for_each_compatible_node(wdt_node, NULL, "linux,wdt-gpio") {
>>> +		pdev = of_find_device_by_node(wdt_node);
>>> +		priv = platform_get_drvdata(pdev);
>>> +		if (&priv->wdd) {
>>> +			ret = watchdog_register_device(&priv->wdd);
>>> +			if (ret)
>>> +				return ret;
>>> +		} else {
>>> +			dev_err(&pdev->dev, "Unable to register the watchdog\n");
>>> +			return -1;
>>> +		}
>>> +	}
>>> +	return 0;
>>> +}
>>> +#ifndef MODULE
>>> +module_init(gpio_wdt_init_late);
>>> +#endif
>>> +
>>> +#ifdef MODULE
>>> +int gpio_wdt_remove_late(void)
>>> +{
>>> +	struct platform_device *pdev;
>>> +	struct device_node *wdt_node;
>>> +	struct gpio_wdt_priv *priv;
>>> +	int ret;
>>> +
>>> +	for_each_compatible_node(wdt_node, NULL, "linux,wdt-gpio") {
>>> +		pdev = of_find_device_by_node(wdt_node);
>>> +		priv = platform_get_drvdata(pdev);
>>> +		if (&priv->wdd) {
>>> +			ret = watchdog_unregister_device(&priv->wdd);
>>> +			if (ret)
>>> +				return ret;
>>> +		} else {
>>> +			dev_err(&pdev->dev, "Unable to register the watchdog\n");
>>> +			return -1;
>>> +		}
>>> +	}
>>> +	return 0;
>>> +}
>>> +#endif
>>> +
>>> +static int __init gpio_wdt_init(void)
>>> +{
>>> +	return platform_driver_register(&gpio_wdt_driver);
>>> +}
>>> +arch_initcall(gpio_wdt_init);
>>> +
>>> +static void __exit gpio_wdt_exit(void)
>>> +{
>>> +	platform_driver_unregister(&gpio_wdt_driver);
>>> +}
>>> +module_exit(gpio_wdt_exit);
>>>
>>>    MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
>>>    MODULE_DESCRIPTION("GPIO Watchdog");
>>>
>>
>> This looks really messy, you don't explain why you think you need
>> gpio_wdt_remove_late, and I do wonder if there are compile warnings
>> when this is compiled as module.
>>
>> If, in a given system, initialization can not wait until modules are loaded,
>> maybe it makes more sense to build the driver into the kernel instead of
>> introducing all this mess. If built into the kernel the latency should
>> not be that bad that this is really needed.
>>
>> Guenter
>>
>
>

