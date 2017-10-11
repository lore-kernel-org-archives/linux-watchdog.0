Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38849 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdJKDl6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Oct 2017 23:41:58 -0400
Subject: Re: [PATCH 2/3] watchdog: orion: don't enable rstout if an interrupt
 is configured
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, wim@iguana.be,
        gregory.clement@free-electrons.com, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
 <20171011022958.31268-3-chris.packham@alliedtelesis.co.nz>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <227eed69-c4c8-01a1-3c6b-6cf95e84a9cd@roeck-us.net>
Date: Tue, 10 Oct 2017 20:41:53 -0700
MIME-Version: 1.0
In-Reply-To: <20171011022958.31268-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/10/2017 07:29 PM, Chris Packham wrote:
> The orion_wdt_irq invokes panic() so we are going to reset the CPU
> regardless.  By not setting this bit we get a chance to gather debug
> from the panic output before the system is reset.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Unless I am missing something, this assumes that the interrupt is
handled, ie that the system is not stuck with interrupts disabled.
This makes the watchdog less reliable. This added verbosity comes
at a significant cost. I'd like to get input from others if this
is acceptable.

That would be different if there was a means to configure a pretimeout,
ie a means to tell the system to generate an irq first, followed by a
hard reset if the interrupt is not served. that does not seem to be
the case here, though.

Guenter

> ---
>   drivers/watchdog/orion_wdt.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index ea676d233e1e..ce88f339ef7f 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -71,6 +71,7 @@ struct orion_watchdog {
>   	unsigned long clk_rate;
>   	struct clk *clk;
>   	const struct orion_watchdog_data *data;
> +	int irq;
>   };
>   
>   static int orion_wdt_clock_init(struct platform_device *pdev,
> @@ -203,9 +204,11 @@ static int armada375_start(struct watchdog_device *wdt_dev)
>   						dev->data->wdt_enable_bit);
>   
>   	/* Enable reset on watchdog */
> -	reg = readl(dev->rstout);
> -	reg |= dev->data->rstout_enable_bit;
> -	writel(reg, dev->rstout);
> +	if (!dev->irq) {
> +		reg = readl(dev->rstout);
> +		reg |= dev->data->rstout_enable_bit;
> +		writel(reg, dev->rstout);
> +	}
>   
>   	atomic_io_modify(dev->rstout_mask, dev->data->rstout_mask_bit, 0);
>   	return 0;
> @@ -228,9 +231,12 @@ static int armada370_start(struct watchdog_device *wdt_dev)
>   						dev->data->wdt_enable_bit);
>   
>   	/* Enable reset on watchdog */
> -	reg = readl(dev->rstout);
> -	reg |= dev->data->rstout_enable_bit;
> -	writel(reg, dev->rstout);
> +	if (!dev->irq) {
> +		reg = readl(dev->rstout);
> +		reg |= dev->data->rstout_enable_bit;
> +		writel(reg, dev->rstout);
> +	}
> +
>   	return 0;
>   }
>   
> @@ -247,8 +253,9 @@ static int orion_start(struct watchdog_device *wdt_dev)
>   						dev->data->wdt_enable_bit);
>   
>   	/* Enable reset on watchdog */
> -	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,
> -				      dev->data->rstout_enable_bit);
> +	if (!dev->irq)
> +		atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,
> +					      dev->data->rstout_enable_bit);
>   
>   	return 0;
>   }
> @@ -595,6 +602,8 @@ static int orion_wdt_probe(struct platform_device *pdev)
>   			dev_err(&pdev->dev, "failed to request IRQ\n");
>   			goto disable_clk;
>   		}
> +
> +		dev->irq = irq;
>   	}
>   
>   	watchdog_set_nowayout(&dev->wdt, nowayout);
> 

