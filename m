Return-path: <damien.riegel@savoirfairelinux.com>
Date: Fri, 20 Nov 2015 10:21:11 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH 5/7] watchdog: gpio_wdt: use core reboot notifier
Message-ID: <20151120152109.GA6038@localhost>
References: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447880542-19320-6-git-send-email-damien.riegel@savoirfairelinux.com>
 <564E930C.3000501@roeck-us.net>
 <564EC895.20902@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <564EC895.20902@topic.nl>
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, Nov 20, 2015 at 08:15:33AM +0100, Mike Looijmans wrote:
> =EF=BB=BFOn 20-11-15 04:27, Guenter Roeck wrote:
> >On 11/18/2015 01:02 PM, Damien Riegel wrote:
> >>Get rid of the custom reboot notifier block registration and use the =
one
> >>provided by the watchdog core.
> >>
> >>Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> >>Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
> >>---
> >>  drivers/watchdog/gpio_wdt.c | 35 ++--------------------------------=
-
> >>  1 file changed, 2 insertions(+), 33 deletions(-)
> >>
> >>diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.=
c
> >>index 1a3c6e8..035c238 100644
> >>--- a/drivers/watchdog/gpio_wdt.c
> >>+++ b/drivers/watchdog/gpio_wdt.c
> >>@@ -12,10 +12,8 @@
> >>  #include <linux/err.h>
> >>  #include <linux/delay.h>
> >>  #include <linux/module.h>
> >>-#include <linux/notifier.h>
> >>  #include <linux/of_gpio.h>
> >>  #include <linux/platform_device.h>
> >>-#include <linux/reboot.h>
> >>  #include <linux/watchdog.h>
> >>
> >>  #define SOFT_TIMEOUT_MIN    1
> >>@@ -36,7 +34,6 @@ struct gpio_wdt_priv {
> >>      unsigned int        hw_algo;
> >>      unsigned int        hw_margin;
> >>      unsigned long        last_jiffies;
> >>-    struct notifier_block    notifier;
> >>      struct timer_list    timer;
> >>      struct watchdog_device    wdd;
> >>  };
> >>@@ -126,26 +123,6 @@ static int gpio_wdt_set_timeout(struct watchdog_=
device
> >>*wdd, unsigned int t)
> >>      return gpio_wdt_ping(wdd);
> >>  }
> >>
> >>-static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned l=
ong code,
> >>-                   void *unused)
> >>-{
> >>-    struct gpio_wdt_priv *priv =3D container_of(nb, struct gpio_wdt_=
priv,
> >>-                          notifier);
> >>-
> >>-    mod_timer(&priv->timer, 0);
> >>-
> >>-    switch (code) {
> >>-    case SYS_HALT:
> >>-    case SYS_DOWN:
> >>-        gpio_wdt_disable(priv);
> >>-        break;
> >>-    default:
> >>-        break;
> >>-    }
> >>-
> >Slight difference in semantics here: The stop function only stops the =
watchdog
> >if the 'always_running' flag is not set. The notifier here always stop=
s it,
> >or at least tries to stop it. Not really sure what that means, since t=
he
> >always_running flag is supposed to mean "the watchdog can not be stopp=
ed".
> >
> >Copying Mike Looijmans, who added the always-running flag, for input.
>=20
> Okay, I don't know quite what the "core" will do.
>=20
> If the system wants to reboot, and the watchdog is in "always_running" =
mode,
> it must NOT stop the watchdog. You have to keep kicking the dog until t=
he
> system reboots and the bootloader can take over. Otherwise, the watchdo=
g may
> turn off the mains power (I developed this for a medical device, which =
had
> to completely shut down in case of trouble) or do something else that w=
asn't
> supposed to happen yet.
>=20
> When shutting down, the assumption is that either the power-down has al=
ready
> occured before the watchdog might kick in, or that the watchdog will sh=
ut
> down the system because the kernel stopped kicking it. So no special ca=
se
> here, it doesn't really matter whether you kick it once more or not.
>=20
> If the external watchdog reboots the system rather than shuts down powe=
r,
> the above scenario won't hurt.
>=20
> Hope this answers your question, if not, feel free to ask for more info=
rmation.
>=20

The core calls ops->stop on SYS_HALT and SYS_DOWN if the watchdog called
watchdog_stop_on_reboot during initialization.

In the previous patch of this serie, I change the condition on which
gpio_wdt_disable is called in gpio_wdt_notify_sys, replacing
SYS_POWER_OFF by SYS_DOWN. Regarding what you just said, not stopping on
SYS_DOWN was a deliberate choice, so we should not modify this
watchdog's behaviour.

But actually, I don't understand why the notifier is registered in the
first place in that case.


Damien

>=20
> Mike.
>=20
> >
> >Thanks,
> >Guenter
> >
> >>-    return NOTIFY_DONE;
> >>-}
> >>-
> >>  static const struct watchdog_info gpio_wdt_ident =3D {
> >>      .options    =3D WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING |
> >>                WDIOF_SETTIMEOUT,
> >>@@ -224,23 +201,16 @@ static int gpio_wdt_probe(struct platform_devic=
e *pdev)
> >>
> >>      setup_timer(&priv->timer, gpio_wdt_hwping, (unsigned long)&priv=
->wdd);
> >>
> >>+    watchdog_stop_on_reboot(&priv->wdd);
> >>+
> >>      ret =3D watchdog_register_device(&priv->wdd);
> >>      if (ret)
> >>          return ret;
> >>
> >>-    priv->notifier.notifier_call =3D gpio_wdt_notify_sys;
> >>-    ret =3D register_reboot_notifier(&priv->notifier);
> >>-    if (ret)
> >>-        goto error_unregister;
> >>-
> >>      if (priv->always_running)
> >>          gpio_wdt_start_impl(priv);
> >>
> >>      return 0;
> >>-
> >>-error_unregister:
> >>-    watchdog_unregister_device(&priv->wdd);
> >>-    return ret;
> >>  }
> >>
> >>  static int gpio_wdt_remove(struct platform_device *pdev)
> >>@@ -248,7 +218,6 @@ static int gpio_wdt_remove(struct platform_device=
 *pdev)
> >>      struct gpio_wdt_priv *priv =3D platform_get_drvdata(pdev);
> >>
> >>      del_timer_sync(&priv->timer);
> >>-    unregister_reboot_notifier(&priv->notifier);
> >>      watchdog_unregister_device(&priv->wdd);
> >>
> >>      return 0;
> >>
> >
>=20
>=20
>=20
> Kind regards,
>=20
> Mike Looijmans
> System Expert
>=20
> TOPIC Embedded Products
> Eindhovenseweg 32-C, NL-5683 KH Best
> Postbus 440, NL-5680 AK Best
> Telefoon: +31 (0) 499 33 69 79
> Telefax: +31 (0) 499 33 69 70
> E-mail: mike.looijmans@topicproducts.com
> Website: www.topicproducts.com
>=20
> Please consider the environment before printing this e-mail
>=20
> Visit us at : Aerospace Electrical Systems Expo Europe which will be he=
ld from 17.11.2015 till 19.11.2015, Findorffstrasse 101 Bremen, Germany, =
Hall 5, stand number C65
> http://www.aesexpo.eu
>=20
>=20
