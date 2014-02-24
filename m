Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59390 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752655AbaBXUdy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Feb 2014 15:33:54 -0500
Date: Mon, 24 Feb 2014 21:33:52 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: olof@lixom.net, festevam@gmail.com, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: orion_wdt: Use %pa to print 'phys_addr_t'
Message-ID: <20140224203352.GA21204@spo001.leaseweb.com>
References: <1392726234-16977-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1392726234-16977-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

> When building an ARM multi_v7_defconfig with LPAE option selected we get the
> following build warning:
> 
> drivers/watchdog/orion_wdt.c:272:2: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'phys_addr_t' [-Wformat=]
> 
> Fix it by using %pa to print 'phys_addr_t'.
> 
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/watchdog/orion_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 15321aa..6f9b4c6 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -269,7 +269,7 @@ static void __iomem *orion_wdt_ioremap_rstout(struct platform_device *pdev,
>  
>  	rstout = internal_regs + ORION_RSTOUT_MASK_OFFSET;
>  
> -	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg 0x%x\n", rstout);
> +	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg %pa\n", &rstout);
>  	return devm_ioremap(&pdev->dev, rstout, 0x4);
>  }
>  
> -- 
> 1.8.1.2
> 
> 

Acked-by me also, but can this also go via the mvebu tree (since the patch that introduces this is also thereà?

Kind regards,
Wim.

