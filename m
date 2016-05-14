Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:34824 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753866AbcENSel (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 14:34:41 -0400
Date: Sat, 14 May 2016 20:34:39 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: cpwd: Use setup_timer()
Message-ID: <20160514183439.GF21026@spo001.leaseweb.nl>
References: <1462539581-26207-1-git-send-email-falakreyaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462539581-26207-1-git-send-email-falakreyaz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Muhammed,

> The function setup_timer combines the initialization of a timer with
> the initialization of the timer's function and data fields.
> The multiline code for timer initialization is now replaced
> with function setup_timer.
> 
> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
> ---
>  drivers/watchdog/cpwd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
> index 0200768..71ee079 100644
> --- a/drivers/watchdog/cpwd.c
> +++ b/drivers/watchdog/cpwd.c
> @@ -611,9 +611,7 @@ static int cpwd_probe(struct platform_device *op)
>  	}
>  
>  	if (p->broken) {
> -		init_timer(&cpwd_timer);
> -		cpwd_timer.function	= cpwd_brokentimer;
> -		cpwd_timer.data		= (unsigned long) p;
> +		setup_timer(&cpwd_timer, cpwd_brokentimer, (unsigned long)p);
>  		cpwd_timer.expires	= WD_BTIMEOUT;
>  
>  		pr_info("PLD defect workaround enabled for model %s\n",
> -- 
> 1.9.1
> 

This patch was added to linux-watchdog-next.

Kind Regards,
Wim.

