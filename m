Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60630 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760581AbbKTPfy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Nov 2015 10:35:54 -0500
Subject: Re: [PATCH 5/7] watchdog: gpio_wdt: use core reboot notifier
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com
References: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447880542-19320-6-git-send-email-damien.riegel@savoirfairelinux.com>
 <564E930C.3000501@roeck-us.net> <564EC895.20902@topic.nl>
 <20151120152109.GA6038@localhost>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564F3DD3.4080400@roeck-us.net>
Date: Fri, 20 Nov 2015 07:35:47 -0800
MIME-Version: 1.0
In-Reply-To: <20151120152109.GA6038@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/20/2015 07:21 AM, Damien Riegel wrote:
> On Fri, Nov 20, 2015 at 08:15:33AM +0100, Mike Looijmans wrote:
>> ﻿On 20-11-15 04:27, Guenter Roeck wrote:
>>> On 11/18/2015 01:02 PM, Damien Riegel wrote:
>>>> Get rid of the custom reboot notifier block registration and use the one
>>>> provided by the watchdog core.
>>>>
>>>> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
>>>> Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
>>>> ---
>>>>   drivers/watchdog/gpio_wdt.c | 35 ++---------------------------------
>>>>   1 file changed, 2 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
>>>> index 1a3c6e8..035c238 100644
>>>> --- a/drivers/watchdog/gpio_wdt.c
>>>> +++ b/drivers/watchdog/gpio_wdt.c
>>>> @@ -12,10 +12,8 @@
>>>>   #include <linux/err.h>
>>>>   #include <linux/delay.h>
>>>>   #include <linux/module.h>
>>>> -#include <linux/notifier.h>
>>>>   #include <linux/of_gpio.h>
>>>>   #include <linux/platform_device.h>
>>>> -#include <linux/reboot.h>
>>>>   #include <linux/watchdog.h>
>>>>
>>>>   #define SOFT_TIMEOUT_MIN    1
>>>> @@ -36,7 +34,6 @@ struct gpio_wdt_priv {
>>>>       unsigned int        hw_algo;
>>>>       unsigned int        hw_margin;
>>>>       unsigned long        last_jiffies;
>>>> -    struct notifier_block    notifier;
>>>>       struct timer_list    timer;
>>>>       struct watchdog_device    wdd;
>>>>   };
>>>> @@ -126,26 +123,6 @@ static int gpio_wdt_set_timeout(struct watchdog_device
>>>> *wdd, unsigned int t)
>>>>       return gpio_wdt_ping(wdd);
>>>>   }
>>>>
>>>> -static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
>>>> -                   void *unused)
>>>> -{
>>>> -    struct gpio_wdt_priv *priv = container_of(nb, struct gpio_wdt_priv,
>>>> -                          notifier);
>>>> -
>>>> -    mod_timer(&priv->timer, 0);
>>>> -
>>>> -    switch (code) {
>>>> -    case SYS_HALT:
>>>> -    case SYS_DOWN:
>>>> -        gpio_wdt_disable(priv);
>>>> -        break;
>>>> -    default:
>>>> -        break;
>>>> -    }
>>>> -
>>> Slight difference in semantics here: The stop function only stops the watchdog
>>> if the 'always_running' flag is not set. The notifier here always stops it,
>>> or at least tries to stop it. Not really sure what that means, since the
>>> always_running flag is supposed to mean "the watchdog can not be stopped".
>>>
>>> Copying Mike Looijmans, who added the always-running flag, for input.
>>
>> Okay, I don't know quite what the "core" will do.
>>
>> If the system wants to reboot, and the watchdog is in "always_running" mode,
>> it must NOT stop the watchdog. You have to keep kicking the dog until the
>> system reboots and the bootloader can take over. Otherwise, the watchdog may
>> turn off the mains power (I developed this for a medical device, which had
>> to completely shut down in case of trouble) or do something else that wasn't
>> supposed to happen yet.
>>
>> When shutting down, the assumption is that either the power-down has already
>> occured before the watchdog might kick in, or that the watchdog will shut
>> down the system because the kernel stopped kicking it. So no special case
>> here, it doesn't really matter whether you kick it once more or not.
>>
>> If the external watchdog reboots the system rather than shuts down power,
>> the above scenario won't hurt.
>>
>> Hope this answers your question, if not, feel free to ask for more information.
>>
>
> The core calls ops->stop on SYS_HALT and SYS_DOWN if the watchdog called
> watchdog_stop_on_reboot during initialization.
>
> In the previous patch of this serie, I change the condition on which
> gpio_wdt_disable is called in gpio_wdt_notify_sys, replacing
> SYS_POWER_OFF by SYS_DOWN. Regarding what you just said, not stopping on
> SYS_DOWN was a deliberate choice, so we should not modify this
> watchdog's behaviour.
>
Yes, or not stop it if it is configured for "always enabled", which this
patch does.

> But actually, I don't understand why the notifier is registered in the
> first place in that case.
>

Good question. Either case I think we are good, because the new behavior will
be to not stop the watchdog on shutdown if it is configured to "always enabled".

Thanks,
Guenter

