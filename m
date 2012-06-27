Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58342 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757738Ab2F0S3U (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 27 Jun 2012 14:29:20 -0400
Date: Wed, 27 Jun 2012 14:28:47 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: sylver.bruneau@googlemail.com, axel.lin@gmail.com,
	linux-watchdog@vger.kernel.org,
	linux ARM <linux-arm-kernel@lists.infradead.org>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH] ARM: Orion: Fix Virtual/Physical mixup with watchdog
Message-ID: <20120627182847.GD3112@titan.lakedaemon.net>
References: <1340028906-19262-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1340028906-19262-1-git-send-email-andrew@lunn.ch>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jun 18, 2012 at 04:15:06PM +0200, Andrew Lunn wrote:
> The orion watchdog is expecting to be passed the physcial address of
> the hardware, and will ioremap() it to give a virtual address it will
> use as the base address for the hardware. However, when creating the
> platform resource record, a virtual address was being used.
> 
> Add the necassary #define's so we can pass the physical address as
> expected.
> 
> Tested on Kirkwood and Orion5x.
> 
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Jason Cooper <jason@lakedaemon.net>

> ---
>  arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    1 +
>  arch/arm/mach-kirkwood/include/mach/kirkwood.h    |    1 +
>  arch/arm/mach-orion5x/include/mach/bridge-regs.h  |    2 +-
>  arch/arm/mach-orion5x/include/mach/orion5x.h      |    1 +
>  arch/arm/plat-orion/common.c                      |    2 +-
>  5 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
> index 3eee37a..a115142 100644
> --- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
> +++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
> @@ -38,6 +38,7 @@
>  #define IRQ_MASK_HIGH_OFF	0x0014
>  
>  #define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0300)
> +#define TIMER_PHYS_BASE		(BRIDGE_PHYS_BASE | 0x0300)
>  
>  #define L2_CONFIG_REG		(BRIDGE_VIRT_BASE | 0x0128)
>  #define L2_WRITETHROUGH		0x00000010
> diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
> index fede3d5..c5b6851 100644
> --- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
> +++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
> @@ -80,6 +80,7 @@
>  #define  UART1_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x2100)
>  
>  #define BRIDGE_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE | 0x20000)
> +#define BRIDGE_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE | 0x20000)
>  
>  #define CRYPTO_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE | 0x30000)
>  
> diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
> index 96484bc..11a3c1e 100644
> --- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
> +++ b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
> @@ -35,5 +35,5 @@
>  #define MAIN_IRQ_MASK		(ORION5X_BRIDGE_VIRT_BASE | 0x204)
>  
>  #define TIMER_VIRT_BASE		(ORION5X_BRIDGE_VIRT_BASE | 0x300)
> -
> +#define TIMER_PHYS_BASE		(ORION5X_BRIDGE_PHYS_BASE | 0x300)
>  #endif
> diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/include/mach/orion5x.h
> index 2745f5d..683e085 100644
> --- a/arch/arm/mach-orion5x/include/mach/orion5x.h
> +++ b/arch/arm/mach-orion5x/include/mach/orion5x.h
> @@ -82,6 +82,7 @@
>  #define  UART1_VIRT_BASE		(ORION5X_DEV_BUS_VIRT_BASE | 0x2100)
>  
>  #define ORION5X_BRIDGE_VIRT_BASE	(ORION5X_REGS_VIRT_BASE | 0x20000)
> +#define ORION5X_BRIDGE_PHYS_BASE	(ORION5X_REGS_PHYS_BASE | 0x20000)
>  
>  #define ORION5X_PCI_VIRT_BASE		(ORION5X_REGS_VIRT_BASE | 0x30000)
>  
> diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
> index 61fd837..c179378 100644
> --- a/arch/arm/plat-orion/common.c
> +++ b/arch/arm/plat-orion/common.c
> @@ -582,7 +582,7 @@ void __init orion_spi_1_init(unsigned long mapbase)
>   * Watchdog
>   ****************************************************************************/
>  static struct resource orion_wdt_resource =
> -		DEFINE_RES_MEM(TIMER_VIRT_BASE, 0x28);
> +		DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x28);
>  
>  static struct platform_device orion_wdt_device = {
>  	.name		= "orion_wdt",
> -- 
> 1.7.10
> 
