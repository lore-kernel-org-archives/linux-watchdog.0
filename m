Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42608 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1034787AbcIZG2F (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Sep 2016 02:28:05 -0400
Date: Mon, 26 Sep 2016 08:27:59 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] ARM: i.MX: dts: add fsl, imx25-wdt compatible to
 all relevant watchdog nodes
Message-ID: <20160926062759.3eoezyezog6clz6x@pengutronix.de>
References: <1474850361-20884-1-git-send-email-vz@mleia.com>
 <1474850361-20884-3-git-send-email-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1474850361-20884-3-git-send-email-vz@mleia.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Vladimir,

On Mon, Sep 26, 2016 at 03:39:21AM +0300, Vladimir Zapolskiy wrote:
> Watchdog device controller found on all modern SoCs from i.MX series
> and firstly introduced in i.MX25 is not one in one compatible with the
> watchdog controllers on i.MX21, i.MX27 and i.MX31, the latter
> controlles don't have WICR (and pretimeout notification support) and
> WMCR registers. To get benefit from the more advanced watchdog device
> and to avoid operations over non-existing registers on legacy SoCs add
> fsl,imx25-wdt compatible to descriptions of all i.MX25 compatible
> watchdog controllers.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/boot/dts/imx35.dtsi   |  3 ++-
>  arch/arm/boot/dts/imx50.dtsi   |  3 ++-
>  arch/arm/boot/dts/imx51.dtsi   |  6 ++++--
>  arch/arm/boot/dts/imx53.dtsi   |  6 ++++--
>  arch/arm/boot/dts/imx6qdl.dtsi |  6 ++++--
>  arch/arm/boot/dts/imx6sl.dtsi  |  6 ++++--
>  arch/arm/boot/dts/imx6sx.dtsi  |  9 ++++++---
>  arch/arm/boot/dts/imx6ul.dtsi  |  6 ++++--
>  arch/arm/boot/dts/imx7s.dtsi   | 12 ++++++++----
>  arch/arm/boot/dts/ls1021a.dtsi |  2 +-
>  arch/arm/boot/dts/vfxxx.dtsi   |  3 ++-
>  11 files changed, 41 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
> index 490b7b4..8fd4482 100644
> --- a/arch/arm/boot/dts/imx35.dtsi
> +++ b/arch/arm/boot/dts/imx35.dtsi
> @@ -284,7 +284,8 @@
>  			};
>  
>  			wdog: wdog@53fdc000 {
> -				compatible = "fsl,imx35-wdt", "fsl,imx21-wdt";
> +				compatible = "fsl,imx35-wdt", "fsl,imx25-wdt",
> +					     "fsl,imx21-wdt";

When this is used on an old kernel that doesn't know about fsl,imx25-wdt
this picks up the imx21 driver logic. As this is wrong I think you
should drop imx21-wdt here. Can one of the dt-people comfirm?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
