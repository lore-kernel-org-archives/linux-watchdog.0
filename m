Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44668 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391889AbeKWCjO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Nov 2018 21:39:14 -0500
Date: Thu, 22 Nov 2018 07:59:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: wim@linux-watchdog.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org
Subject: Re: [PATCH v2 1/3] watchdog: Add pm8916 watchdog driver
Message-ID: <20181122155915.GB27764@roeck-us.net>
References: <1542821264-9200-1-git-send-email-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542821264-9200-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 21, 2018 at 06:27:42PM +0100, Loic Poulain wrote:
> The PM816 module is a versatile PMIC with many diverse functions
> integrated, including, a watchdog.
> This watchdog is subcomponent of the PON (Power On) peripheral,
> in the same way as pwrkey/resin buttons.
> It works with two timers (2-stages), the first one generates an
> IRQ to the main SoC (APQ8016/MSM8916), the second one performs
> the reset.
> 
> This driver expects the following device hierarchy:
> [pm8916]->[pm8916-pon]->[pm8916-wdt]
> 
> It uses the pm8916 regmap to access PM8916 registers.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: SPDX license
>      headers ordering
>      coding styles / tabs / multi-line comments
>      pretimeout / bark interrupt
>      WDIOF_MAGICCLOSE flag
>      timeout init via fdt
>      devm usage
> 
>  drivers/watchdog/Kconfig      |   8 ++
>  drivers/watchdog/Makefile     |   1 +
>  drivers/watchdog/pm8916_wdt.c | 214 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 223 insertions(+)
>  create mode 100644 drivers/watchdog/pm8916_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 2d64333..ef2c2b5 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -847,6 +847,14 @@ config SPRD_WATCHDOG
>  	  Say Y here to include watchdog timer supported
>  	  by Spreadtrum system.
>  
> +config PM8916_WATCHDOG
> +	tristate "QCOM PM8916 pmic watchdog"
> +	depends on OF && MFD_SPMI_PMIC
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support watchdog timer embedded into the
> +	  pm8916 module.
> +
>  # X86 (i386 + ia64 + x86_64) Architecture
>  
>  config ACQUIRE_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f69cdff..cc90e72 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
>  obj-$(CONFIG_UNIPHIER_WATCHDOG) += uniphier_wdt.o
>  obj-$(CONFIG_RTD119X_WATCHDOG) += rtd119x_wdt.o
>  obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
> +obj-$(CONFIG_PM8916_WATCHDOG) += pm8916_wdt.o
>  
>  # X86 (i386 + ia64 + x86_64) Architecture
>  obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
> diff --git a/drivers/watchdog/pm8916_wdt.c b/drivers/watchdog/pm8916_wdt.c
> new file mode 100644
> index 0000000..25d1110
> --- /dev/null
> +++ b/drivers/watchdog/pm8916_wdt.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/watchdog.h>
> +
> +#define PON_INT_RT_STS			0x10
> +#define PMIC_WD_BARK_STS_BIT		BIT(6)
> +
> +#define PON_PMIC_WD_RESET_S1_TIMER	0x54
> +#define PON_PMIC_WD_RESET_S2_TIMER	0x55
> +
> +#define PON_PMIC_WD_RESET_S2_CTL	0x56
> +#define RESET_TYPE_WARM			0x01
> +#define RESET_TYPE_SHUTDOWN		0x04
> +#define RESET_TYPE_HARD			0x07
> +
> +#define PON_PMIC_WD_RESET_S2_CTL2	0x57
> +#define S2_RESET_EN_BIT			BIT(7)
> +
> +#define PON_PMIC_WD_RESET_PET		0x58
> +#define WATCHDOG_PET_BIT		BIT(0)
> +
> +#define PM8916_WDT_DEFAULT_TIMEOUT	32
> +#define PM8916_WDT_MIN_TIMEOUT		1
> +#define PM8916_WDT_MAX_TIMEOUT		127
> +
> +struct pm8916_wdt {
> +	struct device *dev;

Not used anywhere.

> +	struct regmap *regmap;
> +	struct watchdog_device wdev;
> +	u32 baseaddr;
> +	int irq;

Not used anywhere except for the probe function, and there it can be
kept internal.

Guenter
