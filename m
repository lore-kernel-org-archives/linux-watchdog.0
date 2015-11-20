Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:58767 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbbKTXOb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Nov 2015 18:14:31 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee.jones@linaro.org>, dinh.linux@gmail.com,
	linux-watchdog@vger.kernel.org,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, wim@iguana.be, robh+dt@kernel.org,
	kernel@savoirfairelinux.com, kernel@pengutronix.de,
	shawnguo@kernel.org, sameo@linux.intel.com
Subject: Re: [PATCH v3 2/5] mfd: syscon: add a DT property to set value width
Date: Sat, 21 Nov 2015 00:13:27 +0100
Message-ID: <4478024.TgK5OkRQEy@wuerfel>
In-Reply-To: <20151117172649.GA11035@roeck-us.net>
References: <1447700814-5391-1-git-send-email-damien.riegel@savoirfairelinux.com> <20151117091946.GG17829@x1> <20151117172649.GA11035@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 17 November 2015 09:26:49 Guenter Roeck wrote:
> > 
> > This syntax is confusing, as we normally associate it with an error
> > condition.  Instead, I'd use:
> > 
> >   if (of_property_read_u32(np, "bus-width", &bus_width) == 0)
> 
> Or maybe better
> 
>         if (!of_property_read_u32(np, "bus-width", &bus_width))

I would also prefer the latter, but it doesn't matter much either way.

> > 
> > Or, for more clarity:
> > 
> >   of_property_read_u32(np, "bus-width", &bus_width);
> >   if (bus_width)
> > 
> > If you choose this version (which I think is my preferred method, don't
> > forget to initialise 'bus_width' to zero.
> > 
> Ignoring an error and depending on bus_width==0 to determine if the property
> was provided seems odd, especially since it would "hide" if the bus-width
> property is set to 0. In the original code, this would be detected as error.

Right.

Another option would be

	ret = of_property_read_u32(np, "bus-width", &bus_width);
	/* no bus width provided, default to 32-bit */
	if (ret)
		bus_width = 32;

	syscon_config.val_bits = bus_width;
	syscon_config.reg_stride = syscon_config.val_bits / 8;

which has the same effect but seems a little clearer to me.

	Arnd
