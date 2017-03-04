Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46251 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbdCDPG3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Mar 2017 10:06:29 -0500
Subject: Re: [PATCH 3/4] watchodg: sama5d4: simplify probe
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
 <20170302173114.28508-4-alexandre.belloni@free-electrons.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Wenyou.Yang@microchip.com, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <126269ed-7b78-2885-7120-e57e2e40c14b@roeck-us.net>
Date: Sat, 4 Mar 2017 07:06:26 -0800
MIME-Version: 1.0
In-Reply-To: <20170302173114.28508-4-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/02/2017 09:31 AM, Alexandre Belloni wrote:
> Because the only way to use the driver is to have a device tree enabling
> it, pdev->dev.of_node will never be NULL. Remove the unnecessary check.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sama5d4_wdt.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index 362fd229786d..d710014f3b7d 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -228,15 +228,13 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>
>  	wdt->reg_base = regs;
>
> -	if (pdev->dev.of_node) {
> -		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> -		if (!irq)
> -			dev_warn(&pdev->dev, "failed to get IRQ from DT\n");
> +	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	if (!irq)
> +		dev_warn(&pdev->dev, "failed to get IRQ from DT\n");
>
> -		ret = of_sama5d4_wdt_init(pdev->dev.of_node, wdt);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = of_sama5d4_wdt_init(pdev->dev.of_node, wdt);
> +	if (ret)
> +		return ret;
>
>  	if ((wdt->mr & AT91_WDT_WDFIEN) && irq) {
>  		ret = devm_request_irq(&pdev->dev, irq, sama5d4_wdt_irq_handler,
>

