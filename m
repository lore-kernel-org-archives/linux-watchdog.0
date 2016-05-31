Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59104 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbcEaRb5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 May 2016 13:31:57 -0400
Date: Tue, 31 May 2016 10:31:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: Add Meson GXBB Watchdog Driver
Message-ID: <20160531173152.GD14007@roeck-us.net>
References: <1464614948-28247-1-git-send-email-narmstrong@baylibre.com>
 <1464614948-28247-2-git-send-email-narmstrong@baylibre.com>
 <574C6F5A.1010109@roeck-us.net>
 <574D5FEF.7050308@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574D5FEF.7050308@baylibre.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 31, 2016 at 11:57:03AM +0200, Neil Armstrong wrote:
> 
> Hi Guenter,
> On 05/30/2016 06:50 PM, Guenter Roeck wrote:
> > On 05/30/2016 06:29 AM, Neil Armstrong wrote:
> >> Add watchdog specific driver for Amlogic Meson GXBB SoC.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>   drivers/watchdog/Makefile         |   1 +
> >>   drivers/watchdog/meson_gxbb_wdt.c | 277 ++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 278 insertions(+)
> >>   create mode 100644 drivers/watchdog/meson_gxbb_wdt.c
> >>
> >> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> >> index 9bde095..7679d93 100644
> >> --- a/drivers/watchdog/Makefile
> >> +++ b/drivers/watchdog/Makefile
> >> @@ -68,6 +68,7 @@ obj-$(CONFIG_QCOM_WDT) += qcom-wdt.o
> >>   obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
> >>   obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
> >>   obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
> >> +obj-$(CONFIG_MESON_WATCHDOG) += meson_gxbb_wdt.o
> > 
> > I would really prefer a separate configuration option.
> 
> OK
> 
> > 
> >>   obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
> >>   obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
> >>   obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
> >> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> >> new file mode 100644
> >> index 0000000..9619c5e
> >> --- /dev/null
> >> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> >> @@ -0,0 +1,277 @@
> >> +/*
> >> + * This file is provided under a dual BSD/GPLv2 license.  When using or
> >> + * redistributing this file, you may do so under either license.
> >> + *
> >> + * GPL LICENSE SUMMARY
> >> + *
> >> + * Copyright (c) 2016 BayLibre, SAS.
> >> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of version 2 of the GNU General Public License as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful, but
> >> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >> + * General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> >> + * The full GNU General Public License is included in this distribution
> >> + * in the file called COPYING.
> >> + *
> >> + * BSD LICENSE
> >> + *
> >> + * Copyright (c) 2016 BayLibre, SAS.
> >> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> >> + *
> >> + * Redistribution and use in source and binary forms, with or without
> >> + * modification, are permitted provided that the following conditions
> >> + * are met:
> >> + *
> >> + *   * Redistributions of source code must retain the above copyright
> >> + *     notice, this list of conditions and the following disclaimer.
> >> + *   * Redistributions in binary form must reproduce the above copyright
> >> + *     notice, this list of conditions and the following disclaimer in
> >> + *     the documentation and/or other materials provided with the
> >> + *     distribution.
> >> + *   * Neither the name of Intel Corporation nor the names of its
> >> + *     contributors may be used to endorse or promote products derived
> >> + *     from this software without specific prior written permission.
> >> + *
> >> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> >> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> >> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> >> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> >> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> >> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> >> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> >> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> >> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> >> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> >> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> >> + */
> >> +#include <linux/err.h>
> >> +#include <linux/module.h>
> >> +#include <linux/io.h>
> >> +#include <linux/of.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/types.h>
> >> +#include <linux/watchdog.h>
> > 
> > Please order include files alphabetically; that simplifies later changes
> > and helps finding duplicates.
> > 
> >> +
> >> +#define DEFAULT_TIMEOUT    10    /* seconds */
> >> +
> > 
> > Sure you want the default timeout to be that low ?
> 
> I'm not sure of anything actually, what is generally set ?
> 

30 seconds is quite common. I don't really mind 10 seconds, if that makes
sense for this platform, but in some cases it is a bit low.


> > 
> >> +#define GXBB_WDT_CTRL_REG            0x0
> >> +#define GXBB_WDT_CTRL1_REG            0x4
> >> +#define GXBB_WDT_TCNT_REG            0x8
> >> +#define GXBB_WDT_RSET_REG            0xc
> >> +
> >> +#define GXBB_WDT_CTRL_EE_RESET_NOW        BIT(26)
> >> +
> >> +#define GXBB_WDT_CTRL_CLKDIV_EN            BIT(25)
> >> +#define GXBB_WDT_CTRL_CLK_EN            BIT(24)
> >> +#define GXBB_WDT_CTRL_IRQ_EN            BIT(23)
> >> +#define GXBB_WDT_CTRL_EE_RESET            BIT(21)
> >> +#define GXBB_WDT_CTRL_XTAL_SEL            (0)
> >> +#define GXBB_WDT_CTRL_CLK81_SEL            BIT(19)
> >> +#define GXBB_WDT_CTRL_EN            BIT(18)
> >> +#define GXBB_WDT_CTRL_DIV_MASK            (BIT(18) - 1)
> >> +
> >> +#define GXBB_WDT_CTRL1_GPIO_PULSE        BIT(17)
> >> +#define GXBB_WDT_CTRL1_GPIO_POL_RESET_0        BIT(16)
> >> +#define GXBB_WDT_CTRL1_GPIO_POL_RESET_1        (0)
> >> +#define GXBB_WDT_CTRL1_GPIO_PULSE_CNT        (BIT(16) - 1)
> >> +
> >> +#define GXBB_WDT_TCNT_SETUP_MASK        (BIT(16) - 1)
> >> +#define GXBB_WDT_TCNT_CNT_SHIFT            16
> >> +
> >> +struct meson_gxbb_wdt {
> >> +    void __iomem *reg_base;
> >> +    struct watchdog_device wdt_dev;
> >> +    struct clk *clk;
> >> +};
> >> +
> >> +static int meson_gxbb_wdt_start(struct watchdog_device *wdt_dev)
> >> +{
> >> +    struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> >> +
> >> +    writel(readl(data->reg_base + GXBB_WDT_CTRL_REG) | GXBB_WDT_CTRL_EN,
> >> +        data->reg_base + GXBB_WDT_CTRL_REG);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int meson_gxbb_wdt_stop(struct watchdog_device *wdt_dev)
> >> +{
> >> +    struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> >> +
> >> +    writel(readl(data->reg_base + GXBB_WDT_CTRL_REG) & ~GXBB_WDT_CTRL_EN,
> >> +        data->reg_base + GXBB_WDT_CTRL_REG);
> > 
> > Please align continuation lines with '('.
> > 
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int meson_gxbb_wdt_ping(struct watchdog_device *wdt_dev)
> >> +{
> >> +    struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> >> +
> >> +    writel(0, data->reg_base + GXBB_WDT_RSET_REG);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int meson_gxbb_wdt_get_timeout(struct meson_gxbb_wdt *data)
> >> +{
> >> +    return (readl(data->reg_base + GXBB_WDT_TCNT_REG) &
> >> +            GXBB_WDT_TCNT_SETUP_MASK) / 1000;
> >> +}
> >> +
> > Unused function ?
> Crap, forgot to remove this.
> 
> > 
> >> +static int meson_gxbb_wdt_set_timeout(struct watchdog_device *wdt_dev,
> >> +                      unsigned int timeout)
> >> +{
> >> +    struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> >> +
> >> +    meson_gxbb_wdt_ping(wdt_dev);
> > 
> > Is this necessary ? The infrastructure calls it after calling this function.
> 
> Is it really safe to change the timeout value before calling ping ?
> 
> On the HW, there is a running counter that is reset to 0 when writing any value to the RSET register.
> A comparator triggers a reset when the counter is >= the timeout value.
> 
> If somehow we change to a lower value but the counter is > the new timeout value, it will reset the system.
> Calling ping right before would keep this safe.
> 
Ok.

> > 
> >> +
> >> +    writel(timeout * 1000, data->reg_base + GXBB_WDT_TCNT_REG);
> > 
> >     wdt_dev->timeout = timeout;
> > 
> > Also, timeout may be larger than the maximum supported by the hardware,
> > so you need to ensure that the value your write is not larger than
> > GXBB_WDT_TCNT_SETUP_MASK.
> 
> Isn't already checked by the watchdog-core ?
> 

Not anymore if the maximum hardware timeout is specified.

The difficulty in this case is that 'timeout' no longer reflects
the hardware timeout, but the logical timeout set from user space.
Maybe we can come up with a better mechanism (maybe two separate variables),
but for now drivers which set the maximum HW timeout have to check the
value range.

Thanks,
Guenter
