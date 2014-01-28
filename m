Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55160 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753775AbaA1K1r (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jan 2014 05:27:47 -0500
Date: Tue, 28 Jan 2014 07:27:50 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Lior Amsalem <alior@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v5 14/20] watchdog: orion: Add support for Armada 370 and
 Armada XP SoC
Message-ID: <20140128102750.GA13052@localhost>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390836440-12744-15-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140127173624.GT15937@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140127173624.GT15937@n2100.arm.linux.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 27, 2014 at 05:36:24PM +0000, Russell King - ARM Linux wrot=
e:
[..]
> > +static int armadaxp_wdt_clock_init(struct platform_device *pdev,
> > +				   struct orion_watchdog *dev)
> > +{
> > +	int ret;
> > +
> > +	dev->clk =3D of_clk_get_by_name(pdev->dev.of_node, "fixed");
> > +	if (IS_ERR(dev->clk))
> > +		return PTR_ERR(dev->clk);
> > +	ret =3D clk_prepare_enable(dev->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable the fixed watchdog clock input */
> > +	atomic_io_modify(dev->reg + TIMER_CTRL,
> > +			 WDT_AXP_FIXED_ENABLE_BIT,
> > +			 WDT_AXP_FIXED_ENABLE_BIT);
> > +
> > +	dev->clk_rate =3D clk_get_rate(dev->clk);
> > +	return 0;
> > +}
>=20
> Doesn't this result in dev->clk being leaked?  Or at least a differen=
ce
> in the way dev->clk needs to be cleaned up between these two function=
s?
>=20

Yes, indeed.

> I think it would be better in this case to use the standard clk_get()=
 in
> the first function and always use clk_put()... until there is a devm_=
*
> version of the of_clk_get* functions.
>=20

Sound good.

Thanks,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
