Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:56253 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751964AbbCXISp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Mar 2015 04:18:45 -0400
Date: Tue, 24 Mar 2015 09:18:42 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] watchdog: mtk_wdt: signedness bug in mtk_wdt_start()
Message-ID: <20150324081842.GA1716@spo001.leaseweb.nl>
References: <20150211102621.GC18515@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150211102621.GC18515@mwanda>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Dan,

> "ret" should be signed for the error handling to work correctly.  This
> doesn't matter much in real life since mtk_wdt_set_timeout() always
> succeeds.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index a87f6df..938b987 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -133,7 +133,7 @@ static int mtk_wdt_start(struct watchdog_device *wdt_dev)
>  	u32 reg;
>  	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
>  	void __iomem *wdt_base = mtk_wdt->wdt_base;
> -	u32 ret;
> +	int ret;
>  
>  	ret = mtk_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
>  	if (ret < 0)

Added to linux-watchdog-next. Will go upstream in 2 days.

Kind regards,
Wim.

