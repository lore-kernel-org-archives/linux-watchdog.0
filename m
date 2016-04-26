Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46373 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcDZBls (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Apr 2016 21:41:48 -0400
Subject: Re: [PATCH] watchdog: trivial fix of spelling mistake on "allocate"
To: Colin King <colin.king@canonical.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jiri Kosina <trivial@kernel.org>,
	linux-watchdog@vger.kernel.org
References: <1461611991-27328-1-git-send-email-colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <571EC759.6040100@roeck-us.net>
Date: Mon, 25 Apr 2016 18:41:45 -0700
MIME-Version: 1.0
In-Reply-To: <1461611991-27328-1-git-send-email-colin.king@canonical.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/25/2016 12:19 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> fix spelling mistake, alloacate -> allocate
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/jz4740_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 6a7d5c3..3f2ddc8 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -161,7 +161,7 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>   	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
>   			       GFP_KERNEL);
>   	if (!drvdata) {
> -		dev_err(&pdev->dev, "Unable to alloacate watchdog device\n");
> +		dev_err(&pdev->dev, "Unable to allocate watchdog device\n");
>   		return -ENOMEM;
>   	}
>
>

