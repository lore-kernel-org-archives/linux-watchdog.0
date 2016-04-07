Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59169 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbcDGHCo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Apr 2016 03:02:44 -0400
Subject: Re: [PATCH 08/17] watchdog: qcom: configure BARK time in addition to
 BITE time
To: Matthew McClintock <mmcclint@codeaurora.org>,
	andy.gross@linaro.org, linux-arm-msm@vger.kernel.org
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
 <1458770712-10880-9-git-send-email-mmcclint@codeaurora.org>
Cc: qca-upstream.external@qca.qualcomm.com,
	Wim Van Sebroeck <wim@iguana.be>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57060615.3@roeck-us.net>
Date: Thu, 7 Apr 2016 00:02:45 -0700
MIME-Version: 1.0
In-Reply-To: <1458770712-10880-9-git-send-email-mmcclint@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/23/2016 03:05 PM, Matthew McClintock wrote:
> For certain parts and some versions of TZ, TZ will reset the chip
> when a BARK is triggered even though it was not configured here. So
> by default let's configure this BARK time as well.
>
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/qcom-wdt.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index e46f18d..53f57c3 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -22,18 +22,21 @@
>   enum wdt_reg {
>   	WDT_RST,
>   	WDT_EN,
> +	WDT_BARK_TIME,
>   	WDT_BITE_TIME,
>   };
>
>   static const u32 reg_offset_data_apcs_tmr[] = {
>   	[WDT_RST] = 0x38,
>   	[WDT_EN] = 0x40,
> +	[WDT_BARK_TIME] = 0x4C,
>   	[WDT_BITE_TIME] = 0x5C,
>   };
>
>   static const u32 reg_offset_data_kpss[] = {
>   	[WDT_RST] = 0x4,
>   	[WDT_EN] = 0x8,
> +	[WDT_BARK_TIME] = 0x10,
>   	[WDT_BITE_TIME] = 0x14,
>   };
>
> @@ -62,6 +65,7 @@ static int qcom_wdt_start(struct watchdog_device *wdd)
>
>   	writel(0, wdt_addr(wdt, WDT_EN));
>   	writel(1, wdt_addr(wdt, WDT_RST));
> +	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
>   	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
>   	writel(1, wdt_addr(wdt, WDT_EN));
>   	return 0;
> @@ -104,6 +108,7 @@ static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
>
>   	writel(0, wdt_addr(wdt, WDT_EN));
>   	writel(1, wdt_addr(wdt, WDT_RST));
> +	writel(timeout, wdt_addr(wdt, WDT_BARK_TIME));
>   	writel(timeout, wdt_addr(wdt, WDT_BITE_TIME));
>   	writel(1, wdt_addr(wdt, WDT_EN));
>
>

