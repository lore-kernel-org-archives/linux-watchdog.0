Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45034 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932691AbcI1Pve (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Sep 2016 11:51:34 -0400
Date: Wed, 28 Sep 2016 08:51:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH -next] watchdog: wdat_wdt: Fix warning for using 0 as NULL
Message-ID: <20160928155129.GB29624@roeck-us.net>
References: <1475073895-10369-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475073895-10369-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Sep 28, 2016 at 02:44:55PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warnings:
> 
> drivers/watchdog/wdat_wdt.c:210:66: warning: Using plain integer as NULL pointer
> drivers/watchdog/wdat_wdt.c:235:66: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/wdat_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index 6b64645..7ab923f 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -207,7 +207,7 @@ static int wdat_wdt_enable_reboot(struct wdat_wdt *wdat)
>  	 * recommeded to make it configurable through hardware register. We
>  	 * enable reboot now if it is configrable, just in case.
>  	 */
> -	ret = wdat_wdt_run_action(wdat, ACPI_WDAT_SET_REBOOT, 0, 0);
> +	ret = wdat_wdt_run_action(wdat, ACPI_WDAT_SET_REBOOT, 0, NULL);
>  	if (ret && ret != -EOPNOTSUPP) {
>  		dev_err(&wdat->pdev->dev,
>  			"Failed to enable reboot when watchdog triggers\n");
> @@ -232,7 +232,7 @@ static void wdat_wdt_boot_status(struct wdat_wdt *wdat)
>  		wdat->wdd.bootstatus = WDIOF_CARDRESET;
>  
>  	/* Clear the boot status in case BIOS did not do it */
> -	ret = wdat_wdt_run_action(wdat, ACPI_WDAT_SET_STATUS, 0, 0);
> +	ret = wdat_wdt_run_action(wdat, ACPI_WDAT_SET_STATUS, 0, NULL);
>  	if (ret && ret != -EOPNOTSUPP)
>  		dev_err(&wdat->pdev->dev, "Failed to clear boot status\n");
>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
