Return-path: <ukl@pengutronix.de>
Date: Tue, 10 Nov 2015 08:20:31 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: gpio-wdt: Add panic notifier
Message-ID: <20151110072031.GH4931@pengutronix.de>
References: <1447062944-12296-1-git-send-email-alexander.stein@systec-electronic.com>
 <1447062944-12296-2-git-send-email-alexander.stein@systec-electronic.com>
 <5640B96D.6010408@roeck-us.net>
 <20151109190249.GG4931@pengutronix.de>
 <56412A14.60800@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56412A14.60800@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

On Mon, Nov 09, 2015 at 03:19:48PM -0800, Guenter Roeck wrote:
> On 11/09/2015 11:02 AM, Uwe Kleine-König wrote:
> >On Mon, Nov 09, 2015 at 07:19:09AM -0800, Guenter Roeck wrote:
> >>On 11/09/2015 01:55 AM, Alexander Stein wrote:
> >>>This notifier is required when the watchdog is configured as always running
> >>>because in this case the watchdog will be triggered when the kernel panics
> >>>at boot before any application could open the device, e.g. because the
> >>>rootfs is broken. This should result in a resetting system. Thus we
> >>>register a panic notifier which stops triggering the watchdog.
> >>>
> >>
> >>Shouldn't the timer be stopped instead ?
> >
> >What do you mean saying "timer"? The hardware? This might or might not
> >be possible.
> >
> I meant the timer referenced with the variable 'timer' in struct
> gpio_wdt_priv, and "stop timer' would translate to somoething like
> 'mod_timer(&priv->timer, 0);'.
> Sorry for not being more specific.

My feeling is that improving the gpio-wdt driver is the wrong way. I
admit I lost track of the patch series that moves that handling into the
watchdog core, what is the status here? There thinking more accurately
which handlers to register and how to react to certain events makes
more sense.

Adding code now to gpio-wdt that later needs migration to the core stuff
might be more annoying than to do it right in the core now.

> >>>diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> >>>index c7b8a06..aaa0815 100644
> >>>--- a/drivers/watchdog/gpio_wdt.c
> >>>+++ b/drivers/watchdog/gpio_wdt.c
> >>>@@ -233,11 +245,19 @@ static int gpio_wdt_probe(struct platform_device *pdev)
> >>>  	if (ret)
> >>>  		goto error_unregister;
> >>>
> >>>+	priv->panic_notifier.notifier_call = gpio_wdt_notify_panic;
> >>>+	ret = atomic_notifier_chain_register(&panic_notifier_list,
> >>>+					     &priv->panic_notifier);
> >>>+	if (ret)
> >>>+		goto error_unregister_notify;
> >>>+
> >>>  	if (priv->always_running)
> >>>  		gpio_wdt_start_impl(priv);
> >>>
> >>>  	return 0;
> >>>
> >>>+error_unregister_notify:
> >>>+	unregister_reboot_notifier(&priv->reboot_notifier);
> >
> >The logic is wrong here. If atomic_notifier_chain_register failed you
> >shouldn't call unregister_reboot_notifier.

I meant the wrong thing here, I thought the call to
atomic_notifier_chain_register is undone when it fails, but the patch
presented by Alexander is right. 

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
