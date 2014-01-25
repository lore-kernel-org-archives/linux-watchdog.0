Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25286 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbaAYUc7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 Jan 2014 15:32:59 -0500
Date: Sat, 25 Jan 2014 15:32:31 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 01/18] ARM: Introduce atomic MMIO modify
Message-ID: <20140125203231.GG29184@titan.lakedaemon.net>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-2-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390431915-5115-2-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Russell,

On Wed, Jan 22, 2014 at 08:04:58PM -0300, Ezequiel Garcia wrote:
> Some SoC have MMIO regions that are shared across orthogonal
> subsystems. This commit implements a possible solution for the
> thread-safe access of such regions through a spinlock-protected API.
> 
> Concurrent access is protected with a single spinlock for the
> entire MMIO address space. While this protects shared-registers,
> it also serializes access to unrelated/unshared registers.
> 
> We add relaxed and non-relaxed variants, by using writel_relaxed and writel,
> respectively. The rationale for this is that some users may not require
> register write completion but only thread-safe access to a register.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/include/asm/io.h |  6 ++++++
>  arch/arm/kernel/io.c      | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)

This has been in your patch tracker for a while:

  http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7930/1

When you requested Acks, we sent them:

  http://www.spinics.net/lists/arm-kernel/msg300250.html

Is there anything more you need from us?  The rest of this series
depends on this patch.  Could you place it in a topic branch so we can
base the rest of the series off of it?  Or, if you prefer, Ack it and
drop it from your patch tracker?  I'm fine either way.

thx,

Jason.

> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index fbeb39c..8aa4cca 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -38,6 +38,12 @@
>  #define isa_bus_to_virt phys_to_virt
>  
>  /*
> + * Atomic MMIO-wide IO modify
> + */
> +extern void atomic_io_modify(void __iomem *reg, u32 mask, u32 set);
> +extern void atomic_io_modify_relaxed(void __iomem *reg, u32 mask, u32 set);
> +
> +/*
>   * Generic IO read/write.  These perform native-endian accesses.  Note
>   * that some architectures will want to re-define __raw_{read,write}w.
>   */
> diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
> index dcd5b4d..9203cf8 100644
> --- a/arch/arm/kernel/io.c
> +++ b/arch/arm/kernel/io.c
> @@ -1,6 +1,41 @@
>  #include <linux/export.h>
>  #include <linux/types.h>
>  #include <linux/io.h>
> +#include <linux/spinlock.h>
> +
> +static DEFINE_RAW_SPINLOCK(__io_lock);
> +
> +/*
> + * Generic atomic MMIO modify.
> + *
> + * Allows thread-safe access to registers shared by unrelated subsystems.
> + * The access is protected by a single MMIO-wide lock.
> + */
> +void atomic_io_modify_relaxed(void __iomem *reg, u32 mask, u32 set)
> +{
> +	unsigned long flags;
> +	u32 value;
> +
> +	raw_spin_lock_irqsave(&__io_lock, flags);
> +	value = readl_relaxed(reg) & ~mask;
> +	value |= (set & mask);
> +	writel_relaxed(value, reg);
> +	raw_spin_unlock_irqrestore(&__io_lock, flags);
> +}
> +EXPORT_SYMBOL(atomic_io_modify_relaxed);
> +
> +void atomic_io_modify(void __iomem *reg, u32 mask, u32 set)
> +{
> +	unsigned long flags;
> +	u32 value;
> +
> +	raw_spin_lock_irqsave(&__io_lock, flags);
> +	value = readl_relaxed(reg) & ~mask;
> +	value |= (set & mask);
> +	writel(value, reg);
> +	raw_spin_unlock_irqrestore(&__io_lock, flags);
> +}
> +EXPORT_SYMBOL(atomic_io_modify);
>  
>  /*
>   * Copy data from IO memory space to "real" memory space.
> -- 
> 1.8.1.5
> 
