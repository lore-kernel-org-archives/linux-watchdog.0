Return-path: <ukl@pengutronix.de>
Date: Tue, 17 Jan 2017 09:21:27 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Stefan Agner <stefan@agner.ch>, Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel@lists.infradead.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] ARM: dts: imx: add fsl, imx35-wdt compatible to all
 relevant watchdog nodes
Message-ID: <20170117082127.7kfxtvqg6t4a4ncc@pengutronix.de>
References: <20170117012336.6891-1-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170117012336.6891-1-vz@mleia.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Jan 17, 2017 at 03:23:36AM +0200, Vladimir Zapolskiy wrote:
> Watchdog device controller found on all modern SoCs from i.MX series
> and firstly introduced in i.MX35 is not one in one compatible with the
> watchdog controllers on i.MX21, i.MX27 and i.MX31, the latter
> controlles don't have WICR (and pretimeout notification support) and
> WMCR registers. To get benefit from the more advanced watchdog device
> and to avoid operations over non-existing registers on legacy SoCs add
> fsl,imx35-wdt compatible to descriptions of all i.MX35 compatible
> watchdog controllers.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
> RFC change is found at https://patchwork.kernel.org/patch/9350007
> 
> Changes from RFC to v1:
> * added the same change to devicetree bindings documentation, thanks
>   to Baruch Siach for review,
> * replaced a new shared compatible derived from i.MX25 with an earlier
>   from i.MX35 SoC one, thanks to Uwe Kleine-König for review.
> 
> Compatible "fsl,imx21-wdt" is preserved as a generic one, because
> interface to a watchdog controller on i.MX35 is a superset of the
> interface to a i.MX21 watchdog controller.

One could argue here, but apart from the discussion if this is correct
or not, choosing this way has the upside that teaching the driver after
this change about the i.MX35 type doesn't make the machines based on the
newer type suffer from a breakage for one commit.

>  Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt |  2 +-

When I created my patch set for this breakage I wondered if the
documentation should point out which are the unique types.

>  arch/arm/boot/dts/imx25.dtsi                               |  3 ++-
>  arch/arm/boot/dts/imx50.dtsi                               |  3 ++-
>  arch/arm/boot/dts/imx51.dtsi                               |  6 ++++--
>  arch/arm/boot/dts/imx53.dtsi                               |  6 ++++--
>  arch/arm/boot/dts/imx6qdl.dtsi                             |  6 ++++--
>  arch/arm/boot/dts/imx6sl.dtsi                              |  6 ++++--
>  arch/arm/boot/dts/imx6sx.dtsi                              |  9 ++++++---
>  arch/arm/boot/dts/imx6ul.dtsi                              |  6 ++++--
>  arch/arm/boot/dts/imx7s.dtsi                               | 12 ++++++++----
>  arch/arm/boot/dts/ls1021a.dtsi                             |  2 +-
>  arch/arm/boot/dts/vfxxx.dtsi                               |  3 ++-

The imx21 type is also used in

	arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
	arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi

What about these?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
