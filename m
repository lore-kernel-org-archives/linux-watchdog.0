Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59127 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbbAKBY5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 10 Jan 2015 20:24:57 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YA7Gy-0009BA-SL
	for linux-watchdog@vger.kernel.org; Sun, 11 Jan 2015 01:24:57 +0000
Message-ID: <54B1D0E5.3010904@roeck-us.net>
Date: Sat, 10 Jan 2015 17:24:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Ralf Baechle <ralf@linux-mips.org>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Paul Burton <paul.burton@imgtec.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Maarten ter Huurne <maarten@treewalker.org>,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] MIPS: qi_lb60: Register watchdog device
References: <1420914550-18335-1-git-send-email-lars@metafoo.de> <1420914550-18335-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1420914550-18335-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/10/2015 10:29 AM, Lars-Peter Clausen wrote:
> The next commit will move the restart code to the watchdog driver. So for
> restart to continue to work we need to register the watchdog device.
>
> Also enable the watchdog driver in the default config.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>   arch/mips/configs/qi_lb60_defconfig |    2 ++
>   arch/mips/jz4740/board-qi_lb60.c    |    1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
> index 2b96547..ce06a92 100644
> --- a/arch/mips/configs/qi_lb60_defconfig
> +++ b/arch/mips/configs/qi_lb60_defconfig
> @@ -73,6 +73,8 @@ CONFIG_POWER_SUPPLY=y
>   CONFIG_BATTERY_JZ4740=y
>   CONFIG_CHARGER_GPIO=y
>   # CONFIG_HWMON is not set
> +CONFIG_WATCHDOG=y
> +CONFIG_JZ4740_WDT=y

Shouldn't JZ4740_WDT be selected from MACH_JZ4740 ?

Guess it doesn't really matter if there is just one board, but if there
is ever another board the reset handler would not automatically be enabled.

Thanks,
Guenter

>   CONFIG_MFD_JZ4740_ADC=y
>   CONFIG_REGULATOR=y
>   CONFIG_REGULATOR_FIXED_VOLTAGE=y
> diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
> index c454525..a00f134 100644
> --- a/arch/mips/jz4740/board-qi_lb60.c
> +++ b/arch/mips/jz4740/board-qi_lb60.c
> @@ -436,6 +436,7 @@ static struct gpiod_lookup_table qi_lb60_audio_gpio_table = {
>   };
>
>   static struct platform_device *jz_platform_devices[] __initdata = {
> +	&jz4740_wdt_device,
>   	&jz4740_udc_device,
>   	&jz4740_udc_xceiv_device,
>   	&jz4740_mmc_device,
>

