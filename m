Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33128 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755548Ab3A3TNE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Jan 2013 14:13:04 -0500
Date: Wed, 30 Jan 2013 20:13:02 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Devendra Naga <devendra.aaru@gmail.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RFT] watchdog: gef_wdt.c: add missing remove callback
Message-ID: <20130130191302.GA20067@spo001.leaseweb.com>
References: <1351880139-31624-1-git-send-email-devendra.aaru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1351880139-31624-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi

> this module missed a remove callback in the platform ops.
> 
> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
> ---
>  Hi,
> 
>  I didn't compile it even, i didn't have any crosstoolchain
> 
>  drivers/watchdog/gef_wdt.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
> index 17f4cae..3e360ed 100644
> --- a/drivers/watchdog/gef_wdt.c
> +++ b/drivers/watchdog/gef_wdt.c
> @@ -310,6 +310,7 @@ static struct platform_driver gef_wdt_driver = {
>  		.of_match_table = gef_wdt_ids,
>  	},
>  	.probe		= gef_wdt_probe,
> +	.remove		= gef_wdt_remove,
>  };
>  
>  static int __init gef_wdt_init(void)

Added to linux-watchdog-next.

Kind regards,
Wim.

