Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:52797 "EHLO
	mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751615AbbIBKZV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Sep 2015 06:25:21 -0400
Date: Wed, 2 Sep 2015 10:39:24 +0100
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
To: Pratyush Anand <panand@redhat.com>
CC: <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
	kbuild test robot <fengguang.wu@intel.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Andreas Werner <andreas.werner@men.de>,
	Barry Song <baohua@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	"open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Kukjin Kim <kgene@kernel.org>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"moderated list:ARM/U300 MACHINE SUPPORT"
	<linux-arm-kernel@lists.infradead.org>,
	"open list:INTEL MANAGEMENT ENGINE (mei)"
	<linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
	<linux-rpi-kernel@lists.infradead.org>,
	"moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
	<linux-samsung-soc@vger.kernel.org>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	"open list:WOLFSON MICROELECTRONICS DRIVERS"
	<patches@opensource.wolfsonmicro.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH V3] Watchdog: Fix parent of watchdog_devices
Message-ID: <20150902093924.GA12688@ck-lbox>
References: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Aug 19, 2015 at 08:58:24AM +0530, Pratyush Anand wrote:
> /sys/class/watchdog/watchdogn/device/modalias can help to identify the
> driver/module for a given watchdog node. However, many wdt devices does not set
> its parent and so, we do not see an entry for device in sysfs for such devices.
> 
> This patch fixes parent of watchdog_device so that
> /sys/class/watchdog/watchdogn/device is populated.
> 
> Exceptions: booke, diag288, mpc8xxx, octeon, softdog and w83627hf -- They do not
> have any parent. Not sure, how we can we identify driver for these devices.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---

For the Wolfson parts:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
