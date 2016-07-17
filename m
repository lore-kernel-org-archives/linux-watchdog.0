Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43764 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751188AbcGQUH3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:07:29 -0400
Date: Sun, 17 Jul 2016 22:07:26 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: drop redundant 'default n' option for WATCHDOG_SYSFS
Message-ID: <20160717200726.GH32751@spo001.leaseweb.nl>
References: <1465398975-11207-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465398975-11207-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Vladimir,

> The option 'default n' and its absence are equal for kbuild,
> which makes explicit 'default n' redundant.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  drivers/watchdog/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b54f26c..8d38cb8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -48,7 +48,6 @@ config WATCHDOG_NOWAYOUT
>  
>  config WATCHDOG_SYSFS
>  	bool "Read different watchdog information through sysfs"
> -	default n
>  	help
>  	  Say Y here if you want to enable watchdog device status read through
>  	  sysfs attributes.
> -- 
> 2.5.0
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

