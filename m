Return-path: <joe@perches.com>
Message-ID: <1421116962.9233.17.camel@perches.com>
Subject: Re: [PATCH v4 1/2] watchdog: Add driver for Mediatek watchdog
From: Joe Perches <joe@perches.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: wim@iguana.be, robh+dt@kernel.org, pawel.moll@arm.com,
 mark.rutland@arm.com,  ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
 grant.likely@linaro.org,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,  linux-watchdog@vger.kernel.org,
 heiko@sntech.de, yingjoe.chen@gmail.com,  ibanezchen@gmail.com,
 greta.zhang@mediatek.com, eddie.huang@mediatek.com,  wens@csie.org,
 linux@roeck-us.net
Date: Mon, 12 Jan 2015 18:42:42 -0800
In-Reply-To: <1421076884-15860-2-git-send-email-matthias.bgg@gmail.com>
References: <1421076884-15860-1-git-send-email-matthias.bgg@gmail.com>
	 <1421076884-15860-2-git-send-email-matthias.bgg@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, 2015-01-12 at 16:34 +0100, Matthias Brugger wrote:
> This patch adds a driver for the Mediatek SoC integrated
> watchdog. This driver supports watchdog and software reset
> for mt65xx and mt81xx SoCs.

trivia:

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
[]
> +static int mtk_wdt_probe(struct platform_device *pdev)
> +{
[]
> +	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",

missing terminating \n newline
