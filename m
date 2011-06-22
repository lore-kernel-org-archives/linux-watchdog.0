Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53335 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab1FVIUJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 04:20:09 -0400
Received: by wyb38 with SMTP id 38so375181wyb.19
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Jun 2011 01:20:08 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/5 v3] WATCHDOG: mtx1-wdt: use dev_{err,info} instead of printk()
Date: Wed, 22 Jun 2011 10:24:20 +0200
Cc: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Jamie Iles <jamie@jamieiles.com>
References: <201106151915.09729.florian@openwrt.org>
In-Reply-To: <201106151915.09729.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106221024.20485.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wednesday 15 June 2011 19:15:09 Florian Fainelli wrote:
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> No changes in v1, v2 and v3

Wim, these are mostly fixes for the driver, do you prefer they get merged with the MIPS tree?

> 
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> index 1479dc4..63df28c 100644
> --- a/drivers/watchdog/mtx-1_wdt.c
> +++ b/drivers/watchdog/mtx-1_wdt.c
> @@ -224,11 +224,11 @@ static int __devinit mtx1_wdt_probe(struct
> platform_device *pdev)
> 
>  	ret = misc_register(&mtx1_wdt_misc);
>  	if (ret < 0) {
> -		printk(KERN_ERR " mtx-1_wdt : failed to register\n");
> +		dev_err(&pdev->dev, "failed to register\n");
>  		return ret;
>  	}
>  	mtx1_wdt_start();
> -	printk(KERN_INFO "MTX-1 Watchdog driver\n");
> +	dev_info(&pdev->dev, "MTX-1 Watchdog driver\n");
>  	return 0;
>  }
