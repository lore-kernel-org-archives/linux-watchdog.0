Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.115]:15785 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752009Ab3FNHgs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Jun 2013 03:36:48 -0400
Date: Fri, 14 Jun 2013 09:39:48 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Guenter Roeck <linux@roeck-us.net>
CC: Johannes Thumshirn <johannes.thumshirn@men.de>, <wim@iguana.be>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
	<guenter@roeck-us.net>
Subject: Re: [PATCH v8] watchdog: New watchdog driver for MEN A21 watchdogs
Message-ID: <20130614073948.GA9438@jtlinux>
References: <20130531114037.GA13533@roeck-us.net>
 <20130603143453.GA14251@jtlinux>
 <20130614035533.GC6980@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20130614035533.GC6980@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jun 13, 2013 at 08:55:33PM -0700, Guenter Roeck wrote:
[...]
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>
>
> Almost good. One comment below.
>
> Thanks,
> Guenter
>
Nice to hear. Thanks for the review by the way.

[...]

> > +
> > +	drv->num_gpios = of_gpio_count(node);
> > +	if (drv->num_gpios <= 0) {
> > +		dev_err(&pdev->dev, "gpios DT property empty / missing");
> > +		return -ENODEV;
> > +	}
>
> Not happy with this. Code accepts one gpio pin, but then assumes throughout the
> driver that all pins are defined. I am quite sure I can get it to crash if I
> specify only a single gpio pin. num_gpios will be 1, you allocate a single
> entry, but then access all 6 of them.
>
> I think it would be easier if you expect a fixed number of gpio pins (6) and abort
> if it is not correct. You can then make drv->gpios an array and don't have to
> allocate it separately, and you don't need drv->num_gpios (which you don't need
> anyway as it is not used outside this function).
>

Yup, you're right. Now that you're saying it I see it as well. This is probably a
copy'n'paste error from drivers/hwmon/gpio-fan.c.

@Wim are there any objections from your side?

Byte
Johannes
