Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56868 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbbFVQl1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Jun 2015 12:41:27 -0400
Date: Mon, 22 Jun 2015 09:41:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: Re: [v2,1/3] watchdog: max63xx: dynamically allocate device
Message-ID: <20150622164124.GA837@roeck-us.net>
References: <1434581940-15086-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1434581940-15086-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Vivien,

On Wed, Jun 17, 2015 at 06:58:58PM -0400, Vivien Didelot wrote:
> This patch removes the static watchdog device for a new max63xx_wdt data
> structure, and constifies the max63xx_timeout data.
> 
> The new structure contains pointers to pin access routines, which
> abstracts mmap-specific code. This will ease future accesses like GPIO.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Looks good. Minor nitpick below, but not worth a new version.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/max63xx_wdt.c | 170 +++++++++++++++++++++++++----------------
>  1 file changed, 104 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
> index b3a1130..3f7e8d5 100644
> --- a/drivers/watchdog/max63xx_wdt.c
> +++ b/drivers/watchdog/max63xx_wdt.c
> @@ -39,10 +39,22 @@ static bool nowayout  = WATCHDOG_NOWAYOUT;
>  #define MAX6369_WDSET	(7 << 0)
>  #define MAX6369_WDI	(1 << 3)
>  
> -static DEFINE_SPINLOCK(io_lock);
> +#define MAX6369_WDSET_DISABLED 3

I would have used a tab before '3'.

Thanks,
Guenter
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
