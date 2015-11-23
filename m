Return-path: <lee.jones@linaro.org>
Date: Mon, 23 Nov 2015 08:20:11 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Guenter Roeck <linux@roeck-us.net>, dinh.linux@gmail.com,
	linux-watchdog@vger.kernel.org,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, wim@iguana.be, robh+dt@kernel.org,
	kernel@savoirfairelinux.com, kernel@pengutronix.de,
	shawnguo@kernel.org, sameo@linux.intel.com
Subject: Re: [PATCH v3 2/5] mfd: syscon: add a DT property to set value width
Message-ID: <20151123082011.GG3098@x1>
References: <1447700814-5391-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151117091946.GG17829@x1>
 <20151117172649.GA11035@roeck-us.net>
 <4478024.TgK5OkRQEy@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4478024.TgK5OkRQEy@wuerfel>
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, 21 Nov 2015, Arnd Bergmann wrote:

> On Tuesday 17 November 2015 09:26:49 Guenter Roeck wrote:
> > > 
> > > This syntax is confusing, as we normally associate it with an error
> > > condition.  Instead, I'd use:
> > > 
> > >   if (of_property_read_u32(np, "bus-width", &bus_width) == 0)
> > 
> > Or maybe better
> > 
> >         if (!of_property_read_u32(np, "bus-width", &bus_width))
> 
> I would also prefer the latter, but it doesn't matter much either way.
> 
> > > 
> > > Or, for more clarity:
> > > 
> > >   of_property_read_u32(np, "bus-width", &bus_width);
> > >   if (bus_width)
> > > 
> > > If you choose this version (which I think is my preferred method, don't
> > > forget to initialise 'bus_width' to zero.
> > > 
> > Ignoring an error and depending on bus_width==0 to determine if the property
> > was provided seems odd, especially since it would "hide" if the bus-width
> > property is set to 0. In the original code, this would be detected as error.
> 
> Right.
> 
> Another option would be
> 
> 	ret = of_property_read_u32(np, "bus-width", &bus_width);
> 	/* no bus width provided, default to 32-bit */
> 	if (ret)
> 		bus_width = 32;
> 
> 	syscon_config.val_bits = bus_width;
> 	syscon_config.reg_stride = syscon_config.val_bits / 8;
> 
> which has the same effect but seems a little clearer to me.

Works for me.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
