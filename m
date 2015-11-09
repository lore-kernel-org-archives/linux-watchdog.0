Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51149 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbKIPD4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Nov 2015 10:03:56 -0500
Subject: Re: [PATCH v3 2/4] watchdog: meson: Add meson8b SoC specific data
To: Carlo Caione <carlo@caione.org>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	drake@endlessm.com, jerry.cao@amlogic.com, victor.wan@amlogic.com,
	romain.perier@gmail.com
References: <1446985137-25498-1-git-send-email-carlo@caione.org>
 <1446985137-25498-3-git-send-email-carlo@caione.org>
Cc: Carlo Caione <carlo@endlessm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5640B5DA.7040901@roeck-us.net>
Date: Mon, 9 Nov 2015 07:03:54 -0800
MIME-Version: 1.0
In-Reply-To: <1446985137-25498-3-git-send-email-carlo@caione.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/08/2015 04:18 AM, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> Add SoC specific data in the watchdog driver for the meson8b SoC.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/meson_wdt.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
> index 89734f0..3ec1e91 100644
> --- a/drivers/watchdog/meson_wdt.c
> +++ b/drivers/watchdog/meson_wdt.c
> @@ -52,6 +52,12 @@ static struct meson_wdt_data meson6_wdt_data = {
>   	.count_unit		= 100000, /* 10 us */
>   };
>
> +static struct meson_wdt_data meson8b_wdt_data = {
> +	.enable			= BIT(19),
> +	.terminal_count_mask	= 0xffff,
> +	.count_unit		= 7812, /* 128 us */
> +};
> +
>   struct meson_wdt_dev {
>   	struct watchdog_device wdt_dev;
>   	void __iomem *wdt_base;
> @@ -153,6 +159,7 @@ static const struct watchdog_ops meson_wdt_ops = {
>
>   static const struct of_device_id meson_wdt_dt_ids[] = {
>   	{ .compatible = "amlogic,meson6-wdt", .data = &meson6_wdt_data },
> +	{ .compatible = "amlogic,meson8b-wdt", .data = &meson8b_wdt_data },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, meson_wdt_dt_ids);
>

