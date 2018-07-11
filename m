Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37633 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388138AbeGKNsr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Jul 2018 09:48:47 -0400
Received: by mail-pf0-f194.google.com with SMTP id x10-v6so8588787pfm.4
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Jul 2018 06:44:21 -0700 (PDT)
Subject: Re: [PATCH -next] watchdog: sprd_wdt: Remove redundant dev_err call
 in sprd_wdt_probe()
To: Wei Yongjun <weiyongjun1@huawei.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Eric Long <eric.long@spreadtrum.com>
Cc: linux-watchdog@vger.kernel.org
References: <1531315075-183834-1-git-send-email-weiyongjun1@huawei.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <cd3a1357-c99c-1ecf-b418-0ac3e92cf777@roeck-us.net>
Date: Wed, 11 Jul 2018 06:44:19 -0700
MIME-Version: 1.0
In-Reply-To: <1531315075-183834-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/11/2018 06:17 AM, Wei Yongjun wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sprd_wdt.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
> index a8b280f..6bcfabb 100644
> --- a/drivers/watchdog/sprd_wdt.c
> +++ b/drivers/watchdog/sprd_wdt.c
> @@ -277,10 +277,8 @@ static int sprd_wdt_probe(struct platform_device *pdev)
>   
>   	wdt_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	wdt->base = devm_ioremap_resource(&pdev->dev, wdt_res);
> -	if (IS_ERR(wdt->base)) {
> -		dev_err(&pdev->dev, "failed to map memory resource\n");
> +	if (IS_ERR(wdt->base))
>   		return PTR_ERR(wdt->base);
> -	}
>   
>   	wdt->enable = devm_clk_get(&pdev->dev, "enable");
>   	if (IS_ERR(wdt->enable)) {
> 
> 

