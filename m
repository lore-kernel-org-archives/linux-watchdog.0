Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43800 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751138AbcGQUUg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:20:36 -0400
Date: Sun, 17 Jul 2016 22:20:34 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Thomas Pedersen <twp@codeaurora.org>
Cc: linux-watchdog@vger.kernel.org,
	Matthew McClintock <mmcclint@codeaurora.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 3/3] watchdog: qcom: configure BARK time in addition to BITE time
Message-ID: <20160717202034.GA916@spo001.leaseweb.nl>
References: <1467222602-18362-1-git-send-email-twp@codeaurora.org> <1467222602-18362-3-git-send-email-twp@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467222602-18362-3-git-send-email-twp@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Matthew,

> From: Matthew McClintock <mmcclint@codeaurora.org>
> 
> For certain parts and some versions of TZ, TZ will reset the chip
> when a BARK is triggered even though it was not configured here. So
> by default let's configure this BARK time as well.
> 
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Thomas Pedersen <twp@codeaurora.org>
> ---
>  drivers/watchdog/qcom-wdt.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 111e8a7..5796b5d 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -24,6 +24,7 @@ enum wdt_reg {
>  	WDT_RST,
>  	WDT_EN,
>  	WDT_STS,
> +	WDT_BARK_TIME,
>  	WDT_BITE_TIME,
>  };
>  
> @@ -31,6 +32,7 @@ static const u32 reg_offset_data_apcs_tmr[] = {
>  	[WDT_RST] = 0x38,
>  	[WDT_EN] = 0x40,
>  	[WDT_STS] = 0x44,
> +	[WDT_BARK_TIME] = 0x4C,
>  	[WDT_BITE_TIME] = 0x5C,
>  };
>  
> @@ -38,6 +40,7 @@ static const u32 reg_offset_data_kpss[] = {
>  	[WDT_RST] = 0x4,
>  	[WDT_EN] = 0x8,
>  	[WDT_STS] = 0xC,
> +	[WDT_BARK_TIME] = 0x10,
>  	[WDT_BITE_TIME] = 0x14,
>  };
>  
> @@ -66,6 +69,7 @@ static int qcom_wdt_start(struct watchdog_device *wdd)
>  
>  	writel(0, wdt_addr(wdt, WDT_EN));
>  	writel(1, wdt_addr(wdt, WDT_RST));
> +	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
>  	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
>  	writel(1, wdt_addr(wdt, WDT_EN));
>  	return 0;
> @@ -108,6 +112,7 @@ static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
>  
>  	writel(0, wdt_addr(wdt, WDT_EN));
>  	writel(1, wdt_addr(wdt, WDT_RST));
> +	writel(timeout, wdt_addr(wdt, WDT_BARK_TIME));
>  	writel(timeout, wdt_addr(wdt, WDT_BITE_TIME));
>  	writel(1, wdt_addr(wdt, WDT_EN));
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

