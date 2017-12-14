Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34948 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbdLNOfz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 14 Dec 2017 09:35:55 -0500
Date: Thu, 14 Dec 2017 06:35:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: David Lechner <david@lechnology.com>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [2/2] ARM: davinci: remove watchdog reset
Message-ID: <20171214143553.GA22945@roeck-us.net>
References: <1513012869-7647-3-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513012869-7647-3-git-send-email-david@lechnology.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Dec 11, 2017 at 11:21:09AM -0600, David Lechner wrote:
> This removes the watchdog reset code. The reset has been moved to
> drivers/watchdog/davinci_wdt.c. The watchdog driver registers the reset
> with the kernel so defining a reset for each machine is no longer needed.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/mach-davinci/board-da830-evm.c     |  1 -
>  arch/arm/mach-davinci/board-da850-evm.c     |  1 -
>  arch/arm/mach-davinci/board-dm355-evm.c     |  1 -
>  arch/arm/mach-davinci/board-dm355-leopard.c |  1 -
>  arch/arm/mach-davinci/board-dm365-evm.c     |  1 -
>  arch/arm/mach-davinci/board-dm644x-evm.c    |  1 -
>  arch/arm/mach-davinci/board-dm646x-evm.c    |  2 -
>  arch/arm/mach-davinci/board-mityomapl138.c  |  1 -
>  arch/arm/mach-davinci/board-neuros-osd2.c   |  1 -
>  arch/arm/mach-davinci/board-omapl138-hawk.c |  1 -
>  arch/arm/mach-davinci/board-sffsdr.c        |  1 -
>  arch/arm/mach-davinci/clock.h               |  3 --
>  arch/arm/mach-davinci/da8xx-dt.c            |  1 -
>  arch/arm/mach-davinci/devices-da8xx.c       | 13 -------
>  arch/arm/mach-davinci/devices.c             |  7 +---
>  arch/arm/mach-davinci/include/mach/common.h |  1 -
>  arch/arm/mach-davinci/include/mach/da8xx.h  |  1 -
>  arch/arm/mach-davinci/time.c                | 57 -----------------------------
>  18 files changed, 1 insertion(+), 94 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index 2cc5426..7adf009 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -642,5 +642,4 @@ MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
>  	.init_machine	= da830_evm_init,
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
> -	.restart	= da8xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 458f26d..8602d0d 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -1485,6 +1485,5 @@ MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
>  	.init_machine	= da850_evm_init,
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
> -	.restart	= da8xx_restart,
>  	.reserve	= da8xx_rproc_reserve_cma,
>  MACHINE_END
> diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
> index 2b4d553..3c15cb7 100644
> --- a/arch/arm/mach-davinci/board-dm355-evm.c
> +++ b/arch/arm/mach-davinci/board-dm355-evm.c
> @@ -420,5 +420,4 @@ MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
>  	.init_machine = dm355_evm_init,
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
> -	.restart	= davinci_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
> index 69399d7..3ebc89d 100644
> --- a/arch/arm/mach-davinci/board-dm355-leopard.c
> +++ b/arch/arm/mach-davinci/board-dm355-leopard.c
> @@ -275,5 +275,4 @@ MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
>  	.init_machine = dm355_leopard_init,
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
> -	.restart	= davinci_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
> index e414cb9..3daeac7 100644
> --- a/arch/arm/mach-davinci/board-dm365-evm.c
> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
> @@ -778,6 +778,5 @@ MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
>  	.init_machine	= dm365_evm_init,
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
> -	.restart	= davinci_restart,
>  MACHINE_END
>  
> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
> index 6b26786..8d8c4ab 100644
> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> @@ -821,5 +821,4 @@ MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
>  	.init_machine = davinci_evm_init,
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
> -	.restart	= davinci_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> index b3b81a8..dafc852 100644
> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> @@ -804,7 +804,6 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
>  	.init_machine = evm_init,
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
> -	.restart	= davinci_restart,
>  MACHINE_END
>  
>  MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
> @@ -815,6 +814,5 @@ MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
>  	.init_machine = evm_init,
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
> -	.restart	= davinci_restart,
>  MACHINE_END
>  
> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> index c930c31..f9a725a 100644
> --- a/arch/arm/mach-davinci/board-mityomapl138.c
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -574,5 +574,4 @@ MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
>  	.init_machine	= mityomapl138_init,
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
> -	.restart	= da8xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
> index 925ada1..ff871a0 100644
> --- a/arch/arm/mach-davinci/board-neuros-osd2.c
> +++ b/arch/arm/mach-davinci/board-neuros-osd2.c
> @@ -231,5 +231,4 @@ MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
>  	.init_machine = davinci_ntosd2_init,
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
> -	.restart	= davinci_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index c1277b3..bc8a747 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -338,6 +338,5 @@ MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
>  	.init_machine	= omapl138_hawk_init,
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
> -	.restart	= da8xx_restart,
>  	.reserve	= da8xx_rproc_reserve_cma,
>  MACHINE_END
> diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
> index 4038de8..2922da9 100644
> --- a/arch/arm/mach-davinci/board-sffsdr.c
> +++ b/arch/arm/mach-davinci/board-sffsdr.c
> @@ -154,5 +154,4 @@ MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
>  	.init_machine = davinci_sffsdr_init,
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
> -	.restart	= davinci_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
> index aea4f14..a0b559e 100644
> --- a/arch/arm/mach-davinci/clock.h
> +++ b/arch/arm/mach-davinci/clock.h
> @@ -131,9 +131,6 @@ void davinci_clk_enable(struct davinci_clk *clk);
>  void davinci_clk_disable(struct davinci_clk *clk);
>  int davinci_clk_register(struct davinci_clk *clk);
>  
> -extern struct platform_device davinci_wdt_device;
> -extern void davinci_watchdog_reset(struct platform_device *);
> -
>  static inline struct davinci_clk *to_davinci_clk(struct clk_hw *hw)
>  {
>  	if (IS_ERR_OR_NULL(hw))
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index 3630f0a..ab199f4 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -100,7 +100,6 @@ DT_MACHINE_START(DA850_DT, "Generic DA850/OMAP-L138/AM18x")
>  	.init_machine	= da850_init_machine,
>  	.dt_compat	= da850_boards_compat,
>  	.init_late	= davinci_init_late,
> -	.restart	= da8xx_restart,
>  MACHINE_END
>  
>  #endif
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index 6724a8d..272e12e 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -371,19 +371,6 @@ static struct platform_device da8xx_wdt_device = {
>  	.resource	= da8xx_watchdog_resources,
>  };
>  
> -void da8xx_restart(enum reboot_mode mode, const char *cmd)
> -{
> -	struct device *dev;
> -
> -	dev = bus_find_device_by_name(&platform_bus_type, NULL, "davinci-wdt");
> -	if (!dev) {
> -		pr_err("%s: failed to find watchdog device\n", __func__);
> -		return;
> -	}
> -
> -	davinci_watchdog_reset(to_platform_device(dev));
> -}
> -
>  int __init da8xx_register_watchdog(void)
>  {
>  	return platform_device_register(&da8xx_wdt_device);
> diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
> index 3ae70f2..0edda40 100644
> --- a/arch/arm/mach-davinci/devices.c
> +++ b/arch/arm/mach-davinci/devices.c
> @@ -282,18 +282,13 @@ static struct resource wdt_resources[] = {
>  	},
>  };
>  
> -struct platform_device davinci_wdt_device = {
> +static struct platform_device davinci_wdt_device = {
>  	.name		= "davinci-wdt",
>  	.id		= -1,
>  	.num_resources	= ARRAY_SIZE(wdt_resources),
>  	.resource	= wdt_resources,
>  };
>  
> -void davinci_restart(enum reboot_mode mode, const char *cmd)
> -{
> -	davinci_watchdog_reset(&davinci_wdt_device);
> -}
> -
>  int davinci_init_wdt(void)
>  {
>  	return platform_device_register(&davinci_wdt_device);
> diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
> index 69a0ad9..f0d5e858 100644
> --- a/arch/arm/mach-davinci/include/mach/common.h
> +++ b/arch/arm/mach-davinci/include/mach/common.h
> @@ -80,7 +80,6 @@ extern struct davinci_soc_info davinci_soc_info;
>  
>  extern void davinci_common_init(const struct davinci_soc_info *soc_info);
>  extern void davinci_init_ide(void);
> -void davinci_restart(enum reboot_mode mode, const char *cmd);
>  void davinci_init_late(void);
>  
>  #ifdef CONFIG_DAVINCI_RESET_CLOCKS
> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
> index dd12e39..3481a0d 100644
> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
> @@ -121,7 +121,6 @@ int da850_register_vpif_display
>  			(struct vpif_display_config *display_config);
>  int da850_register_vpif_capture
>  			(struct vpif_capture_config *capture_config);
> -void da8xx_restart(enum reboot_mode mode, const char *cmd);
>  void da8xx_rproc_reserve_cma(void);
>  int da8xx_register_rproc(void);
>  int da850_register_gpio(void);
> diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
> index 034f865..1bb991a 100644
> --- a/arch/arm/mach-davinci/time.c
> +++ b/arch/arm/mach-davinci/time.c
> @@ -80,13 +80,6 @@ enum {
>  #define TGCR_UNRESET                 0x1
>  #define TGCR_RESET_MASK              0x3
>  
> -#define WDTCR_WDEN_SHIFT             14
> -#define WDTCR_WDEN_DISABLE           0x0
> -#define WDTCR_WDEN_ENABLE            0x1
> -#define WDTCR_WDKEY_SHIFT            16
> -#define WDTCR_WDKEY_SEQ0             0xa5c6
> -#define WDTCR_WDKEY_SEQ1             0xda7e
> -
>  struct timer_s {
>  	char *name;
>  	unsigned int id;
> @@ -409,53 +402,3 @@ void __init davinci_timer_init(void)
>  	for (i=0; i< ARRAY_SIZE(timers); i++)
>  		timer32_config(&timers[i]);
>  }
> -
> -/* reset board using watchdog timer */
> -void davinci_watchdog_reset(struct platform_device *pdev)
> -{
> -	u32 tgcr, wdtcr;
> -	void __iomem *base;
> -	struct clk *wd_clk;
> -
> -	base = ioremap(pdev->resource[0].start, SZ_4K);
> -	if (WARN_ON(!base))
> -		return;
> -
> -	wd_clk = clk_get(&pdev->dev, NULL);
> -	if (WARN_ON(IS_ERR(wd_clk)))
> -		return;
> -	clk_prepare_enable(wd_clk);
> -
> -	/* disable, internal clock source */
> -	__raw_writel(0, base + TCR);
> -
> -	/* reset timer, set mode to 64-bit watchdog, and unreset */
> -	tgcr = 0;
> -	__raw_writel(tgcr, base + TGCR);
> -	tgcr = TGCR_TIMMODE_64BIT_WDOG << TGCR_TIMMODE_SHIFT;
> -	tgcr |= (TGCR_UNRESET << TGCR_TIM12RS_SHIFT) |
> -		(TGCR_UNRESET << TGCR_TIM34RS_SHIFT);
> -	__raw_writel(tgcr, base + TGCR);
> -
> -	/* clear counter and period regs */
> -	__raw_writel(0, base + TIM12);
> -	__raw_writel(0, base + TIM34);
> -	__raw_writel(0, base + PRD12);
> -	__raw_writel(0, base + PRD34);
> -
> -	/* put watchdog in pre-active state */
> -	wdtcr = __raw_readl(base + WDTCR);
> -	wdtcr = (WDTCR_WDKEY_SEQ0 << WDTCR_WDKEY_SHIFT) |
> -		(WDTCR_WDEN_ENABLE << WDTCR_WDEN_SHIFT);
> -	__raw_writel(wdtcr, base + WDTCR);
> -
> -	/* put watchdog in active state */
> -	wdtcr = (WDTCR_WDKEY_SEQ1 << WDTCR_WDKEY_SHIFT) |
> -		(WDTCR_WDEN_ENABLE << WDTCR_WDEN_SHIFT);
> -	__raw_writel(wdtcr, base + WDTCR);
> -
> -	/* write an invalid value to the WDKEY field to trigger
> -	 * a watchdog reset */
> -	wdtcr = 0x00004000;
> -	__raw_writel(wdtcr, base + WDTCR);
> -}
