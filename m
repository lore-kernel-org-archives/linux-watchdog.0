Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56327 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760317AbcCDXSJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Mar 2016 18:18:09 -0500
Date: Fri, 4 Mar 2016 15:18:07 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	manabian@gmail.com, linux-watchdog@vger.kernel.org, wim@iguana.be,
	stigge@antcom.de, vz@mleia.com
Subject: Re: [PATCH v7 5/6] arm: lpc32xx: phy3250 remove restart hook
Message-ID: <20160304231807.GB31027@roeck-us.net>
References: <1457117050-13543-1-git-send-email-slemieux.tyco@gmail.com>
 <1457117050-13543-6-git-send-email-slemieux.tyco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457117050-13543-6-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 04, 2016 at 01:44:09PM -0500, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> Remove the restart hook assignment from phy3250;
> this functionality is now managed by
> the pnx4008 watchdog driver.
> 
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Note:
> This patch was generated with the option "--unified=2" to ensure
> it can be apply before or after the changes for the new 
> LPC32xx irqchip driver:
> - http://permalink.gmane.org/gmane.linux.drivers.devicetree/144683
> 
> Changes from v6 to v7:
> - none.
> 
> Changes from v5 to v6:
> - none.
> 
> Changes from v4 to v5:
> - none.
> 
> Changes from v3 to v4:
> - Switch patch #5 and #6 order.
> 
> Changes from v2 to v3:
> - new patch in v3.
> 
>  arch/arm/mach-lpc32xx/phy3250.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
> index a19071a..9e5c3db 100644
> --- a/arch/arm/mach-lpc32xx/phy3250.c
> +++ b/arch/arm/mach-lpc32xx/phy3250.c
> @@ -211,4 +211,3 @@ DT_MACHINE_START(LPC32XX_DT, "LPC32XX SoC (Flattened Device Tree)")
>  	.init_machine	= lpc3250_machine_init,
>  	.dt_compat	= lpc32xx_dt_compat,
> -	.restart	= lpc23xx_restart,
>  MACHINE_END
> -- 
> 1.8.3.1
> 
