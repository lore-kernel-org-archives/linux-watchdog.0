Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:56605 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753078AbbC0H5G (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Mar 2015 03:57:06 -0400
Date: Fri, 27 Mar 2015 08:57:03 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/27] watchdog: bcm281xx: Remove use of seq_printf return value
Message-ID: <20150327075703.GB24918@spo001.leaseweb.nl>
References: <cover.1424573328.git.joe@perches.com> <e370a587d7aa9f2bf7b409129a2283a10a134885.1424573328.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e370a587d7aa9f2bf7b409129a2283a10a134885.1424573328.git.joe@perches.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Joe,

> The seq_printf return value, because it's frequently misused,
> will eventually be converted to void.
> 
> See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
>      seq_has_overflowed() and make public")
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/watchdog/bcm_kona_wdt.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
> index 4e37db3..22d8ae6 100644
> --- a/drivers/watchdog/bcm_kona_wdt.c
> +++ b/drivers/watchdog/bcm_kona_wdt.c
> @@ -99,12 +99,14 @@ static int secure_register_read(struct bcm_kona_wdt *wdt, uint32_t offset)
>  
>  static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
>  {
> -	int ctl_val, cur_val, ret;
> +	int ctl_val, cur_val;
>  	unsigned long flags;
>  	struct bcm_kona_wdt *wdt = s->private;
>  
> -	if (!wdt)
> -		return seq_puts(s, "No device pointer\n");
> +	if (!wdt) {
> +		seq_puts(s, "No device pointer\n");
> +		return 0;
> +	}
>  
>  	spin_lock_irqsave(&wdt->lock, flags);
>  	ctl_val = secure_register_read(wdt, SECWDOG_CTRL_REG);
> @@ -112,7 +114,7 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
>  	spin_unlock_irqrestore(&wdt->lock, flags);
>  
>  	if (ctl_val < 0 || cur_val < 0) {
> -		ret = seq_puts(s, "Error accessing hardware\n");
> +		seq_puts(s, "Error accessing hardware\n");
>  	} else {
>  		int ctl, cur, ctl_sec, cur_sec, res;
>  
> @@ -121,15 +123,18 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
>  		cur = cur_val & SECWDOG_COUNT_MASK;
>  		ctl_sec = TICKS_TO_SECS(ctl, wdt);
>  		cur_sec = TICKS_TO_SECS(cur, wdt);
> -		ret = seq_printf(s, "Resolution: %d / %d\n"
> -				"Control: %d s / %d (%#x) ticks\n"
> -				"Current: %d s / %d (%#x) ticks\n"
> -				"Busy count: %lu\n", res,
> -				wdt->resolution, ctl_sec, ctl, ctl, cur_sec,
> -				cur, cur, wdt->busy_count);
> +		seq_printf(s,
> +			   "Resolution: %d / %d\n"
> +			   "Control: %d s / %d (%#x) ticks\n"
> +			   "Current: %d s / %d (%#x) ticks\n"
> +			   "Busy count: %lu\n",
> +			   res, wdt->resolution,
> +			   ctl_sec, ctl, ctl,
> +			   cur_sec, cur, cur,
> +			   wdt->busy_count);
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int bcm_kona_dbg_open(struct inode *inode, struct file *file)
> -- 
> 2.1.2

This patch was applied to linux-watchdog-next.

Kind regards,
Wim.

