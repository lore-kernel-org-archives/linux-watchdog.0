Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52022 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbbG0OOL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 10:14:11 -0400
Message-ID: <55B63CB0.7000302@roeck-us.net>
Date: Mon, 27 Jul 2015 07:14:08 -0700
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
Subject: Re: [PATCH 5/5] i2c-i801: fixup regarding watchdog timer
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk> <1438004292-16382-6-git-send-email-matt@codeblueprint.co.uk>
In-Reply-To: <1438004292-16382-6-git-send-email-matt@codeblueprint.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/27/2015 06:38 AM, Matt Fleming wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Change &array[0] to array since it's the same.
>
> It fixes 80 character limit warning as well.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>

Should be merged into patch 2.

Guenter

> ---
>   drivers/i2c/busses/i2c-i801.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index c79dbe116ccc..e41005927746 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1173,7 +1173,8 @@ static void i801_add_tco(struct i801_priv *priv)
>   	if (!(tco_ctl & TCOCTL_EN))
>   		return;
>
> -	memset(&tco_res[0], 0, sizeof(tco_res));
> +	memset(tco_res, 0, sizeof(tco_res));
> +
>   	res = &tco_res[ICH_RES_IO_TCO];
>   	res->start = tco_base & ~1;
>   	res->end = res->start + 32 - 1;
> @@ -1226,7 +1227,7 @@ static void i801_add_tco(struct i801_priv *priv)
>   	res->flags = IORESOURCE_MEM;
>
>   	pdev = platform_device_register_resndata(&pci_dev->dev, "iTCO_wdt", -1,
> -						 &tco_res[0], 3, &tco_platform_data,
> +						 tco_res, 3, &tco_platform_data,
>   						 sizeof(tco_platform_data));
>   	if (IS_ERR(pdev)) {
>   		dev_warn(&pci_dev->dev, "failed to create iTCO device\n");
>

