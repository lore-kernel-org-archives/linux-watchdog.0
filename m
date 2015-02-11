Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36399 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbbBKKrw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 Feb 2015 05:47:52 -0500
MIME-Version: 1.0
In-Reply-To: <20150211102621.GC18515@mwanda>
References: <20150211102621.GC18515@mwanda>
Date: Wed, 11 Feb 2015 11:47:50 +0100
Message-ID: <CABuKBeLJ6T=ZCgu3Ves-5PdbCOPUL1L6z3Y5xqYEvgOrLFVumw@mail.gmail.com>
Subject: Re: [patch] watchdog: mtk_wdt: signedness bug in mtk_wdt_start()
From: Matthias Brugger <matthias.bgg@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

2015-02-11 11:26 GMT+01:00 Dan Carpenter <dan.carpenter@oracle.com>:
> "ret" should be signed for the error handling to work correctly.  This
> doesn't matter much in real life since mtk_wdt_set_timeout() always
> succeeds.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index a87f6df..938b987 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -133,7 +133,7 @@ static int mtk_wdt_start(struct watchdog_device *wdt_dev)
>         u32 reg;
>         struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
>         void __iomem *wdt_base = mtk_wdt->wdt_base;
> -       u32 ret;
> +       int ret;
>
>         ret = mtk_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
>         if (ret < 0)



-- 
motzblog.wordpress.com
