Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44744 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeAPDJb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 15 Jan 2018 22:09:31 -0500
Date: Mon, 15 Jan 2018 19:09:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Hogan <jhogan@kernel.org>
Subject: Re: watchdog: indydog: Drop test builds
Message-ID: <20180116030929.GA14616@roeck-us.net>
References: <1516071950-14207-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516071950-14207-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 15, 2018 at 07:05:50PM -0800, Guenter Roeck wrote:
> Due to changes in MIPS default configuration, mips:allmodconfig fails
> to build with the following error.
> 
> ERROR: "sgimc" [drivers/watchdog/indydog.ko] undefined!
> scripts/Makefile.modpost:92: recipe for target '__modpost' failed
> 
> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Never mind. This is already queued in watchdog-next. Sorry for the noise.

Guenter

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index ca200d1f310a..5a606a4aee6a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1451,7 +1451,7 @@ config RC32434_WDT
>  
>  config INDYDOG
>  	tristate "Indy/I2 Hardware Watchdog"
> -	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST)
> +	depends on SGI_HAS_INDYDOG
>  	help
>  	  Hardware driver for the Indy's/I2's watchdog. This is a
>  	  watchdog timer that will reboot the machine after a 60 second
