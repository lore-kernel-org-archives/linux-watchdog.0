Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:56622 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752624AbbC0ICp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Mar 2015 04:02:45 -0400
Date: Fri, 27 Mar 2015 09:02:43 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu,
	Zach Pfeffer <zachp@xilinx.com>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: cadence: Remove Kconfig dependency on ARCH
Message-ID: <20150327080243.GE24918@spo001.leaseweb.nl>
References: <491e97be16decb4901fa2b0be4b530774501b5c1.1425891008.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <491e97be16decb4901fa2b0be4b530774501b5c1.1425891008.git.michal.simek@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Michal,

> Remove Kconfig dependency and enable driver for
> all ARCHs.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Test for all archs done by Kbuild test robot without any problem.
> ---
>  drivers/watchdog/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 16f202350997..6442412377a4 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -169,7 +169,6 @@ config AT91SAM9X_WATCHDOG
>  
>  config CADENCE_WATCHDOG
>  	tristate "Cadence Watchdog Timer"
> -	depends on ARM
>  	select WATCHDOG_CORE
>  	help
>  	  Say Y here if you want to include support for the watchdog

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

