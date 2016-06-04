Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58704 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbcFDR6Q (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 4 Jun 2016 13:58:16 -0400
Subject: Re: [PATCH v2 1/3] watchdog: Add Meson GXBB Watchdog Driver
To: Neil Armstrong <narmstrong@baylibre.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1464943007-18000-1-git-send-email-narmstrong@baylibre.com>
 <1464943007-18000-2-git-send-email-narmstrong@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <575316A6.9080403@roeck-us.net>
Date: Sat, 4 Jun 2016 10:57:58 -0700
MIME-Version: 1.0
In-Reply-To: <1464943007-18000-2-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/03/2016 01:36 AM, Neil Armstrong wrote:
> Add watchdog specific driver for Amlogic Meson GXBB SoC.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/watchdog/Kconfig          |  10 ++
>   drivers/watchdog/Makefile         |   1 +
>   drivers/watchdog/meson_gxbb_wdt.c | 268 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 279 insertions(+)
>   create mode 100644 drivers/watchdog/meson_gxbb_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9c41431..ad38cf5 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -609,6 +609,16 @@ config QCOM_WDT
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called qcom_wdt.
>
> +config MESON_GXBB_WATCHDOG
> +	tristate "Amlogic Meson GXBB SoCs watchdog support"
> +	depends on ARCH_MESON
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer
> +	  in Amlogic Meson GXBB SoCs.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called meson_gxbb_wdt.
> +
>   config MESON_WATCHDOG
>   	tristate "Amlogic Meson SoCs watchdog support"
>   	depends on ARCH_MESON
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9bde095..a46bf09 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_ST_LPC_WATCHDOG) += st_lpc_wdt.o
>   obj-$(CONFIG_QCOM_WDT) += qcom-wdt.o
>   obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
>   obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
> +obj-$(CONFIG_MESON_GXBB_WATCHDOG) += meson_gxbb_wdt.o
>   obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
>   obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
>   obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> new file mode 100644
> index 0000000..ab3d789
> --- /dev/null
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -0,0 +1,268 @@
> +/*
> + * This file is provided under a dual BSD/GPLv2 license.  When using or
> + * redistributing this file, you may do so under either license.
> + *
> + * GPL LICENSE SUMMARY
> + *
> + * Copyright (c) 2016 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * The full GNU General Public License is included in this distribution
> + * in the file called COPYING.
> + *
> + * BSD LICENSE
> + *
> + * Copyright (c) 2016 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
Nitpick, but you don't really need the copyright and author lines twice.

> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + *   * Redistributions of source code must retain the above copyright
> + *     notice, this list of conditions and the following disclaimer.
> + *   * Redistributions in binary form must reproduce the above copyright
> + *     notice, this list of conditions and the following disclaimer in
> + *     the documentation and/or other materials provided with the
> + *     distribution.
> + *   * Neither the name of Intel Corporation nor the names of its
> + *     contributors may be used to endorse or promote products derived
> + *     from this software without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +
> +#define DEFAULT_TIMEOUT	30	/* seconds */
> +
> +#define GXBB_WDT_CTRL_REG			0x0
> +#define GXBB_WDT_TCNT_REG			0x8
> +#define GXBB_WDT_RSET_REG			0xc
> +
> +#define GXBB_WDT_CTRL_CLKDIV_EN			BIT(25)
> +#define GXBB_WDT_CTRL_CLK_EN			BIT(24)
> +#define GXBB_WDT_CTRL_EE_RESET			BIT(21)
> +#define GXBB_WDT_CTRL_EN			BIT(18)
> +#define GXBB_WDT_CTRL_DIV_MASK			(BIT(18) - 1)
> +
> +#define GXBB_WDT_TCNT_SETUP_MASK		(BIT(16) - 1)
> +#define GXBB_WDT_TCNT_CNT_SHIFT			16
> +
> +struct meson_gxbb_wdt {
> +	void __iomem *reg_base;
> +	struct watchdog_device wdt_dev;
> +	struct clk *clk;
> +};
> +
> +static int meson_gxbb_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> +
> +	writel(readl(data->reg_base + GXBB_WDT_CTRL_REG) | GXBB_WDT_CTRL_EN,
> +	       data->reg_base + GXBB_WDT_CTRL_REG);
> +
> +	return 0;
> +}
> +
> +static int meson_gxbb_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> +
> +	writel(readl(data->reg_base + GXBB_WDT_CTRL_REG) & ~GXBB_WDT_CTRL_EN,
> +	       data->reg_base + GXBB_WDT_CTRL_REG);
> +
> +	return 0;
> +}
> +
> +static int meson_gxbb_wdt_ping(struct watchdog_device *wdt_dev)
> +{
> +	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> +
> +	writel(0, data->reg_base + GXBB_WDT_RSET_REG);
> +
> +	return 0;
> +}
> +
> +static int meson_gxbb_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +				      unsigned int timeout)
> +{
> +	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> +	unsigned long tcnt = timeout * 1000;
> +
> +	if (tcnt > GXBB_WDT_TCNT_SETUP_MASK)
> +		return -EINVAL;
> +

No; what you need to do is

	if (tcnt > GXBB_WDT_TCNT_SETUP_MASK)
		tcnt = GXBB_WDT_TCNT_SETUP_MASK;

Also, you need
	wdt_dev->timeout = timeout;

> +	meson_gxbb_wdt_ping(wdt_dev);
> +
> +	writel(tcnt, data->reg_base + GXBB_WDT_TCNT_REG);
> +
> +	return 0;
> +}
> +
> +static unsigned int meson_gxbb_wdt_get_timeleft(struct watchdog_device *wdt_dev)
> +{
> +	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> +	unsigned long reg;
> +
> +	reg = readl(data->reg_base + GXBB_WDT_TCNT_REG);
> +
> +	return ((reg >> GXBB_WDT_TCNT_CNT_SHIFT) -
> +		(reg & GXBB_WDT_TCNT_SETUP_MASK)) / 1000;
> +}
> +
> +static const struct watchdog_ops meson_gxbb_wdt_ops = {
> +	.start = meson_gxbb_wdt_start,
> +	.stop = meson_gxbb_wdt_stop,
> +	.ping = meson_gxbb_wdt_ping,
> +	.set_timeout = meson_gxbb_wdt_set_timeout,
> +	.get_timeleft = meson_gxbb_wdt_get_timeleft,
> +};
> +
> +static const struct watchdog_info meson_gxbb_wdt_info = {
> +	.identity = "Meson GXBB Watchdog",
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +};
> +
> +static int __maybe_unused meson_gxbb_wdt_resume(struct device *dev)
> +{
> +	struct meson_gxbb_wdt *data = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&data->wdt_dev))
> +		meson_gxbb_wdt_start(&data->wdt_dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused meson_gxbb_wdt_suspend(struct device *dev)
> +{
> +	struct meson_gxbb_wdt *data = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&data->wdt_dev))
> +		meson_gxbb_wdt_stop(&data->wdt_dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops meson_gxbb_wdt_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(meson_gxbb_wdt_suspend, meson_gxbb_wdt_resume)
> +};
> +
> +static const struct of_device_id meson_gxbb_wdt_dt_ids[] = {
> +	 { .compatible = "amlogic,meson-gxbb-wdt", },
> +	 { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, meson_gxbb_wdt_dt_ids);
> +
> +static int meson_gxbb_wdt_probe(struct platform_device *pdev)
> +{
> +	struct meson_gxbb_wdt *data;
> +	struct resource *res;
> +	int ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->reg_base))
> +		return PTR_ERR(data->reg_base);
> +
> +	data->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->clk))
> +		return PTR_ERR(data->clk);
> +
> +	clk_prepare_enable(data->clk);
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	data->wdt_dev.parent = &pdev->dev;
> +	data->wdt_dev.info = &meson_gxbb_wdt_info;
> +	data->wdt_dev.ops = &meson_gxbb_wdt_ops;
> +	data->wdt_dev.max_hw_heartbeat_ms = GXBB_WDT_TCNT_SETUP_MASK;
> +	data->wdt_dev.min_timeout = 1;
> +	data->wdt_dev.timeout = DEFAULT_TIMEOUT;
> +	watchdog_set_drvdata(&data->wdt_dev, data);
> +
> +	/* Setup with 1ms timebase */
> +	writel(((clk_get_rate(data->clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
> +		GXBB_WDT_CTRL_EE_RESET |
> +		GXBB_WDT_CTRL_CLK_EN |
> +		GXBB_WDT_CTRL_CLKDIV_EN,
> +		data->reg_base + GXBB_WDT_CTRL_REG);
> +
> +	meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
> +
> +	ret = watchdog_register_device(&data->wdt_dev);
> +	if (ret) {
> +		clk_disable_unprepare(data->clk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int meson_gxbb_wdt_remove(struct platform_device *pdev)
> +{
> +	struct meson_gxbb_wdt *data = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&data->wdt_dev);
> +
> +	clk_disable_unprepare(data->clk);
> +
> +	return 0;
> +}
> +
> +static void meson_gxbb_wdt_shutdown(struct platform_device *pdev)
> +{
> +	struct meson_gxbb_wdt *data = platform_get_drvdata(pdev);
> +
> +	meson_gxbb_wdt_stop(&data->wdt_dev);
> +}
> +
> +static struct platform_driver meson_gxbb_wdt_driver = {
> +	.probe	= meson_gxbb_wdt_probe,
> +	.remove	= meson_gxbb_wdt_remove,
> +	.shutdown = meson_gxbb_wdt_shutdown,
> +	.driver = {
> +		.name = "meson-gxbb-wdt",
> +		.pm = &meson_gxbb_wdt_pm_ops,
> +		.of_match_table	= meson_gxbb_wdt_dt_ids,
> +	},
> +};
> +
> +module_platform_driver(meson_gxbb_wdt_driver);
> +
> +MODULE_ALIAS("platform:meson-gxbb-wdt");
> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> +MODULE_DESCRIPTION("Amlogic Meson GXBB Watchdog timer driver");
> +MODULE_LICENSE("Dual BSD/GPL");
>

