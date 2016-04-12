Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45316 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757028AbcDLNGR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Apr 2016 09:06:17 -0400
Subject: Re: [PATCH] watchdog: dw_wdt: dont build for avr32
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Haavard Skinnemoen <hskinnemoen@gmail.com>,
	Hans-Christian Egtvedt <egtvedt@samfundet.no>
References: <1460440303-20640-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <570CF2CB.2050200@roeck-us.net>
Date: Tue, 12 Apr 2016 06:06:19 -0700
MIME-Version: 1.0
In-Reply-To: <1460440303-20640-1-git-send-email-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/11/2016 10:51 PM, Sudip Mukherjee wrote:
> The build of avr32 allmodconfig fails with the error:
> ERROR: "__avr32_udiv64" [drivers/watchdog/kempld_wdt.ko] undefined!
>
This means there is a direct 64 bit divide operation in the driver,
which we should identify and fix.

Guenter

> Exclude this driver from the build of avr32.
>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>
> avr32 build log is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/122158665
>
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index fb94765..61041ba 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -981,7 +981,7 @@ config HP_WATCHDOG
>
>   config KEMPLD_WDT
>   	tristate "Kontron COM Watchdog Timer"
> -	depends on MFD_KEMPLD
> +	depends on MFD_KEMPLD && !AVR32
>   	select WATCHDOG_CORE
>   	help
>   	  Support for the PLD watchdog on some Kontron ETX and COMexpress
>

