Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40248 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932761AbcAYQl6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Jan 2016 11:41:58 -0500
Subject: Re: [PATCH] watchdog: imgdpc: select WATCHDOG_CORE
To: Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>
References: <1453737991-1960626-1-git-send-email-arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	James Hogan <james.hogan@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	Naidu Tellapati <naidu.tellapati@gmail.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A65050.5010708@roeck-us.net>
Date: Mon, 25 Jan 2016 08:41:52 -0800
MIME-Version: 1.0
In-Reply-To: <1453737991-1960626-1-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/25/2016 08:06 AM, Arnd Bergmann wrote:
> The imgpdc_wdt driver can be built on all architectures with
> CONFIG_COMPILE_TEST, but fails if no other watchdog driver is
> enabled:
>
> drivers/watchdog/built-in.o: In function `pdc_wdt_remove':
> imgpdc_wdt.c:(.text+0x74): undefined reference to `watchdog_unregister_device'
>
> This adds the normal 'select WATCHDOG_CORE' that is needed to
> ensure the driver always builds cleanly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 4f0e7be0da34..0dc61f1a552e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1383,6 +1383,7 @@ config IMGPDC_WDT
>   	tristate "Imagination Technologies PDC Watchdog Timer"
>   	depends on HAS_IOMEM
>   	depends on METAG || MIPS || COMPILE_TEST
> +	select WATCHDOG_CORE
>   	help
>   	  Driver for Imagination Technologies PowerDown Controller
>   	  Watchdog Timer.
>

