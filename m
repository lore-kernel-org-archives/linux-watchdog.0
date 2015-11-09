Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35571 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbbKIXTu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Nov 2015 18:19:50 -0500
Subject: Re: [PATCH 2/2] watchdog: gpio-wdt: Add panic notifier
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <1447062944-12296-1-git-send-email-alexander.stein@systec-electronic.com>
 <1447062944-12296-2-git-send-email-alexander.stein@systec-electronic.com>
 <5640B96D.6010408@roeck-us.net> <20151109190249.GG4931@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56412A14.60800@roeck-us.net>
Date: Mon, 9 Nov 2015 15:19:48 -0800
MIME-Version: 1.0
In-Reply-To: <20151109190249.GG4931@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 11/09/2015 11:02 AM, Uwe Kleine-König wrote:
> Hello,
>
> On Mon, Nov 09, 2015 at 07:19:09AM -0800, Guenter Roeck wrote:
>> On 11/09/2015 01:55 AM, Alexander Stein wrote:
>>> This notifier is required when the watchdog is configured as always running
>>> because in this case the watchdog will be triggered when the kernel panics
>>> at boot before any application could open the device, e.g. because the
>>> rootfs is broken. This should result in a resetting system. Thus we
>>> register a panic notifier which stops triggering the watchdog.
>>>
>>
>> Shouldn't the timer be stopped instead ?
>
> What do you mean saying "timer"? The hardware? This might or might not
> be possible.
>
I meant the timer referenced with the variable 'timer' in struct gpio_wdt_priv,
and "stop timer' would translate to somoething like 'mod_timer(&priv->timer, 0);'.
Sorry for not being more specific.

> I think this depends on policy what you want. There are people that just
> want to calm the watchdog such that it doesn't interfere with the
> system. For these it might be right to stop the timer. If however the
> watchdog is responsible to bring a non-responding system back into
> operation it sounds right to stop petting the watchdog and let it reset
> the machine. (There are a few things that might complicate the logic,
> i.e. with panic=5 on the kernel command line it might make sense to keep
> the timer until the 5 seconds after panic are over.)
>
For my part I don't really want or suggest anything. I copied you on the patch
since you were involved in improving the driver, and I thought you might have
valuable input.

Having said that, I agree - since this is dealing with a panic, it may well
be that manipulating it may not be possible. So maybe it is best left alone
at this point.

Overall this might be a generic problem, not specifically related to the gpio
watchdog - what should be done with a watchdog if the system panics ?
Should the watchdog be disabled, or should it time out and force-reboot the
system ?

Up to now, the watchdog is left running, and will cause a hard reset after
it times out. This will be the first exception to this rule. As a result,
if the soft reboot caused by the panic() fails to reboot the system, the
system may be left in an unusable state. Is this ok / acceptable ?

>>> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
>>> index c7b8a06..aaa0815 100644
>>> --- a/drivers/watchdog/gpio_wdt.c
>>> +++ b/drivers/watchdog/gpio_wdt.c
>>> @@ -233,11 +245,19 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>>>   	if (ret)
>>>   		goto error_unregister;
>>>
>>> +	priv->panic_notifier.notifier_call = gpio_wdt_notify_panic;
>>> +	ret = atomic_notifier_chain_register(&panic_notifier_list,
>>> +					     &priv->panic_notifier);
>>> +	if (ret)
>>> +		goto error_unregister_notify;
>>> +
>>>   	if (priv->always_running)
>>>   		gpio_wdt_start_impl(priv);
>>>
>>>   	return 0;
>>>
>>> +error_unregister_notify:
>>> +	unregister_reboot_notifier(&priv->reboot_notifier);
>
> The logic is wrong here. If atomic_notifier_chain_register failed you
> shouldn't call unregister_reboot_notifier.
>

I tend to agree - all but to calls to register a panic notifier don't
check the return value from atomic_notifier_chain_register().

Thanks,
Guenter

