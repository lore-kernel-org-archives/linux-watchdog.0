Return-path: <jszhang@marvell.com>
Date: Fri, 8 May 2015 10:40:38 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Doug Anderson <dianders@chromium.org>
CC: "wim@iguana.be" <wim@iguana.be>,
        "linux@roeck-us.net"
	<linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] watchdog: dw_wdt: Use a mutex, not a spinlock
Message-ID: <20150508104038.027a1808@xhacker>
In-Reply-To: <1431036564-4189-1-git-send-email-dianders@chromium.org>
References: <1431036564-4189-1-git-send-email-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, 7 May 2015 15:09:23 -0700
Doug Anderson <dianders@chromium.org> wrote:

> Right now the dw_wdt uses a spinlock to protect dw_wdt_open().  The
> problem is that while holding the spinlock we call:
> -> dw_wdt_set_top()
>    -> dw_wdt_top_in_seconds()
>       -> clk_get_rate()
>          -> clk_prepare_lock()
>             -> mutex_lock()
> 
> Locking a mutex while holding a spinlock is not allowed and leads to
> warnings like "BUG: spinlock wrong CPU on CPU#1", among other
> problems.
> 
> There's no reason to use a spinlock, so switch to a mutex.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/watchdog/dw_wdt.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index d0bb949..3fa2f19 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -30,12 +30,12 @@
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/mutex.h>
>  #include <linux/notifier.h>
>  #include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/platform_device.h>
>  #include <linux/reboot.h>
> -#include <linux/spinlock.h>
>  #include <linux/timer.h>
>  #include <linux/uaccess.h>
>  #include <linux/watchdog.h>
> @@ -61,7 +61,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
>  #define WDT_TIMEOUT		(HZ / 2)
>  
>  static struct {
> -	spinlock_t		lock;
> +	struct mutex		lock;
>  	void __iomem		*regs;
>  	struct clk		*clk;
>  	unsigned long		in_use;
> @@ -177,7 +177,7 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
>  	/* Make sure we don't get unloaded. */
>  	__module_get(THIS_MODULE);
>  
> -	spin_lock(&dw_wdt.lock);
> +	mutex_lock(&dw_wdt.lock);
>  	if (!dw_wdt_is_enabled()) {
>  		/*
>  		 * The watchdog is not currently enabled. Set the timeout to
> @@ -190,7 +190,7 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
>  
>  	dw_wdt_set_next_heartbeat();
>  
> -	spin_unlock(&dw_wdt.lock);
> +	mutex_unlock(&dw_wdt.lock);
>  
>  	return nonseekable_open(inode, filp);
>  }
> @@ -348,7 +348,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	spin_lock_init(&dw_wdt.lock);
> +	mutex_init(&dw_wdt.lock);
>  
>  	ret = misc_register(&dw_wdt_miscdev);
>  	if (ret)

Tested on marvell BG2Q SoC, no issue found. So

Tested-by: Jisheng Zhang <jszhang@marvell.com>
