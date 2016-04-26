Return-path: <joe@perches.com>
Message-ID: <1461648139.2726.119.camel@perches.com>
Subject: Re: [PATCH] watchdog: trivial fix of spelling mistake on "allocate"
From: Joe Perches <joe@perches.com>
To: Colin King <colin.king@canonical.com>, Wim Van Sebroeck <wim@iguana.be>,
  Guenter Roeck <linux@roeck-us.net>, Jiri Kosina <trivial@kernel.org>,
 linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 22:22:19 -0700
In-Reply-To: <1461611991-27328-1-git-send-email-colin.king@canonical.com>
References: <1461611991-27328-1-git-send-email-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, 2016-04-25 at 20:19 +0100, Colin King wrote:
> fix spelling mistake, alloacate -> allocate
[]
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
[]
> @@ -161,7 +161,7 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>  	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
>  			       GFP_KERNEL);
>  	if (!drvdata) {
> -		dev_err(&pdev->dev, "Unable to alloacate watchdog device\n");
> +		dev_err(&pdev->dev, "Unable to allocate watchdog device\n");

Might as well delete this line instead.
