Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:65339 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbaAYSP5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 Jan 2014 13:15:57 -0500
Message-ID: <52E3FF5D.4060505@roeck-us.net>
Date: Sat, 25 Jan 2014 10:15:57 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 07/18] watchdog: orion: Handle IRQ
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390431915-5115-8-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390431915-5115-8-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/22/2014 03:05 PM, Ezequiel Garcia wrote:
> DT-enabled where an irqchip driver for the brigde interrupt controller is
> available can handle the watchdog IRQ properly. Therefore, we request
> the interruption and add a dummy handler that merely calls panic().
>
> This is done in order to have an initial 'ack' of the interruption,
> which clears the watchdog state.
>
> Furthermore, since some platforms don't have such IRQ, this commit
> makes the interruption specification optional.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>   .../devicetree/bindings/watchdog/marvel.txt        |  2 ++
>   drivers/watchdog/orion_wdt.c                       | 24 +++++++++++++++++++++-
>   2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
> index 5dc8d30..0731fbd 100644
> --- a/Documentation/devicetree/bindings/watchdog/marvel.txt
> +++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
> @@ -7,6 +7,7 @@ Required Properties:
>
>   Optional properties:
>
> +- interrupts	: Contains the IRQ for watchdog expiration
>   - timeout-sec	: Contains the watchdog timeout in seconds
>
>   Example:
> @@ -14,6 +15,7 @@ Example:
>   	wdt@20300 {
>   		compatible = "marvell,orion-wdt";
>   		reg = <0x20300 0x28>;
> +		interrupts = <3>;
>   		timeout-sec = <10>;
>   		status = "okay";
>   	};
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 2dbeee9..f5e7b17 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -19,6 +19,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/watchdog.h>
>   #include <linux/init.h>
> +#include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/clk.h>
>   #include <linux/err.h>
> @@ -109,10 +110,16 @@ static struct watchdog_device orion_wdt = {
>   	.min_timeout = 1,
>   };
>
> +static irqreturn_t orion_wdt_irq(int irq, void *devid)
> +{
> +	panic("Watchdog Timeout");
> +	return IRQ_HANDLED;
> +}
> +
>   static int orion_wdt_probe(struct platform_device *pdev)
>   {
>   	struct resource *res;
> -	int ret;
> +	int ret, irq;
>
>   	clk = devm_clk_get(&pdev->dev, NULL);
>   	if (IS_ERR(clk)) {
> @@ -145,6 +152,21 @@ static int orion_wdt_probe(struct platform_device *pdev)
>   	/* Let's make sure the watchdog is fully stopped */
>   	orion_wdt_stop(&orion_wdt);
>
> +	/* It's important to request the IRQ once the watchdog is disabled */

s/once/only after/

> +	irq = platform_get_irq(pdev, 0);
> +	if (irq >= 0) {
> +		/*
> +		 * Not all supported platforms specify an interruption for the

s/interruption/interrupt pin/ (or interrupt)

Nitpicks, so

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

