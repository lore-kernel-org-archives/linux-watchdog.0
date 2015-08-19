Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46940 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752171AbbHSK4P (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Aug 2015 06:56:15 -0400
Message-ID: <55D46089.8030801@st.com>
Date: Wed, 19 Aug 2015 12:55:05 +0200
From: Maxime Coquelin <maxime.coquelin@st.com>
MIME-Version: 1.0
To: Pratyush Anand <panand@redhat.com>, <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>,
	kbuild test robot <fengguang.wu@intel.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Andreas Werner <andreas.werner@men.de>,
	Barry Song <baohua@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Johannes Thumshirn <morbidrsa@gmail.com>, open list:
	ARM/STI ARCHITECTURE <kernel@stlinux.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Kukjin Kim <kgene@kernel.org>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, ; moderated list:
	ARM/U300 MACHINE SUPPORT <linux-arm-kernel@lists.infradead.org>,
	"open list:INTEL MANAGEMENT ENGINE (mei)"
	<linux-kernel@vger.kernel.org>, ; moderated list:
	BROADCOM BCM2835 ARM ARCHITECTURE
	<linux-rpi-kernel@lists.infradead.org>, ; moderated list:
	ARM/SAMSUNG EXYNOS ARM ARCHITECTURES
	<linux-samsung-soc@vger.kernel.org>, ; open list:
	TEGRA ARCHITECTURE SUPPORT <linux-tegra@vger.kernel.org>, ;
	open list:
	WOLFSON MICROELECTRONICS DRIVERS
	<patches@opensource.wolfsonmicro.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wim Van Sebroeck <wim@iguana.be>, ;
Subject: Re: [PATCH V3] Watchdog: Fix parent of watchdog_devices
References: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
In-Reply-To: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Pratyush,

On 08/19/2015 05:28 AM, Pratyush Anand wrote:
> diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
> index 6785afdc0fca..14e9badf2bfa 100644
> --- a/drivers/watchdog/st_lpc_wdt.c
> +++ b/drivers/watchdog/st_lpc_wdt.c
> @@ -241,6 +241,7 @@ static int st_wdog_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   	st_wdog_dev.max_timeout = 0xFFFFFFFF / st_wdog->clkrate;
> +	st_wdog_dev.parent = &pdev->dev;
>   
>   	ret = clk_prepare_enable(clk);
>   	if (ret) {

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
