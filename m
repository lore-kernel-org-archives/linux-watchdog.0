Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sat, 14 May 2016 18:38:20 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Tim Harvey <tharvey@gateworks.com>
Cc: linux-watchdog@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Guenter Roeck <linux@roeck-us.net>, Stefan Roese <sr@denx.de>,
	Iain Paton <ipaton0@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 1/2] watchdog: imx2_wdt: add external reset support via dt prop
Message-ID: <20160514163820.GC20158@spo001.leaseweb.nl>
References: <1459523804-11390-1-git-send-email-tharvey@gateworks.com> <1459523804-11390-2-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459523804-11390-2-git-send-email-tharvey@gateworks.com>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Tim,

> The IMX6 watchdog supports assertion of a signal (WDOG_B) which
> can be pinmux'd to an external pin. This is typically used for boards that
> have PMIC's in control of the IMX6 power rails. In fact, failure to use
> such an external reset on boards with external PMIC's can result in various
> hangs due to the IMX6 not being fully reset [1] as well as the board failing
> to reset because its PMIC has not been reset to provide adequate voltage for
> the CPU when coming out of reset at 800Mhz.
> 
> This uses a new device-tree property 'fsl,ext-reset-output' to indicate the
> board has such a reset and to cause the watchdog to be configured to assert
> WDOG_B instead of an internal reset both on a watchdog timeout and in
> system_restart.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html
> 
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Iain Paton <ipaton0@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Akshay Bhat <akshay.bhat@timesys.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> v5:
>  - rename property to 'fsl,ext-reset-output'
> v4:
>  - change Property to Properties in documentation
> v3:
>  - mandate use of 'either' internal or external reset but not both
>    simultaneously
> v2:
>  - rename property to 'ext-reset-output' based on ML feedback
>  - simplify setting SRS bit if external-reset
>  - update comments and commit msg
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../devicetree/bindings/watchdog/fsl-imx-wdt.txt      |  4 +++-
>  drivers/watchdog/imx2_wdt.c                           | 19 +++++++++++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.
