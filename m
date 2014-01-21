Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:54601 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbaAUObE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 09:31:04 -0500
Message-ID: <52DE84A6.6090909@roeck-us.net>
Date: Tue, 21 Jan 2014 06:31:02 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 04/15] watchdog: orion: Handle IRQ
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390310774-20781-5-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390310774-20781-5-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/21/2014 05:26 AM, Ezequiel Garcia wrote:
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
>   drivers/watchdog/orion_wdt.c                       | 22 +++++++++++++++++++++-
>   2 files changed, 23 insertions(+), 1 deletion(-)
>

[ ... ]

>   static int orion_wdt_probe(struct platform_device *pdev)
>   {
>   	struct resource *res;
> -	int ret;
> +	int ret, irq;
>
>   	clk = devm_clk_get(&pdev->dev, NULL);
>   	if (IS_ERR(clk)) {
> @@ -131,6 +138,19 @@ static int orion_wdt_probe(struct platform_device *pdev)
>   	if (!wdt_reg)
>   		return -ENOMEM;
>
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq > 0) {

0 is a valid interrupt number, and platform_get_irq returns an error code on errors.
Should be >= 0.

Guenter

