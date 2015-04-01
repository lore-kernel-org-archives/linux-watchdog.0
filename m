Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53494 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbbDADut (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 Mar 2015 23:50:49 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Yd9g0-003q3r-C8
	for linux-watchdog@vger.kernel.org; Wed, 01 Apr 2015 03:50:48 +0000
Message-ID: <551B6B04.1090507@roeck-us.net>
Date: Tue, 31 Mar 2015 20:50:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Andrew Bresticker <abrestic@chromium.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH 3/4] watchdog: imgpdc: Set timeout before starting watchdog
References: <1427827751-19705-1-git-send-email-abrestic@chromium.org> <1427827751-19705-3-git-send-email-abrestic@chromium.org>
In-Reply-To: <1427827751-19705-3-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/31/2015 11:49 AM, Andrew Bresticker wrote:
> From: Naidu Tellapati <naidu.tellapati@imgtec.com>
>
> Set up the watchdog for the specified timeout before attempting to start it.
>
> Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>   drivers/watchdog/imgpdc_wdt.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
> index f3f65ac..aef3596 100644
> --- a/drivers/watchdog/imgpdc_wdt.c
> +++ b/drivers/watchdog/imgpdc_wdt.c
> @@ -106,6 +106,8 @@ static int pdc_wdt_start(struct watchdog_device *wdt_dev)
>   	unsigned int val;
>   	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
>
> +	pdc_wdt_set_timeout(&wdt->wdt_dev, wdt->wdt_dev.timeout);
> +
>   	val = readl(wdt->base + PDC_WDT_CONFIG);
>   	val |= PDC_WDT_CONFIG_ENABLE;
>   	writel(val, wdt->base + PDC_WDT_CONFIG);
>
It might be better to provide a helper function that doesn't set wdt->wdt_dev.timeout
again, or to just set the timeout with the write to PDC_WDT_CONFIG when starting
the watchdog.

Guenter

