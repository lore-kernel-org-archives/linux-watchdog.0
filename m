Return-path: <Vladimir_Zapolskiy@mentor.com>
Subject: Re: [PATCH v2 2/2] watchdog: imx2_wdt: add set_pretimeout interface
To: Robin Gong <b38343@freescale.com>, <wim@iguana.be>, <linux@roeck-us.net>
References: <1446531084-15365-1-git-send-email-b38343@freescale.com>
 <1446531084-15365-2-git-send-email-b38343@freescale.com>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <563A2849.5040707@mentor.com>
Date: Wed, 4 Nov 2015 17:46:17 +0200
MIME-Version: 1.0
In-Reply-To: <1446531084-15365-2-git-send-email-b38343@freescale.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Robin,

On 03.11.2015 08:11, Robin Gong wrote:
> Enable set_pretimeout interface and trigger the pretimeout interrupt before
> watchdog timeout event happen.
> 
> Signed-off-by: Robin Gong <b38343@freescale.com>
> ---

[snip]

> +
> +static irqreturn_t imx2_wdt_isr(int irq, void *dev_id)
> +{
> +	struct platform_device *pdev = dev_id;
> +	struct watchdog_device *wdog = platform_get_drvdata(pdev);
> +	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +	u32 val;
> +
> +	regmap_read(wdev->regmap, IMX2_WDT_WICR, &val);
> +	if (val & IMX2_WDT_WICR_WTIS) {
> +		/*clear interrupt status bit*/
> +		regmap_write(wdev->regmap, IMX2_WDT_WICR, val);
> +		panic("pre-timeout:%d, %d Seconds remained\n", wdog->pretimeout,
> +		      wdog->timeout - wdog->pretimeout);

I don't think it is a good idea to panic on pretimeout interrupt, for
instance pretimeout interrupt may be used for any other purposes - ping
watchdog, dump some system information before reboot and so on.

In general I am even not completely convinced that the pretimeout interrupt
handler should be placed in the driver, it may happen that there are some
users outside, who wants to get this interrupt and act according to the event.

> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +

--
With best wishes,
Vladimir
