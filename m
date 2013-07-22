Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.151]:51739 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755096Ab3GVGRF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Jul 2013 02:17:05 -0400
Date: Mon, 22 Jul 2013 08:16:28 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Alexander Shiyan <shc_work@mail.ru>
CC: Guenter Roeck <linux@roeck-us.net>,
	<linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	<johannes.thumshirn@men.de>
Subject: Re: [RFC] watchdog: GPIO-controlled watchdog
Message-ID: <20130722061628.GA24579@jtlinux>
References: <1373814599-6040-1-git-send-email-shc_work@mail.ru>
 <20130714194356.GA29771@roeck-us.net>
 <20130720080749.6394f6c4fb07b0a6b2b02946@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20130720080749.6394f6c4fb07b0a6b2b02946@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Jul 20, 2013 at 08:07:49AM +0400, Alexander Shiyan wrote:
> On Sun, 14 Jul 2013 12:43:56 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
>
> > On Sun, Jul 14, 2013 at 07:09:59PM +0400, Alexander Shiyan wrote:
> > > This patch adds a watchdog driver for devices controlled through GPIO,
> > > (Analog Devices ADM706, for example). Driver written for DT-based systems
> > > only. No description for Documentation/devicetree yet.
> > > Comments are welcome.
> > >
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > >  drivers/watchdog/Kconfig    |   8 +++
> > >  drivers/watchdog/Makefile   |   1 +
> > >  drivers/watchdog/gpio_wdt.c | 121 ++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 130 insertions(+)
> > >  create mode 100644 drivers/watchdog/gpio_wdt.c
>
> [...]
>
> > Lots of context knowledge here. For a generic driver, how does one know
> > that toggling the output value triggers the ping ?
> >
> > Also, there is no mention that the toggle has to occur within 1.6 seconds.
> > Linux expects that watchdogs support much larger timeouts. I think it would
> > make sense to implement a soft-dog which actually triggers the ping,
> > and handles the higher level ping received from applications.
> > There are several other watchdog drivers implementing this approach.
> >
> > Overall, I think this should be a watchdog driver specifically for
> > ADM705/706/707/708.
>
> [...]
>
> > > +	nowayout = of_property_read_bool(pdev->dev.of_node, "wdt,nowayout");
> > > +	if (!nowayout)
> > > +		nowayout = WATCHDOG_NOWAYOUT;
> >
> > I don't think it is a good idea to introduce a driver specific
> > devicetreee property like this one.
> >
> > First, it is a configuration parameter and does not describe the hardware. as
> > such, a module parameter as implemented by other drivers would be more
> > appropriate. Second, even if a devicetree property was used, it should be
> > implemented in the watchdog core code and not in drivers.
>
> [...]
>
> Thanks for the comments.
> I will make v2 with this recommendation for more generic driver.
> There are a few ideas.
>
> --
> Alexander Shiyan <shc_work@mail.ru>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I think it would be really valuable to have dt properties to set the min and
max timeouts as well.

Regards,
Johannes
