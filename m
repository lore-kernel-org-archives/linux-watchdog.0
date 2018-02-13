Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42111 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965158AbeBMSEd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Feb 2018 13:04:33 -0500
Date: Tue, 13 Feb 2018 10:04:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 07/11] watchdog/hpwdt: Select WATCHDOG_CORE
Message-ID: <20180213180430.GB19405@roeck-us.net>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-8-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212052111.12010-8-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Feb 11, 2018 at 10:21:07PM -0700, Jerry Hoemann wrote:
> Update Kconfig file to show that hpwdt now selects WATCHDOG_CORE.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Please merge with previous patch to preserve bisectability.

> ---
>  drivers/watchdog/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 6a602f70aaa4..4d219c3fa8b4 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1108,6 +1108,7 @@ config IT87_WDT
>  
>  config HP_WATCHDOG
>  	tristate "HP ProLiant iLO2+ Hardware Watchdog Timer"
> +	select WATCHDOG_CORE
>  	depends on X86 && PCI
>  	help
>  	  A software monitoring watchdog and NMI sourcing driver. This driver
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
