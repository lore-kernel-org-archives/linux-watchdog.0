Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:56445 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751359AbaEZSr7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 May 2014 14:47:59 -0400
Date: Mon, 26 May 2014 20:47:58 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: Fix SBC8360 dependencies
Message-ID: <20140526184758.GA21233@spo001.leaseweb.com>
References: <20140326160001.44271284@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140326160001.44271284@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jean,

> According to its Kconfig help text, the sbc8360 watchdog driver is
> only used on the Axiomtek SBC8360 single-board computer. This piece of
> hardware is 32-bit x86 so the driver is useless beyond X86_32.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
>  drivers/watchdog/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-3.14-rc7.orig/drivers/watchdog/Kconfig	2014-03-25 08:29:55.136283300 +0100
> +++ linux-3.14-rc7/drivers/watchdog/Kconfig	2014-03-26 15:56:35.549231692 +0100
> @@ -815,7 +815,7 @@ config 60XX_WDT
>  
>  config SBC8360_WDT
>  	tristate "SBC8360 Watchdog Timer"
> -	depends on X86
> +	depends on X86_32
>  	---help---
>  
>  	  This is the driver for the hardware watchdog on the SBC8360 Single

This was added 2 or 3 weeks ago to linux-watchdog-next.

Kind regards,
Wim.

