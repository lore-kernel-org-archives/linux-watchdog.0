Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35102 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbbEHFYI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 May 2015 01:24:08 -0400
Date: Thu, 7 May 2015 22:24:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Doug Anderson <dianders@chromium.org>
Cc: wim@iguana.be, linux@roeck-us.net, jszhang@marvell.com,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] watchdog: dw_wdt: keepalive the watchdog at write
 time
Message-ID: <20150508052404.GB18159@dtor-ws>
References: <1431059265-9204-1-git-send-email-dianders@chromium.org>
 <1431059265-9204-2-git-send-email-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431059265-9204-2-git-send-email-dianders@chromium.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 07, 2015 at 09:27:45PM -0700, Doug Anderson wrote:
> If you've got code that does this in a tight loop
>   1. Open watchdog
>   2. Send 'expect close'
>   3. Close watchdog
> ...you'll eventually trigger a watchdog reset.  You can reproduce this
> by using daisydog (1) and running:
>   while true; do daisydog -c > /dev/null; done
> 
> The problem is that each time you write to the watchdog for 'expect
> close' it moves the timer .5 seconds out.  The timer thus never fires
> and never pats the watchdog for you.
> 
> 1: http://git.chromium.org/gitweb/?p=chromiumos/third_party/daisydog.git
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Jisheng Zhang <jszhang@marvell.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> Changes in v2: None
> 
>  drivers/watchdog/dw_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index a284abd..6ea0634 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -215,6 +215,7 @@ static ssize_t dw_wdt_write(struct file *filp, const char __user *buf,
>  	}
>  
>  	dw_wdt_set_next_heartbeat();
> +	dw_wdt_keepalive();
>  	mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
>  
>  	return len;
> -- 
> 2.2.0.rc0.207.ga3a616c
> 

-- 
Dmitry
