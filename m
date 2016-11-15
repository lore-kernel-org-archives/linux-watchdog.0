Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57854 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932756AbcKOOJS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Nov 2016 09:09:18 -0500
Subject: Re: [PATCH 1/2] Watchdog: omap_wdt: Retrieve bootstatus via syscon
To: Cor Peters <cpeters@victronenergy.com>, linux-omap@vger.kernel.org
References: <2736782.ivGPcGWbll@corpeters>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <bb5ceb32-80a7-2caa-ea70-26a24100b769@roeck-us.net>
Date: Tue, 15 Nov 2016 06:09:16 -0800
MIME-Version: 1.0
In-Reply-To: <2736782.ivGPcGWbll@corpeters>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/15/2016 12:44 AM, Cor Peters wrote:
> The current way to retrieve the bootstatus does not work with
> device-tree based systems. This patch uses syscon to retrieve the
> watchdog boot status from the PRM_DEV registers.
>
> Signed-off-by: Cor Peters <cpeters@victronenergy.com>

For the subject: Patch 2/2 seems to be missing (or I wasn't copied).

> ---
>  drivers/watchdog/omap_wdt.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 1b02bfa..fed3f9c 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -41,6 +41,8 @@
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_data/omap-wd-timer.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
>
>  #include "omap_wdt.h"
>
> @@ -230,9 +232,11 @@ static unsigned int omap_wdt_get_timeleft(struct watchdog_device *wdog)
>  static int omap_wdt_probe(struct platform_device *pdev)
>  {
>         struct omap_wd_timer_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +       struct regmap *rm = syscon_regmap_lookup_by_compatible("ti,omap3-prcm-dev");
>         struct resource *res;
>         struct omap_wdt_dev *wdev;
>         int ret;
> +       u32 rs = 0;
>
>         wdev = devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
>         if (!wdev)
> @@ -267,9 +271,17 @@ static int omap_wdt_probe(struct platform_device *pdev)
>
>         if (pdata && pdata->read_reset_sources) {
>                 u32 rs = pdata->read_reset_sources();

You are still declaring rs here, meaning the new instance of rs is hidden.

> -               if (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT))
> -                       wdev->wdog.bootstatus = WDIOF_CARDRESET;
>         }
> +       else if (!IS_ERR(rm)) {
> +               if (regmap_read(rm, 2 * sizeof(u32), &rs) >= 0) {

Can you use a define instead of "2 * sizeof(u32)" here ? If the register is 0x0008
it should be defined as 0x0008; the register address does not depend on the size
of an u32.

> +                       /* reset register */
> +                       regmap_write(rm, 2 * sizeof(u32),
> +                               (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT) );

extra space between '')'.

Why reset this register ? That isn't done for the non-DT case.

Also, unless I misunderstand the code, OMAP_MPU_WD_RST_SRC_ID_SHIFT is a
standardized "soft" value and does not reflect the physical reset bit in
the SoC. I don't think you can just use that value and assume that it
is the correct register bit to use.

Guenter

