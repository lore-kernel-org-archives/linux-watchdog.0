Return-path: <jszhang@marvell.com>
Date: Fri, 8 May 2015 10:41:33 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Doug Anderson <dianders@chromium.org>, "wim@iguana.be" <wim@iguana.be>,
        "linux@roeck-us.net" <linux@roeck-us.net>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] watchdog: dw_wdt: keepalive the watchdog at write
 time
Message-ID: <20150508104133.221f2c1c@xhacker>
In-Reply-To: <1431036564-4189-2-git-send-email-dianders@chromium.org>
References: <1431036564-4189-1-git-send-email-dianders@chromium.org>
	<1431036564-4189-2-git-send-email-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, 7 May 2015 15:09:24 -0700
Doug Anderson <dianders@chromium.org> wrote:

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
> ---
>  drivers/watchdog/dw_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 3fa2f19..ff5d734 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -220,6 +220,7 @@ static ssize_t dw_wdt_write(struct file *filp, const char __user *buf,
>  	}
>  
>  	dw_wdt_set_next_heartbeat();
> +	dw_wdt_keepalive();
>  	mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
>  
>  	return len;

Tested-by: Jisheng Zhang <jszhang@marvell.com>
