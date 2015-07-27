Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53447 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342AbbG0OWz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 10:22:55 -0400
Message-ID: <55B63EBB.7030306@roeck-us.net>
Date: Mon, 27 Jul 2015 07:22:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Matt Fleming <matt@codeblueprint.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH 3/5] iTCO_wdt: Add support for TCO on Intel Sunrisepoint
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk> <1438004292-16382-4-git-send-email-matt@codeblueprint.co.uk>
In-Reply-To: <1438004292-16382-4-git-send-email-matt@codeblueprint.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/27/2015 06:38 AM, Matt Fleming wrote:
> From: Matt Fleming <matt.fleming@intel.com>
>
> The revision of the watchdog hardware in Sunrisepoint necessitates a new
> "version" inside the TCO watchdog driver because some of the register
> layouts have changed.
>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> ---
>   drivers/watchdog/iTCO_wdt.c | 58 ++++++++++++++++++++++++++-------------------
>   1 file changed, 34 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 9a6e70976f64..17dfbc51b85a 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -145,58 +145,65 @@ static inline unsigned int ticks_to_seconds(int ticks)
>   	return iTCO_wdt_private.iTCO_version == 3 ? ticks : (ticks * 6) / 10;
>   }
>
> +static inline u32 no_reboot_bit(void)
> +{
> +	u32 enable_bit;
> +
> +	switch (iTCO_wdt_private.iTCO_version) {
> +	case 3:
> +		enable_bit = 0x00000010;
> +		break;
> +	case 2:
> +		enable_bit = 0x00000020;
> +		break;
> +	default:
> +		enable_bit = 0x00000002;

I think it would be better to explicitly list versions 1 and 4 here,
for clarification. We don't know what Intel will come up with for version 5,
and by then no one will remember that bit 2 applies for version 1 and 4 only.

Thanks,
Guenter

> +		break;
> +	}
> +
> +	return enable_bit;
> +}
> +
>   static void iTCO_wdt_set_NO_REBOOT_bit(void)
>   {
>   	u32 val32;
>
>   	/* Set the NO_REBOOT bit: this disables reboots */
> -	if (iTCO_wdt_private.iTCO_version == 3) {
> -		val32 = readl(iTCO_wdt_private.gcs_pmc);
> -		val32 |= 0x00000010;
> -		writel(val32, iTCO_wdt_private.gcs_pmc);
> -	} else if (iTCO_wdt_private.iTCO_version == 2) {
> +	if (iTCO_wdt_private.iTCO_version >= 2) {
>   		val32 = readl(iTCO_wdt_private.gcs_pmc);
> -		val32 |= 0x00000020;
> +		val32 |= no_reboot_bit();
>   		writel(val32, iTCO_wdt_private.gcs_pmc);
>   	} else if (iTCO_wdt_private.iTCO_version == 1) {
>   		pci_read_config_dword(iTCO_wdt_private.pdev, 0xd4, &val32);
> -		val32 |= 0x00000002;
> +		val32 |= no_reboot_bit();
>   		pci_write_config_dword(iTCO_wdt_private.pdev, 0xd4, val32);
>   	}
>   }
>
>   static int iTCO_wdt_unset_NO_REBOOT_bit(void)
>   {
> +	u32 enable_bit = no_reboot_bit();
>   	int ret = 0;
> -	u32 val32;
> +	u32 val32 = 0;
>
>   	/* Unset the NO_REBOOT bit: this enables reboots */
> -	if (iTCO_wdt_private.iTCO_version == 3) {
> -		val32 = readl(iTCO_wdt_private.gcs_pmc);
> -		val32 &= 0xffffffef;
> -		writel(val32, iTCO_wdt_private.gcs_pmc);
> -
> -		val32 = readl(iTCO_wdt_private.gcs_pmc);
> -		if (val32 & 0x00000010)
> -			ret = -EIO;
> -	} else if (iTCO_wdt_private.iTCO_version == 2) {
> +	if (iTCO_wdt_private.iTCO_version >= 2) {
>   		val32 = readl(iTCO_wdt_private.gcs_pmc);
> -		val32 &= 0xffffffdf;
> +		val32 &= ~enable_bit;
>   		writel(val32, iTCO_wdt_private.gcs_pmc);
>
>   		val32 = readl(iTCO_wdt_private.gcs_pmc);
> -		if (val32 & 0x00000020)
> -			ret = -EIO;
>   	} else if (iTCO_wdt_private.iTCO_version == 1) {
>   		pci_read_config_dword(iTCO_wdt_private.pdev, 0xd4, &val32);
> -		val32 &= 0xfffffffd;
> +		val32 &= ~enable_bit;
>   		pci_write_config_dword(iTCO_wdt_private.pdev, 0xd4, val32);
>
>   		pci_read_config_dword(iTCO_wdt_private.pdev, 0xd4, &val32);
> -		if (val32 & 0x00000002)
> -			ret = -EIO;
>   	}
>
> +	if (val32 & enable_bit)
> +		ret = -EIO;
> +
>   	return ret; /* returns: 0 = OK, -EIO = Error */
>   }
>
> @@ -503,7 +510,10 @@ static int iTCO_wdt_probe(struct platform_device *dev)
>   		pdata->name, pdata->iTCO_version, (u64)TCOBASE);
>
>   	/* Clear out the (probably old) status */
> -	if (iTCO_wdt_private.iTCO_version == 3) {
> +	if (iTCO_wdt_private.iTCO_version == 4) {
> +		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */
> +		outw(0x0002, TCO2_STS);	/* Clear SECOND_TO_STS bit */
> +	} else if (iTCO_wdt_private.iTCO_version == 3) {
>   		outl(0x20008, TCO1_STS);
>   	} else {
>   		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */
>

