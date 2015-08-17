Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52905 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430AbbHQQdf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Aug 2015 12:33:35 -0400
Message-ID: <55D20CD6.90709@roeck-us.net>
Date: Mon, 17 Aug 2015 09:33:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: at91rm9200: Correct check for syscon_node_to_regmap()
 errors
References: <1439828343-6679-1-git-send-email-bjorn.andersson@sonymobile.com>
In-Reply-To: <1439828343-6679-1-git-send-email-bjorn.andersson@sonymobile.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/17/2015 09:19 AM, Bjorn Andersson wrote:
> syscon_node_to_regmap() returns a regmap or an ERR_PTR().
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/at91rm9200_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
> index 9ba1153465ae..e12a797cb820 100644
> --- a/drivers/watchdog/at91rm9200_wdt.c
> +++ b/drivers/watchdog/at91rm9200_wdt.c
> @@ -244,7 +244,7 @@ static int at91wdt_probe(struct platform_device *pdev)
>   	}
>
>   	regmap_st = syscon_node_to_regmap(parent->of_node);
> -	if (!regmap_st)
> +	if (IS_ERR(regmap_st))
>   		return -ENODEV;
>
>   	res = misc_register(&at91wdt_miscdev);
>

