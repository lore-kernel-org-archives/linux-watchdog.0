Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47495 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbbG0NtN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 09:49:13 -0400
Message-ID: <55B636D4.6020709@roeck-us.net>
Date: Mon, 27 Jul 2015 06:49:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Matt Fleming <matt@codeblueprint.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk> <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
In-Reply-To: <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/27/2015 06:38 AM, Matt Fleming wrote:
> From: Matt Fleming <matt.fleming@intel.com>
>
> Intel Sunrisepoint (Skylake PCH) has the iTCO watchdog accessible across
> the SMBus, unlike previous generations of PCH/ICH where it was on the
> LPC bus. Because it's on the SMBus, it doesn't make sense to pass around
> a 'struct lpc_ich_info', and leaking the type of bus into the iTCO
> watchdog driver is kind of backwards anyway.
>
> This change introduces a new 'struct iTCO_wdt_platform_data' for use
> inside the iTCO watchdog driver and by the upcoming Intel Sunrisepoint
> code, which neatly avoids having to include lpc_ich headers in the i801
> i2c driver.
>
> A simple translation layer is provided for converting from the existing
> 'struct lpc_ich_info' inside the lpc_ich mfd driver.
>
> Cc: Peter Tyser <ptyser@xes-inc.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> ---
>   drivers/mfd/lpc_ich.c                  | 32 +++++++++++++++++++++++++++++---
>   drivers/watchdog/Kconfig               |  2 +-
>   drivers/watchdog/iTCO_wdt.c            | 11 +++++------
>   include/linux/mfd/lpc_ich.h            |  6 ------
>   include/linux/platform_data/iTCO_wdt.h | 18 ++++++++++++++++++
>   5 files changed, 53 insertions(+), 16 deletions(-)
>   create mode 100644 include/linux/platform_data/iTCO_wdt.h
>
> diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
> index 8de34398abc0..d190b74a6321 100644
> --- a/drivers/mfd/lpc_ich.c
> +++ b/drivers/mfd/lpc_ich.c
> @@ -66,6 +66,7 @@
>   #include <linux/pci.h>
>   #include <linux/mfd/core.h>
>   #include <linux/mfd/lpc_ich.h>
> +#include <linux/platform_data/iTCO_wdt.h>
>
>   #define ACPIBASE		0x40
>   #define ACPIBASE_GPE_OFF	0x28
> @@ -835,9 +836,31 @@ static void lpc_ich_enable_pmc_space(struct pci_dev *dev)
>   	priv->actrl_pbase_save = reg_save;
>   }
>
> -static void lpc_ich_finalize_cell(struct pci_dev *dev, struct mfd_cell *cell)
> +static int lpc_ich_finalize_wdt_cell(struct pci_dev *dev)
>   {
> +	struct iTCO_wdt_platform_data *pdata;
>   	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
> +	struct lpc_ich_info *info;
> +	struct mfd_cell *cell = &lpc_ich_cells[LPC_WDT];
> +
> +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +

I don't see the platform data freed anywhere, neither in the error path nor
in the cleanup path of this driver. Can you use devm_kzalloc() ?
Otherwise I think you'll need a cleanup path.

Guenter

