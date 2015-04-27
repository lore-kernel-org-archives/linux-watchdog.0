Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40383 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932964AbbD0S3E (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Apr 2015 14:29:04 -0400
Date: Mon, 27 Apr 2015 19:28:56 +0100
From: Lee Jones <lee@kernel.org>
To: Eric Anholt <eric@anholt.net>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to
 the WDT driver.
Message-ID: <20150427182856.GE11956@x1>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
 <1429902534-2348-2-git-send-email-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1429902534-2348-2-git-send-email-eric@anholt.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 24 Apr 2015, Eric Anholt wrote:
> Since the WDT is what's used to drive restart and power off, it makes
> more sense to keep it there, where the regs are already mapped and
> definitions for them provided.  Note that this means you may need to
> add CONFIG_BCM2835_WDT to retain functionality of your kernel.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: linux-watchdog@vger.kernel.org
> ---
> 
> Note that power off has never worked for me, and just reboots as well.
> So I can't say that I've *really* tested the power off code.
> 
>  arch/arm/mach-bcm/board_bcm2835.c | 73 ---------------------------------------
>  drivers/watchdog/bcm2835_wdt.c    | 62 +++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 73 deletions(-)

Please rebase and resend, just this patch, as requested by Guenter.

I'm going to take the other patch.

> diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_bcm2835.c
> index 49dd5b0..0f7b9ea 100644
> --- a/arch/arm/mach-bcm/board_bcm2835.c
> +++ b/arch/arm/mach-bcm/board_bcm2835.c
> @@ -12,7 +12,6 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/irqchip.h>
>  #include <linux/of_address.h>
> @@ -22,81 +21,10 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  
> -#define PM_RSTC				0x1c
> -#define PM_RSTS				0x20
> -#define PM_WDOG				0x24
> -
> -#define PM_PASSWORD			0x5a000000
> -#define PM_RSTC_WRCFG_MASK		0x00000030
> -#define PM_RSTC_WRCFG_FULL_RESET	0x00000020
> -#define PM_RSTS_HADWRH_SET		0x00000040
> -
> -static void __iomem *wdt_regs;
> -
> -/*
> - * The machine restart method can be called from an atomic context so we won't
> - * be able to ioremap the regs then.
> - */
> -static void bcm2835_setup_restart(void)
> -{
> -	struct device_node *np = of_find_compatible_node(NULL, NULL,
> -						"brcm,bcm2835-pm-wdt");
> -	if (WARN(!np, "unable to setup watchdog restart"))
> -		return;
> -
> -	wdt_regs = of_iomap(np, 0);
> -	WARN(!wdt_regs, "failed to remap watchdog regs");
> -}
> -
> -static void bcm2835_restart(enum reboot_mode mode, const char *cmd)
> -{
> -	u32 val;
> -
> -	if (!wdt_regs)
> -		return;
> -
> -	/* use a timeout of 10 ticks (~150us) */
> -	writel_relaxed(10 | PM_PASSWORD, wdt_regs + PM_WDOG);
> -	val = readl_relaxed(wdt_regs + PM_RSTC);
> -	val &= ~PM_RSTC_WRCFG_MASK;
> -	val |= PM_PASSWORD | PM_RSTC_WRCFG_FULL_RESET;
> -	writel_relaxed(val, wdt_regs + PM_RSTC);
> -
> -	/* No sleeping, possibly atomic. */
> -	mdelay(1);
> -}
> -
> -/*
> - * We can't really power off, but if we do the normal reset scheme, and
> - * indicate to bootcode.bin not to reboot, then most of the chip will be
> - * powered off.
> - */
> -static void bcm2835_power_off(void)
> -{
> -	u32 val;
> -
> -	/*
> -	 * We set the watchdog hard reset bit here to distinguish this reset
> -	 * from the normal (full) reset. bootcode.bin will not reboot after a
> -	 * hard reset.
> -	 */
> -	val = readl_relaxed(wdt_regs + PM_RSTS);
> -	val &= ~PM_RSTC_WRCFG_MASK;
> -	val |= PM_PASSWORD | PM_RSTS_HADWRH_SET;
> -	writel_relaxed(val, wdt_regs + PM_RSTS);
> -
> -	/* Continue with normal reset mechanism */
> -	bcm2835_restart(REBOOT_HARD, "");
> -}
> -
>  static void __init bcm2835_init(void)
>  {
>  	int ret;
>  
> -	bcm2835_setup_restart();
> -	if (wdt_regs)
> -		pm_power_off = bcm2835_power_off;
> -
>  	bcm2835_init_clocks();
>  
>  	ret = of_platform_populate(NULL, of_default_bus_match_table, NULL,
> @@ -114,6 +42,5 @@ static const char * const bcm2835_compat[] = {
>  
>  DT_MACHINE_START(BCM2835, "BCM2835")
>  	.init_machine = bcm2835_init,
> -	.restart = bcm2835_restart,
>  	.dt_compat = bcm2835_compat
>  MACHINE_END
> diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
> index 2b5a9bb..7116968 100644
> --- a/drivers/watchdog/bcm2835_wdt.c
> +++ b/drivers/watchdog/bcm2835_wdt.c
> @@ -13,20 +13,25 @@
>   * option) any later version.
>   */
>  
> +#include <linux/delay.h>
> +#include <linux/reboot.h>
>  #include <linux/types.h>
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/watchdog.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_address.h>
> +#include <linux/of_platform.h>
>  
>  #define PM_RSTC				0x1c
> +#define PM_RSTS				0x20
>  #define PM_WDOG				0x24
>  
>  #define PM_PASSWORD			0x5a000000
>  
>  #define PM_WDOG_TIME_SET		0x000fffff
>  #define PM_RSTC_WRCFG_CLR		0xffffffcf
> +#define PM_RSTS_HADWRH_SET		0x00000040
>  #define PM_RSTC_WRCFG_SET		0x00000030
>  #define PM_RSTC_WRCFG_FULL_RESET	0x00000020
>  #define PM_RSTC_RESET			0x00000102
> @@ -37,6 +42,7 @@
>  struct bcm2835_wdt {
>  	void __iomem		*base;
>  	spinlock_t		lock;
> +	struct notifier_block	restart_handler;
>  };
>  
>  static unsigned int heartbeat;
> @@ -106,6 +112,53 @@ static struct watchdog_device bcm2835_wdt_wdd = {
>  	.timeout =	WDOG_TICKS_TO_SECS(PM_WDOG_TIME_SET),
>  };
>  
> +static int
> +bcm2835_restart(struct notifier_block *this, unsigned long mode, void *cmd)
> +{
> +	struct bcm2835_wdt *wdt = container_of(this, struct bcm2835_wdt,
> +					       restart_handler);
> +	u32 val;
> +
> +	/* use a timeout of 10 ticks (~150us) */
> +	writel_relaxed(10 | PM_PASSWORD, wdt->base + PM_WDOG);
> +	val = readl_relaxed(wdt->base + PM_RSTC);
> +	val &= PM_RSTC_WRCFG_CLR;
> +	val |= PM_PASSWORD | PM_RSTC_WRCFG_FULL_RESET;
> +	writel_relaxed(val, wdt->base + PM_RSTC);
> +
> +	/* No sleeping, possibly atomic. */
> +	mdelay(1);
> +
> +	return 0;
> +}
> +
> +/*
> + * We can't really power off, but if we do the normal reset scheme, and
> + * indicate to bootcode.bin not to reboot, then most of the chip will be
> + * powered off.
> + */
> +static void bcm2835_power_off(void)
> +{
> +	struct device_node *np =
> +		of_find_compatible_node(NULL, NULL, "brcm,bcm2835-pm-wdt");
> +	struct platform_device *pdev = of_find_device_by_node(np);
> +	struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
> +	u32 val;
> +
> +	/*
> +	 * We set the watchdog hard reset bit here to distinguish this reset
> +	 * from the normal (full) reset. bootcode.bin will not reboot after a
> +	 * hard reset.
> +	 */
> +	val = readl_relaxed(wdt->base + PM_RSTS);
> +	val &= PM_RSTC_WRCFG_CLR;
> +	val |= PM_PASSWORD | PM_RSTS_HADWRH_SET;
> +	writel_relaxed(val, wdt->base + PM_RSTS);
> +
> +	/* Continue with normal reset mechanism */
> +	bcm2835_restart(&wdt->restart_handler, REBOOT_HARD, NULL);
> +}
> +
>  static int bcm2835_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -136,6 +189,12 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> +	wdt->restart_handler.notifier_call = bcm2835_restart;
> +	wdt->restart_handler.priority = 128;
> +	register_restart_handler(&wdt->restart_handler);
> +	if (pm_power_off == NULL)
> +		pm_power_off = bcm2835_power_off;
> +
>  	dev_info(dev, "Broadcom BCM2835 watchdog timer");
>  	return 0;
>  }
> @@ -144,6 +203,9 @@ static int bcm2835_wdt_remove(struct platform_device *pdev)
>  {
>  	struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
>  
> +	unregister_restart_handler(&wdt->restart_handler);
> +	if (pm_power_off == bcm2835_power_off)
> +		pm_power_off = NULL;
>  	watchdog_unregister_device(&bcm2835_wdt_wdd);
>  	iounmap(wdt->base);
>  
