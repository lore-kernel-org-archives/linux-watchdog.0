Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0130.outbound.protection.outlook.com ([65.55.169.130]:33019
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753453AbbHRRBh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 13:01:37 -0400
From: Hartley Sweeten <HartleyS@visionengravers.com>
To: Pratyush Anand <panand@redhat.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	"open list:WOLFSON MICROELECTRONICS DRIVERS"
	<patches@opensource.wolfsonmicro.com>,
	"open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Baruch Siach <baruch@tkos.co.il>,
	"open list:INTEL MANAGEMENT ENGINE mei"
	<linux-kernel@vger.kernel.org>, "Wim Van Sebroeck" <wim@iguana.be>,
	Thierry Reding <thierry.reding@gmail.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	"moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
	<linux-samsung-soc@vger.kernel.org>, Lee Jones <lee@kernel.org>,
	Kukjin Kim <kgene@kernel.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
	<linux-rpi-kernel@lists.infradead.org>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	"moderated list:ARM/U300 MACHINE SUPPORT"
	<linux-arm-kernel@lists.infradead.org>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Barry Song <baohua@kernel.org>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Andreas Werner <andreas.werner@men.de>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Patrice Chotard <patrice.chotard@st.com>
Subject: RE: [PATCH V2] Watchdog: Fix parent of watchdog_devices
Date: Tue, 18 Aug 2015 16:45:44 +0000
Message-ID: <BN3PR0101MB1057C3FE09F00EEC55D2C9B1D0780@BN3PR0101MB1057.prod.exchangelabs.com>
References: <9fcc2a2cc8273f461baa13c6c9992f3ca56b508a.1439915117.git.panand@redhat.com>
In-Reply-To: <9fcc2a2cc8273f461baa13c6c9992f3ca56b508a.1439915117.git.panand@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tuesday, August 18, 2015 9:34 AM, Pratyush Anand wrote:
>=20
> /sys/class/watchdog/watchdogn/device/modalias can help to identify the
> driver/module for a given watchdog node. However, many wdt devices does=
 not set
> its parent and so, we do not see an entry for device in sysfs for such =
devices.
>
> This patch fixes parent of watchdog_device so that
> /sys/class/watchdog/watchdogn/device is populated.
>
> Exceptions: booke, diag288, mpc8xxx, octeon, softdog and w83627hf -- Th=
ey do not
> have any parent. Not sure, how we can we identify driver for these devi=
ces.
>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
[snip]

drivers/watchdog/ep93xx_wdt.c       | 1 +

[snip]

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.=
c
index 7a2cc7191c58..0a4d7cc05d54 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -132,6 +132,7 @@ static int ep93xx_wdt_probe(struct platform_device *p=
dev)
 	val =3D readl(mmio_base + EP93XX_WATCHDOG);
 	ep93xx_wdt_wdd.bootstatus =3D (val & 0x01) ? WDIOF_CARDRESET : 0;
 	ep93xx_wdt_wdd.timeout =3D timeout;
+	ep93xx_wdt_wdd.parent =3D &pdev->dev;
=20
 	watchdog_set_nowayout(&ep93xx_wdt_wdd, nowayout);

For ep93xx_wdt.c, use whichever tag you prefer:

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks,
Hartley

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
