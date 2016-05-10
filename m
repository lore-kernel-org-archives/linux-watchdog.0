Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54607 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbcEJVwR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 10 May 2016 17:52:17 -0400
Date: Tue, 10 May 2016 14:51:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: cpwd: Use setup_timer()
Message-ID: <20160510215157.GA19128@roeck-us.net>
References: <1462539581-26207-1-git-send-email-falakreyaz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462539581-26207-1-git-send-email-falakreyaz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 06, 2016 at 06:29:40PM +0530, Muhammad Falak R Wani wrote:
> The function setup_timer combines the initialization of a timer with
> the initialization of the timer's function and data fields.
> The multiline code for timer initialization is now replaced
> with function setup_timer.
> 
> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
