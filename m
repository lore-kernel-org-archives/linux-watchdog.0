Return-path: <mike.looijmans@topicproducts.com>
Subject: Re: [PATCH 5/7] watchdog: gpio_wdt: use core reboot notifier
To: Guenter Roeck <linux@roeck-us.net>, Damien Riegel
	<damien.riegel@savoirfairelinux.com>, <linux-watchdog@vger.kernel.org>
References: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447880542-19320-6-git-send-email-damien.riegel@savoirfairelinux.com>
 <564E930C.3000501@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, Vivien Didelot
	<vivien.didelot@savoirfairelinux.com>, <kernel@savoirfairelinux.com>
From: Mike Looijmans <mike.looijmans@topic.nl>
Message-ID: <564EC895.20902@topic.nl>
Date: Fri, 20 Nov 2015 08:15:33 +0100
MIME-Version: 1.0
In-Reply-To: <564E930C.3000501@roeck-us.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

=EF=BB=BFOn 20-11-15 04:27, Guenter Roeck wrote:
> On 11/18/2015 01:02 PM, Damien Riegel wrote:
>> Get rid of the custom reboot notifier block registration and use the one
>> provided by the watchdog core.
>>
>> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
>> Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
>> ---
>>   drivers/watchdog/gpio_wdt.c | 35 ++---------------------------------
>>   1 file changed, 2 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
>> index 1a3c6e8..035c238 100644
>> --- a/drivers/watchdog/gpio_wdt.c
>> +++ b/drivers/watchdog/gpio_wdt.c
>> @@ -12,10 +12,8 @@
>>   #include <linux/err.h>
>>   #include <linux/delay.h>
>>   #include <linux/module.h>
>> -#include <linux/notifier.h>
>>   #include <linux/of_gpio.h>
>>   #include <linux/platform_device.h>
>> -#include <linux/reboot.h>
>>   #include <linux/watchdog.h>
>>
>>   #define SOFT_TIMEOUT_MIN    1
>> @@ -36,7 +34,6 @@ struct gpio_wdt_priv {
>>       unsigned int        hw_algo;
>>       unsigned int        hw_margin;
>>       unsigned long        last_jiffies;
>> -    struct notifier_block    notifier;
>>       struct timer_list    timer;
>>       struct watchdog_device    wdd;
>>   };
>> @@ -126,26 +123,6 @@ static int gpio_wdt_set_timeout(struct watchdog_dev=
ice
>> *wdd, unsigned int t)
>>       return gpio_wdt_ping(wdd);
>>   }
>>
>> -static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long=
 code,
>> -                   void *unused)
>> -{
>> -    struct gpio_wdt_priv *priv =3D container_of(nb, struct gpio_wdt_pri=
v,
>> -                          notifier);
>> -
>> -    mod_timer(&priv->timer, 0);
>> -
>> -    switch (code) {
>> -    case SYS_HALT:
>> -    case SYS_DOWN:
>> -        gpio_wdt_disable(priv);
>> -        break;
>> -    default:
>> -        break;
>> -    }
>> -
> Slight difference in semantics here: The stop function only stops the wat=
chdog
> if the 'always_running' flag is not set. The notifier here always stops i=
t,
> or at least tries to stop it. Not really sure what that means, since the
> always_running flag is supposed to mean "the watchdog can not be stopped"=
.
>
> Copying Mike Looijmans, who added the always-running flag, for input.

Okay, I don't know quite what the "core" will do.

If the system wants to reboot, and the watchdog is in "always_running" mode=
,=20
it must NOT stop the watchdog. You have to keep kicking the dog until the=20
system reboots and the bootloader can take over. Otherwise, the watchdog ma=
y=20
turn off the mains power (I developed this for a medical device, which had =
to=20
completely shut down in case of trouble) or do something else that wasn't=20
supposed to happen yet.

When shutting down, the assumption is that either the power-down has alread=
y=20
occured before the watchdog might kick in, or that the watchdog will shut d=
own=20
the system because the kernel stopped kicking it. So no special case here, =
it=20
doesn't really matter whether you kick it once more or not.

If the external watchdog reboots the system rather than shuts down power, t=
he=20
above scenario won't hurt.

Hope this answers your question, if not, feel free to ask for more informat=
ion.


Mike.

>
> Thanks,
> Guenter
>
>> -    return NOTIFY_DONE;
>> -}
>> -
>>   static const struct watchdog_info gpio_wdt_ident =3D {
>>       .options    =3D WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING |
>>                 WDIOF_SETTIMEOUT,
>> @@ -224,23 +201,16 @@ static int gpio_wdt_probe(struct platform_device *=
pdev)
>>
>>       setup_timer(&priv->timer, gpio_wdt_hwping, (unsigned long)&priv->w=
dd);
>>
>> +    watchdog_stop_on_reboot(&priv->wdd);
>> +
>>       ret =3D watchdog_register_device(&priv->wdd);
>>       if (ret)
>>           return ret;
>>
>> -    priv->notifier.notifier_call =3D gpio_wdt_notify_sys;
>> -    ret =3D register_reboot_notifier(&priv->notifier);
>> -    if (ret)
>> -        goto error_unregister;
>> -
>>       if (priv->always_running)
>>           gpio_wdt_start_impl(priv);
>>
>>       return 0;
>> -
>> -error_unregister:
>> -    watchdog_unregister_device(&priv->wdd);
>> -    return ret;
>>   }
>>
>>   static int gpio_wdt_remove(struct platform_device *pdev)
>> @@ -248,7 +218,6 @@ static int gpio_wdt_remove(struct platform_device *p=
dev)
>>       struct gpio_wdt_priv *priv =3D platform_get_drvdata(pdev);
>>
>>       del_timer_sync(&priv->timer);
>> -    unregister_reboot_notifier(&priv->notifier);
>>       watchdog_unregister_device(&priv->wdd);
>>
>>       return 0;
>>
>



Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail

Visit us at : Aerospace Electrical Systems Expo Europe which will be held f=
rom 17.11.2015 till 19.11.2015, Findorffstrasse 101 Bremen, Germany, Hall 5=
, stand number C65
http://www.aesexpo.eu
