Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:21424 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914AbaKMNGu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 13 Nov 2014 08:06:50 -0500
Message-ID: <5464AC87.6000004@imgtec.com>
Date: Thu, 13 Nov 2014 10:05:11 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: <Naidu.Tellapati@imgtec.com>, <wim@iguana.be>,
	<linux@roeck-us.net>, <James.Hartley@imgtec.com>,
	<abrestic@chromium.org>, <Jude.Abraham@imgtec.com>
CC: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
References: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com> <1415805483-26268-2-git-send-email-Naidu.Tellapati@imgtec.com>
In-Reply-To: <1415805483-26268-2-git-send-email-Naidu.Tellapati@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 11/12/2014 12:18 PM, Naidu.Tellapati@imgtec.com wrote:
[..]
> +
> +static int pdc_wdt_keepalive(struct watchdog_device *wdt_dev)
> +{
> +	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
> +
> +	writel(PDC_WD_TICKLE1_MAGIC, wdt->base + PDC_WD_TICKLE1);
> +	writel(PDC_WD_TICKLE2_MAGIC, wdt->base + PDC_WD_TICKLE2);
> +
> +	return 0;
> +}
> +
> +static int pdc_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +	unsigned int val;
> +	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
> +
> +	val = readl(wdt->base + PDC_WD_CONFIG);
> +	val &= ~BIT(31);
> +	writel(val, wdt->base + PDC_WD_CONFIG);
> +	/* Must tickle to finish the stop */
> +	pdc_wdt_keepalive(wdt_dev);
> +
> +	return 0;
> +}
> +
> +static int pdc_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +			       unsigned int new_timeout)
> +{
> +	unsigned int val;
> +	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
> +
> +	if (new_timeout < PDC_WD_MIN_TIMEOUT ||
> +	    new_timeout > PDC_WD_MAX_TIMEOUT)
> +		return -EINVAL;
> +
> +	wdt->wdt_dev.timeout = new_timeout;
> +
> +	/* round up to the next power of 2 */
> +	new_timeout = order_base_2(new_timeout);
> +	val = readl(wdt->base + PDC_WD_CONFIG);
> +
> +	/* number of 32.768KHz clocks, 2^(n+1) (14 is 1 sec) */
> +	val &= ~PDC_WD_CONFIG_DELAY;
> +	val |= (new_timeout + MIN_TIMEOUT_SHIFT) << PDC_WD_CONFIG_DELAY_SHIFT;
> +	writel(val, wdt->base + PDC_WD_CONFIG);
> +
> +	return 0;
> +}
> +
> +static int pdc_wdt_set_pretimeout(struct watchdog_device *wdt_dev,
> +				  unsigned int new_pretimeout)
> +{
> +	int delay;
> +	unsigned int val;
> +	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
> +
> +       /*
> +	* Pretimeout is measured in seconds before main timeout.
> +	* Subtract and round it once, and it will effectively change
> +	* if the main timeout is changed.
> +	*/
> +	delay = wdt->wdt_dev.timeout;
> +	if (!new_pretimeout)
> +		new_pretimeout = PDC_WD_MAX_TIMEOUT;
> +	else if (new_pretimeout > 0 && new_pretimeout < delay)
> +		new_pretimeout = delay - new_pretimeout;
> +	else
> +		return -EINVAL;
> +
> +	pretimeout = new_pretimeout;
> +	new_pretimeout = ilog2(new_pretimeout);
> +	val = readl(wdt->base + PDC_WD_CONFIG);
> +
> +	/* number of 32.768KHz clocks, 2^(n+1) (14 is 1 sec) */
> +	val &= ~PDC_WD_CONFIG_REMIND;
> +	val |= (new_pretimeout + MIN_TIMEOUT_SHIFT)
> +				<< PDC_WD_CONFIG_REMIND_SHIFT;
> +	writel(val, wdt->base + PDC_WD_CONFIG);
> +	wdt->pretimeout = pretimeout;
> +
> +	return 0;
> +}
> +
> +/* Start the watchdog timer (delay should already be set */
> +static int pdc_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +	int ret;
> +	unsigned int val;
> +	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
> +
> +	ret = pdc_wdt_set_timeout(&wdt->wdt_dev, wdt->wdt_dev.timeout);
> +	if (ret < 0)
> +		return ret;
> +

Please double check it, but I think you don't need to set the timeout
here. You set the default at probe time; and then it'll get set by the
ioctl if it changes.

-- 
Ezequiel
