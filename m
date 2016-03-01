Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:36863 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbcCAXpG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Mar 2016 18:45:06 -0500
Subject: Re: [RFC PATCH] watchdog: s3c2410_wdt: Add max and min timeout values
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1456850717-3670-1-git-send-email-javier@osg.samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56D62979.5040009@samsung.com>
Date: Wed, 02 Mar 2016 08:44:57 +0900
MIME-version: 1.0
In-reply-to: <1456850717-3670-1-git-send-email-javier@osg.samsung.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02.03.2016 01:45, Javier Martinez Canillas wrote:
> The watchdog maximum timeout value is determined by the number of bits
> for the interval timer counter, its source clock frequency, the number
> of bits of the prescaler and maximum divider value.
> 
> This can be calculated with the following equation:
> 
> max_timeout = counter / (freq / (max_prescale + 1) / max_divider)
> 
> Setting a maximum timeout value will allow the watchdog core to refuse
> user-space calls to the WDIOC_SETTIMEOUT ioctl that sets not supported
> timeout values.
> 
> For example, systemd tries to set a timeout of 10 minutes on reboot to
> ensure that the machine will be rebooted even if a reboot failed. This
> leads to the following error message on an Exynos5422 Odroid XU4 board:
> 
> [  147.986045] s3c2410-wdt 101d0000.watchdog: timeout 600 too big
> 
> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> Hello,
> 
> I'm sending this as an RFC because I don't have access to user manuals
> for all the Exynos SoCs that this driver supports. But at least in all
> the ones I have here, the maximum prescaler and divider values are the
> same and also all have a 16-bit interval timer counter.
> 
> So this patch assumes that all IP blocks supported by this driver are
> the same on that regard, if that's not the case then we can move these
> values on a per IP block basis using struct of_device_id .data field.

It looks correct at least for Exynos4210 and newer.

> 
> Best regards,
> Javier
> 
>  drivers/watchdog/s3c2410_wdt.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 0093450441fe..f289c9fc353a 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -47,6 +47,8 @@
>  #define S3C2410_WTDAT		0x04
>  #define S3C2410_WTCNT		0x08
>  
> +#define S3C2410_WTCNT_MAXCNT	0xffff
> +
>  #define S3C2410_WTCON_RSTEN	(1 << 0)
>  #define S3C2410_WTCON_INTEN	(1 << 2)
>  #define S3C2410_WTCON_ENABLE	(1 << 5)
> @@ -56,8 +58,11 @@
>  #define S3C2410_WTCON_DIV64	(2 << 3)
>  #define S3C2410_WTCON_DIV128	(3 << 3)
>  
> +#define S3C2410_WTCON_MAXDIV	0x80
> +
>  #define S3C2410_WTCON_PRESCALE(x)	((x) << 8)
>  #define S3C2410_WTCON_PRESCALE_MASK	(0xff << 8)
> +#define S3C2410_WTCON_PRESCALE_MAX	0xff
>  
>  #define CONFIG_S3C2410_WATCHDOG_ATBOOT		(0)
>  #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
> @@ -198,6 +203,14 @@ do {							\
>  
>  /* functions */
>  
> +static inline unsigned int s3c2410wdt_max_timeout(struct clk *clock)
> +{
> +	unsigned long freq = clk_get_rate(clock);
> +
> +	return S3C2410_WTCNT_MAXCNT / (freq / (S3C2410_WTCON_PRESCALE_MAX + 1)
> +				       / S3C2410_WTCON_MAXDIV);
> +}
> +
>  static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
>  {
>  	return container_of(nb, struct s3c2410_wdt, freq_transition);
> @@ -567,6 +580,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	wdt->wdt_device.min_timeout = 1;
> +	wdt->wdt_device.max_timeout = s3c2410wdt_max_timeout(wdt->clock);

Can the frequency of clock change? E.g. with devfreq? No problem if it
goes lower but if it gets higher than initial, then the problem will
appear again.

Best regards,
Krzysztof

> +
>  	ret = s3c2410wdt_cpufreq_register(wdt);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to register cpufreq\n");
> 

