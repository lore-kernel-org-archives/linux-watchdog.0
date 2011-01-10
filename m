Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:63842 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753650Ab1AJNVR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Jan 2011 08:21:17 -0500
Date: Mon, 10 Jan 2011 14:21:15 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
Message-ID: <20110110132115.GM3801@infomag.iguana.be>
References: <1294656906-24239-1-git-send-email-jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1294656906-24239-1-git-send-email-jamie@jamieiles.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jamie,

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 8a3aa2f..0981aae 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -331,6 +331,15 @@ config IMX2_WDT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called imx2_wdt.
>  
> +config DW_WATCHDOG
> +	tristate "Synopsys DesignWare watchdog"
> +        select WATCHDOG_NOWAYOUT
> +	help
> +	  Say Y here if to include support for the Synopsys DesignWare
> +	  watchdog timer found in many ARM chips.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called dw_wdt.
> +
>  # AVR32 Architecture
>  
>  config AT32AP700X_WDT

Could you add the correct dependancy also in Kconfig?

Thanks in advance,
Wim.

