Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42285 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbbHSGoo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Aug 2015 02:44:44 -0400
Date: Wed, 19 Aug 2015 08:44:19 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Pratyush Anand <panand@redhat.com>
Cc: linux@roeck-us.net, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	"open list:WOLFSON MICROELECTRONICS DRIVERS"
	<patches@opensource.wolfsonmicro.com>,
	"open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Baruch Siach <baruch@tkos.co.il>,
	"open list:INTEL MANAGEMENT ENGINE mei"
	<linux-kernel@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Thierry Reding <thierry.reding@gmail.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	"moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
	<linux-samsung-soc@vger.kernel.org>, Lee Jones <lee@kernel.org>,
	Kukjin Kim <kgene@kernel.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	linux-watchdog@vger.kernel.org,
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
	Patrice Chotard <patrice.chotard@st.com>,
	kbuild test robot <fengguang.wu@intel.com>
Subject: Re: [PATCH V3] Watchdog: Fix parent of watchdog_devices
Message-ID: <20150819064419.GC9999@pengutronix.de>
References: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Aug 19, 2015 at 08:58:24AM +0530, Pratyush Anand wrote:
> /sys/class/watchdog/watchdogn/device/modalias can help to identify the
> driver/module for a given watchdog node. However, many wdt devices does=
 not set

s/es//

> its parent and so, we do not see an entry for device in sysfs for such =
devices.
>=20
> This patch fixes parent of watchdog_device so that
> /sys/class/watchdog/watchdogn/device is populated.
>=20
> Exceptions: booke, diag288, mpc8xxx, octeon, softdog and w83627hf -- Th=
ey do not
> have any parent. Not sure, how we can we identify driver for these devi=
ces.

I don't see why you don't use the platform device as parent for mpc8xxx.

Note however that I did several updates to the mpc8xxx driver which
probably conflict with setting the parent. I'll take care of that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
