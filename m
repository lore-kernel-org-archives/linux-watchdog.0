Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36515 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407235AbeKTDhc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Nov 2018 22:37:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so8326318pfc.3
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Nov 2018 09:13:13 -0800 (PST)
Date: Mon, 19 Nov 2018 09:13:11 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH] watchdog: w83627hf_wdt: Add quirk for Inves system
Message-ID: <20181119171311.GB27435@roeck-us.net>
References: <20181119091738.0fc4dad6@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119091738.0fc4dad6@endymion>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Nov 19, 2018 at 09:17:38AM +0100, Jean Delvare wrote:
> On some systems, the NCT6791D comes with a companion chip and the
> watchdog function is in this companion chip. We must use a different
> unlocking sequence to access the companion chip.
> 
> Use DMI strings to identify such system and adjust the unlocking
> sequence automatically.
> 
Ouch.

> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/w83627hf_wdt.c |   38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> --- linux-4.20-rc2.orig/drivers/watchdog/w83627hf_wdt.c	2018-11-16 15:49:26.189851240 +0100
> +++ linux-4.20-rc2/drivers/watchdog/w83627hf_wdt.c	2018-11-16 15:50:04.779339701 +0100
> @@ -38,6 +38,7 @@
>  #include <linux/ioport.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/dmi.h>
>  
>  #define WATCHDOG_NAME "w83627hf/thf/hg/dhg WDT"
>  #define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
> @@ -46,6 +47,8 @@ static int wdt_io;
>  static int cr_wdt_timeout;	/* WDT timeout register */
>  static int cr_wdt_control;	/* WDT control register */
>  static int cr_wdt_csr;		/* WDT control & status register */
> +static int wdt_cfg_enter = 0x87;/* key to unlock configuration space */
> +static int wdt_cfg_leave = 0xAA;/* key to lock configuration space */
>  
>  enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
>  	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
> @@ -130,8 +133,8 @@ static int superio_enter(void)
>  	if (!request_muxed_region(wdt_io, 2, WATCHDOG_NAME))
>  		return -EBUSY;
>  
> -	outb_p(0x87, WDT_EFER); /* Enter extended function mode */
> -	outb_p(0x87, WDT_EFER); /* Again according to manual */
> +	outb_p(wdt_cfg_enter, WDT_EFER); /* Enter extended function mode */
> +	outb_p(wdt_cfg_enter, WDT_EFER); /* Again according to manual */
>  
>  	return 0;
>  }
> @@ -143,7 +146,7 @@ static void superio_select(int ld)
>  
>  static void superio_exit(void)
>  {
> -	outb_p(0xAA, WDT_EFER); /* Leave extended function mode */
> +	outb_p(wdt_cfg_leave, WDT_EFER); /* Leave extended function mode */
>  	release_region(wdt_io, 2);
>  }
>  
> @@ -430,6 +433,32 @@ static int wdt_find(int addr)
>  	return ret;
>  }
>  
> +/*
> + * On some systems, the NCT6791D comes with a companion chip and the
> + * watchdog function is in this companion chip. We must use a different
> + * unlocking sequence to access the companion chip.
> + */
> +static int __init wdt_use_alt_key(const struct dmi_system_id *d)
> +{
> +	wdt_cfg_enter = 0x88;
> +	wdt_cfg_leave = 0xBB;
> +
> +	return 0;
> +}
> +
> +static const struct dmi_system_id wdt_dmi_table[] __initconst = {
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "INVES"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CTS"),
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "INVES"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SHARKBAY"),
> +		},
> +		.callback = wdt_use_alt_key,
> +	},
> +	{}
> +};
> +
>  static int __init wdt_init(void)
>  {
>  	int ret;
> @@ -459,6 +488,9 @@ static int __init wdt_init(void)
>  		"NCT6102",
>  	};
>  
> +	/* Apply system-specific quirks */
> +	dmi_check_system(wdt_dmi_table);
> +
>  	wdt_io = 0x2e;
>  	chip = wdt_find(0x2e);
>  	if (chip < 0) {
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
