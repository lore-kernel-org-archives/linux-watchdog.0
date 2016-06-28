Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58919 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbcF1F0N (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jun 2016 01:26:13 -0400
Subject: Re: [PATCH 3/3] watchdog: qcom: configure BARK time in addition to
 BITE time
To: Thomas Pedersen <twp@codeaurora.org>,
	linux-watchdog@vger.kernel.org
References: <1467070010-16965-1-git-send-email-twp@codeaurora.org>
 <1467070010-16965-4-git-send-email-twp@codeaurora.org>
Cc: Matthew McClintock <mmcclint@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57720A6E.3020507@roeck-us.net>
Date: Mon, 27 Jun 2016 22:26:06 -0700
MIME-Version: 1.0
In-Reply-To: <1467070010-16965-4-git-send-email-twp@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/27/2016 04:26 PM, Thomas Pedersen wrote:
> From: Matthew McClintock <mmcclint@codeaurora.org>
>
> For certain parts and some versions of TZ, TZ will reset the chip
> when a BARK is triggered even though it was not configured here. So
> by default let's configure this BARK time as well.
>
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>

Seems to be identical to the earlier version of the same patch, which
already had my

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/qcom-wdt.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 70e42ed..e2ad6e1 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -23,6 +23,7 @@ enum wdt_reg {
>   	WDT_RST,
>   	WDT_EN,
>   	WDT_STS,
> +	WDT_BARK_TIME,
>   	WDT_BITE_TIME,
>   };
>
> @@ -30,6 +31,7 @@ static const u32 reg_offset_data_apcs_tmr[] = {
>   	[WDT_RST] = 0x38,
>   	[WDT_EN] = 0x40,
>   	[WDT_STS] = 0x44,
> +	[WDT_BARK_TIME] = 0x4C,
>   	[WDT_BITE_TIME] = 0x5C,
>   };
>
> @@ -37,6 +39,7 @@ static const u32 reg_offset_data_kpss[] = {
>   	[WDT_RST] = 0x4,
>   	[WDT_EN] = 0x8,
>   	[WDT_STS] = 0xC,
> +	[WDT_BARK_TIME] = 0x10,
>   	[WDT_BITE_TIME] = 0x14,
>   };
>
> @@ -65,6 +68,7 @@ static int qcom_wdt_start(struct watchdog_device *wdd)
>
>   	writel(0, wdt_addr(wdt, WDT_EN));
>   	writel(1, wdt_addr(wdt, WDT_RST));
> +	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
>   	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
>   	writel(1, wdt_addr(wdt, WDT_EN));
>   	return 0;
> @@ -107,6 +111,7 @@ static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
>
>   	writel(0, wdt_addr(wdt, WDT_EN));
>   	writel(1, wdt_addr(wdt, WDT_RST));
> +	writel(timeout, wdt_addr(wdt, WDT_BARK_TIME));
>   	writel(timeout, wdt_addr(wdt, WDT_BITE_TIME));
>   	writel(1, wdt_addr(wdt, WDT_EN));
>
>

