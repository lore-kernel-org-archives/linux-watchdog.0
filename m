Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58454 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbcBXPbE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Feb 2016 10:31:04 -0500
Subject: Re: [PATCH v2] watchdog: Add hardware dependency to BCM7038 driver
To: Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org
References: <20160224161726.4888edd4@endymion>
Cc: Justin Chen <justinpopo6@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56CDCCB1.3050605@roeck-us.net>
Date: Wed, 24 Feb 2016 07:30:57 -0800
MIME-Version: 1.0
In-Reply-To: <20160224161726.4888edd4@endymion>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/24/2016 07:17 AM, Jean Delvare wrote:
> The BCM7038 watchdog driver is specific to Broadcom ARM and MIPS
> SoCs so do not present it on other architectures, unless
> build-testing.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Justin Chen <justinpopo6@gmail.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v1:
>   * Better dependencies, suggested by Justin, and updated the
>     description accordingly.
>   * Better option description, provided by Justin.
>
>   drivers/watchdog/Kconfig |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> --- linux-4.5-rc5.orig/drivers/watchdog/Kconfig	2016-02-24 14:43:18.943460233 +0100
> +++ linux-4.5-rc5/drivers/watchdog/Kconfig	2016-02-24 15:42:49.756057691 +0100
> @@ -1377,10 +1377,12 @@ config BCM7038_WDT
>   	tristate "BCM7038 Watchdog"
>   	select WATCHDOG_CORE
>   	depends on HAS_IOMEM
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>   	help
> -	 Watchdog driver for the built-in hardware in Broadcom 7038 SoCs.
> -
> -	 Say 'Y or 'M' here to enable the driver.
> +	 Watchdog driver for the built-in hardware in Broadcom 7038 and
> +	 later SoCs used in set-top boxes.  BCM7038 was made public
> +	 during the 2004 CES, and since then, many Broadcom chips use this
> +	 watchdog block, including some cable modem chips.
>
>   config IMGPDC_WDT
>   	tristate "Imagination Technologies PDC Watchdog Timer"
>

