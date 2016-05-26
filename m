Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41700 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbcEZNyz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 May 2016 09:54:55 -0400
Subject: Re: [RFC PATCH 1/3] watchdog: Add Meson GXBB Watchdog Driver
To: Neil Armstrong <narmstrong@baylibre.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1464249112-13658-1-git-send-email-narmstrong@baylibre.com>
 <1464249112-13658-2-git-send-email-narmstrong@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57470026.3000501@roeck-us.net>
Date: Thu, 26 May 2016 06:54:46 -0700
MIME-Version: 1.0
In-Reply-To: <1464249112-13658-2-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/26/2016 12:51 AM, Neil Armstrong wrote:
> Add watchdog specific driver for Amlogic Meson GXBB SoC.
>

Wondering - why RFC ?

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/watchdog/Makefile         |   1 +
>   drivers/watchdog/meson_gxbb_wdt.c | 287 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 288 insertions(+)
>   create mode 100644 drivers/watchdog/meson_gxbb_wdt.c
>
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9bde095..7679d93 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_QCOM_WDT) += qcom-wdt.o
>   obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
>   obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
>   obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
> +obj-$(CONFIG_MESON_WATCHDOG) += meson_gxbb_wdt.o
>   obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
>   obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
>   obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> new file mode 100644
> index 0000000..0c7c0d9
> --- /dev/null
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -0,0 +1,287 @@
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
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +
> +#define DEFAULT_TIMEOUT	10	/* seconds */
> +
> +#define GXBB_WDT_CTRL_REG	0x0
> +#define GXBB_WDT_CTRL1_REG	0x4
> +#define GXBB_WDT_TCNT_REG	0x8
> +#define GXBB_WDT_RSET_REG	0xc
> +
> +#define GXBB_WDT_CTRL_EE_RESET_NOW	BIT(26)
> +
> +#define GXBB_WDT_CTRL_CLKDIV_EN	BIT(25)
> +#define GXBB_WDT_CTRL_CLK_EN	BIT(24)
> +#define GXBB_WDT_CTRL_IRQ_EN	BIT(23)
> +#define GXBB_WDT_CTRL_EE_RESET	BIT(21)
> +#define GXBB_WDT_CTRL_XTAL_SEL	(0)
> +#define GXBB_WDT_CTRL_CLK81_SEL	BIT(19)
> +#define GXBB_WDT_CTRL_EN	BIT(18)
> +#define GXBB_WDT_CTRL_DIV_MASK	(BIT(18)-1)
> +
> +#define GXBB_WDT_CTRL1_GPIO_PULSE	BIT(17)
> +#define GXBB_WDT_CTRL1_GPIO_POL_RESET_0	BIT(16)
> +#define GXBB_WDT_CTRL1_GPIO_POL_RESET_1	(0)
> +#define GXBB_WDT_CTRL1_GPIO_PULSE_CNT	(BIT(16)-1)
> +

Spaces around operators, please.

> +#define GXBB_WDT_TCNT_SETUP_MASK	(BIT(16)-1)
> +#define GXBB_WDT_TCNT_CNT_SHIFT		16
> +
> +struct meson_gxbb_wdt {
> +	void __iomem *reg_base;
> +	struct watchdog_device wdt_dev;
> +	struct clk *clk;
> +};
> +
> +int meson_gxbb_wdt_start(struct watchdog_device *wdt_dev)

Functions should all be static.

> +{
> +	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> +
> +	writel(readl(data->reg_base + GXBB_WDT_CTRL_REG) | GXBB_WDT_CTRL_EN,
> +		data->reg_base + GXBB_WDT_CTRL_REG);
> +
> +	return 0;
> +}
> +
> +int meson_gxbb_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> +
> +	writel(readl(data->reg_base + GXBB_WDT_CTRL_REG) & ~GXBB_WDT_CTRL_EN,
> +		data->reg_base + GXBB_WDT_CTRL_REG);
> +
> +	return 0;
> +}
> +
> +unsigned int meson_gxbb_wdt_status(struct watchdog_device *wdt_dev)
> +{
> +	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> +
> +	return !!(readl(data->reg_base + GXBB_WDT_CTRL_REG) & GXBB_WDT_CTRL_EN);

This function is not supposed to return 0/1 but a bit mask with relevant
WDIOF_bits set. sbsa_gwdt.c is buggy (oops, and I reviewed it ;-), so
please don't use it as example; it doesn't make much sense to return
a kernel-only flag to user space.

Overall I would suggest to not implement the function at all. We'll have
to revisit it - its current implementation in the watchdog core does not
make much sense and for the most part only returns 0 to user space.
The only driver implementing it (sbsa) returns a bad value. It is also
_not_ supposed to return the "watchdog running" status as currently
implemented (there is no WDIOF_ flag indicating that the watchdog is
running).

> +}
> +
> +int meson_gxbb_wdt_ping(struct watchdog_device *wdt_dev)
> +{
> +	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> +
> +	writel(0, data->reg_base + GXBB_WDT_RSET_REG);
> +
> +	return 0;
> +}
> +
> +int meson_gxbb_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +			       unsigned int timeout)
> +{
> +	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> +
> +	if (watchdog_active(wdt_dev))
> +		meson_gxbb_wdt_stop(wdt_dev);
> +

Is the stop/start sequence mandatory ? It leaves the system unprotected
for a few cycles, so it is undesirable.

> +	meson_gxbb_wdt_ping(wdt_dev);
> +
> +	writel(timeout*1000, data->reg_base + GXBB_WDT_TCNT_REG);
> +
> +	if (watchdog_active(wdt_dev))
> +		meson_gxbb_wdt_start(wdt_dev);
> +
> +	return 0;
> +}
> +
> +unsigned int meson_gxbb_wdt_get_timeleft(struct watchdog_device *wdt_dev)
> +{
> +	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> +	unsigned long reg;
> +
> +	reg = readl(data->reg_base + GXBB_WDT_TCNT_REG);
> +
> +	return ((reg >> GXBB_WDT_TCNT_CNT_SHIFT)-
> +			(reg & GXBB_WDT_TCNT_SETUP_MASK)) / 1000;
> +}
> +
> +static const struct watchdog_ops meson_gxbb_wdt_ops = {
> +	.start = meson_gxbb_wdt_start,
> +	.stop = meson_gxbb_wdt_stop,
> +	.status = meson_gxbb_wdt_status,
> +	.ping = meson_gxbb_wdt_ping,
> +	.set_timeout = meson_gxbb_wdt_set_timeout,
> +	.get_timeleft = meson_gxbb_wdt_get_timeleft,
> +};
> +
> +static const struct watchdog_info meson_gxbb_wdt_info = {
> +	.identity = "meson-gxbb-wdt",
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
> +	data->wdt_dev.min_hw_heartbeat_ms = 1;

Does the device require a minimum time between heartbeats ?
Just asking, because you violate it yourself below.

If you want to set the minimum timeout, that would be min_timeout.

> +	data->wdt_dev.timeout = DEFAULT_TIMEOUT;
> +	watchdog_set_drvdata(&data->wdt_dev, data);
> +
> +	watchdog_init_timeout(&data->wdt_dev, DEFAULT_TIMEOUT, &pdev->dev);
> +

DEFAULT_TIMEOUT is unnecessary here. Since the default timeout is already set,
it makes the call useless.

> +	ret = watchdog_register_device(&data->wdt_dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup with 1ms timebase */
> +	writel(((clk_get_rate(data->clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
> +		GXBB_WDT_CTRL_EE_RESET |
> +		GXBB_WDT_CTRL_CLK_EN |
> +		GXBB_WDT_CTRL_CLKDIV_EN,
> +		data->reg_base + GXBB_WDT_CTRL_REG);
> +	meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);

set_timeout already calls the ping function. Also, the functions should be called
prior to watchdog registration to avoid race conditions.

> +	meson_gxbb_wdt_ping(&data->wdt_dev);

This is unusual. If the watchdog can be already running, it might make sense
to tell the core about it (set WDOG_HW_RUNNING in the status field), so it
can send heartbeats until user space opens the device.

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

