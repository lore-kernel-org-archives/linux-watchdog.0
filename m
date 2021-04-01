Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868E7C433ED
	for <linux-watchdog@archiver.kernel.org>; Thu,  1 Apr 2021 05:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38495610C7
	for <linux-watchdog@archiver.kernel.org>; Thu,  1 Apr 2021 05:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhDAFFa (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 1 Apr 2021 01:05:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6778 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232565AbhDAFFO (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Apr 2021 01:05:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F9rhv65PFz9v3JT;
        Thu,  1 Apr 2021 07:05:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6f39JKoW34ti; Thu,  1 Apr 2021 07:05:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F9rhv54M3z9v3JS;
        Thu,  1 Apr 2021 07:05:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E978E8B776;
        Thu,  1 Apr 2021 07:05:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0ScBHPkqV-Xh; Thu,  1 Apr 2021 07:05:03 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 864DC8B768;
        Thu,  1 Apr 2021 07:05:03 +0200 (CEST)
Subject: Re: [PATCH] watchdog: meson_wdt: Use device_get_match_data() helper
To:     Tian Tao <tiantao6@hisilicon.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, khilman@baylibre.com
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1617243921-56774-1-git-send-email-tiantao6@hisilicon.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <77b2534d-8a3c-381a-af2a-4bf7e2d06736@csgroup.eu>
Date:   Thu, 1 Apr 2021 07:04:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1617243921-56774-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org



Le 01/04/2021 à 04:25, Tian Tao a écrit :
> Use the device_get_match_data() helper instead of open coding.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>   drivers/watchdog/meson_wdt.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
> index 459f3ae..539feaa 100644
> --- a/drivers/watchdog/meson_wdt.c
> +++ b/drivers/watchdog/meson_wdt.c
> @@ -162,7 +162,6 @@ static int meson_wdt_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct meson_wdt_dev *meson_wdt;
> -	const struct of_device_id *of_id;
>   	int err;
>   
>   	meson_wdt = devm_kzalloc(dev, sizeof(*meson_wdt), GFP_KERNEL);
> @@ -173,12 +172,7 @@ static int meson_wdt_probe(struct platform_device *pdev)
>   	if (IS_ERR(meson_wdt->wdt_base))
>   		return PTR_ERR(meson_wdt->wdt_base);
>   
> -	of_id = of_match_device(meson_wdt_dt_ids, dev);
> -	if (!of_id) {
> -		dev_err(dev, "Unable to initialize WDT data\n");
> -		return -ENODEV;
> -	}
> -	meson_wdt->data = of_id->data;
> +	meson_wdt->data = device_get_match_data(dev);

Previously, it was returning -ENODEV on failure.
What happens now when device_get_match_data() returns NULL ?

>   
>   	meson_wdt->wdt_dev.parent = dev;
>   	meson_wdt->wdt_dev.info = &meson_wdt_info;
> 

Christophe
