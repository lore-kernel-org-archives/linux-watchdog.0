Return-path: <poeschel@lemonage.de>
From: Lars Poeschel <poeschel@lemonage.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@iguana.be, corbet@lwn.net, linux-doc@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: omap_wdt: start_enabled module parameter
Date: Mon, 22 Jun 2015 10:39:29 +0200
Message-ID: <1764871.JhIE4j6ScF@i7>
In-Reply-To: <5584C594.70300@roeck-us.net>
References: <1434719880-12393-1-git-send-email-poeschel@lemonage.de> <5584C594.70300@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

Am Freitag 19 Juni 2015, 18:44:52 schrieb Guenter Roeck:
> On 06/19/2015 06:18 AM, poeschel@lemonage.de wrote:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > 
> > Add a start_enabled module parameter to the omap_wdt that starts the
> > watchdog on module insertion. The default value is 0 which does not
> > start the watchdog - which also does not change the behaviour if the
> 
> behavior

Thanks.

> > parameter is not given.
> > 
> > Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> > ---
> > 
> >   Documentation/watchdog/watchdog-parameters.txt |  1 +
> >   drivers/watchdog/omap_wdt.c                    | 10 ++++++++++
> >   2 files changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/watchdog/watchdog-parameters.txt
> > b/Documentation/watchdog/watchdog-parameters.txt index 692791c..fb023bb
> > 100644
> > --- a/Documentation/watchdog/watchdog-parameters.txt
> > +++ b/Documentation/watchdog/watchdog-parameters.txt
> > @@ -208,6 +208,7 @@ nowayout: Watchdog cannot be stopped once started
> > 
> >   -------------------------------------------------
> >   omap_wdt:
> >   timer_margin: initial watchdog timeout (in seconds)
> > 
> > +start_enabled: Watchdog is started on module insertion (default=0)
> 
> Please name the parameter early_enable. We have one driver with
> early_disable, so this makes it at least to some degree generic.

We also have one driver with start_enabled. pnx833x_wdt was my example. But I 
am not very attached to start_enabled. I can change this if you want.

> >   -------------------------------------------------
> >   orion_wdt:
> >   heartbeat: Initial watchdog heartbeat in seconds
> > 
> > diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> > index a29a61d..7dc8de7 100644
> > --- a/drivers/watchdog/omap_wdt.c
> > +++ b/drivers/watchdog/omap_wdt.c
> > @@ -53,6 +53,13 @@ static unsigned timer_margin;
> > 
> >   module_param(timer_margin, uint, 0);
> >   MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
> > 
> > +#define START_DEFAULT	0
> > +static bool start_enabled = START_DEFAULT;
> 
> Please drop the define. Static variables do not need to be initialized to 0.
> Cirumventing that with a define to defeat the resulting warning isn't
> really the idea.

I also got this inspiration from pnx833x_wdt. But there the default is to 
enable it by default, so the static variable is initialized to 1. The idea is 
not to prevent the warning but if the default behavior changes in the future, 
you only have to change it in one place.
But as above, I can change this. I will submit a v2.

> > +module_param(start_enabled, bool, 0);
> > +MODULE_PARM_DESC(start_enabled,
> > +	"Watchdog is started on module insertion (default="
> > +	__MODULE_STRING(START_DEFAULT) ")");
> 
> and just make this default=0.
> 
> Thanks,
> Guenter

Regards,
Lars
