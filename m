Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35757 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbcAQRab (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jan 2016 12:30:31 -0500
Subject: Re: [PATCH] watchdog: dw_wdt: convert to watchdog core api
To: Jisheng Zhang <jszhang@marvell.com>, wim@iguana.be,
	sebastian.hesselbarth@gmail.com
References: <1450261679-1516-1-git-send-email-jszhang@marvell.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <569BCFB4.9000106@roeck-us.net>
Date: Sun, 17 Jan 2016 09:30:28 -0800
MIME-Version: 1.0
In-Reply-To: <1450261679-1516-1-git-send-email-jszhang@marvell.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/16/2015 02:27 AM, Jisheng Zhang wrote:
> Convert the dw_wdt driver to the new watchdog core api.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
> This patch depends on the signedness bug fix patch:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/393872.html
>

Hi,

sorry for not getting back earlier.

I have a similar patch pending, but it depends on watchdog core changes which
are still being worked on. Hopefully those changes, together with the reworked
dw_wdt driver, can make it into 4.6.

Thanks,
Guenter


>   drivers/watchdog/Kconfig  |   1 +
>   drivers/watchdog/dw_wdt.c | 316 +++++++++++++++++++---------------------------
>   2 files changed, 131 insertions(+), 186 deletions(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 7a8a6c6..886468a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -291,6 +291,7 @@ config SA1100_WATCHDOG
>   config DW_WATCHDOG
>   	tristate "Synopsys DesignWare watchdog"
>   	depends on HAS_IOMEM
> +	select WATCHDOG_CORE
>   	help
>   	  Say Y here if to include support for the Synopsys DesignWare
>   	  watchdog timer found in many chips.
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 8fefa4ad..9e8706a 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -24,10 +24,8 @@
>   #include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
> -#include <linux/fs.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> -#include <linux/miscdevice.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
>   #include <linux/notifier.h>
> @@ -36,7 +34,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/reboot.h>
>   #include <linux/timer.h>
> -#include <linux/uaccess.h>
>   #include <linux/watchdog.h>
>
>   #define WDOG_CONTROL_REG_OFFSET		    0x00
> @@ -59,59 +56,60 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
>
>   #define WDT_TIMEOUT		(HZ / 2)
>
> -static struct {
> +struct dw_wdt_device {
>   	void __iomem		*regs;
>   	struct clk		*clk;
> -	unsigned long		in_use;
> -	unsigned long		next_heartbeat;
>   	struct timer_list	timer;
> -	int			expect_close;
> +	struct watchdog_device	wdog;
>   	struct notifier_block	restart_handler;
> -} dw_wdt;
> +};
>
> -static inline int dw_wdt_is_enabled(void)
> +static inline bool dw_wdt_is_enabled(struct dw_wdt_device *wdev)
>   {
> -	return readl(dw_wdt.regs + WDOG_CONTROL_REG_OFFSET) &
> +	return readl(wdev->regs + WDOG_CONTROL_REG_OFFSET) &
>   		WDOG_CONTROL_REG_WDT_EN_MASK;
>   }
>
> -static inline int dw_wdt_top_in_seconds(unsigned top)
> +static inline unsigned int dw_wdt_top_in_seconds(struct dw_wdt_device *wdev,
> +						 unsigned int top)
>   {
>   	/*
>   	 * There are 16 possible timeout values in 0..15 where the number of
>   	 * cycles is 2 ^ (16 + i) and the watchdog counts down.
>   	 */
> -	return (1U << (16 + top)) / clk_get_rate(dw_wdt.clk);
> +	return (1U << (16 + top)) / clk_get_rate(wdev->clk);
>   }
>
> -static int dw_wdt_get_top(void)
> +static unsigned int dw_wdt_get_timeleft(struct watchdog_device *wdog)
>   {
> -	int top = readl(dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET) & 0xF;
> +	struct dw_wdt_device *wdev = watchdog_get_drvdata(wdog);
>
> -	return dw_wdt_top_in_seconds(top);
> +	return readl(wdev->regs + WDOG_CURRENT_COUNT_REG_OFFSET) /
> +		clk_get_rate(wdev->clk);
>   }
>
> -static inline void dw_wdt_set_next_heartbeat(void)
> +static int dw_wdt_ping(struct watchdog_device *wdog)
>   {
> -	dw_wdt.next_heartbeat = jiffies + dw_wdt_get_top() * HZ;
> -}
> +	struct dw_wdt_device *wdev = watchdog_get_drvdata(wdog);
>
> -static void dw_wdt_keepalive(void)
> -{
> -	writel(WDOG_COUNTER_RESTART_KICK_VALUE, dw_wdt.regs +
> +	writel(WDOG_COUNTER_RESTART_KICK_VALUE, wdev->regs +
>   	       WDOG_COUNTER_RESTART_REG_OFFSET);
> +
> +	return 0;
>   }
>
> -static int dw_wdt_set_top(unsigned top_s)
> +static int dw_wdt_set_timeout(struct watchdog_device *wdog,
> +			      unsigned int new_timeout)
>   {
> -	int i, top_val = DW_WDT_MAX_TOP;
> +	unsigned int i, top_val = DW_WDT_MAX_TOP;
> +	struct dw_wdt_device *wdev = watchdog_get_drvdata(wdog);
>
>   	/*
>   	 * Iterate over the timeout values until we find the closest match. We
>   	 * always look for >=.
>   	 */
>   	for (i = 0; i <= DW_WDT_MAX_TOP; ++i)
> -		if (dw_wdt_top_in_seconds(i) >= top_s) {
> +		if (dw_wdt_top_in_seconds(wdev, i) >= new_timeout) {
>   			top_val = i;
>   			break;
>   		}
> @@ -123,33 +121,34 @@ static int dw_wdt_set_top(unsigned top_s)
>   	 * effectively get a pat of the watchdog right here.
>   	 */
>   	writel(top_val | top_val << WDOG_TIMEOUT_RANGE_TOPINIT_SHIFT,
> -		dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
> +		wdev->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
>
>   	/*
>   	 * Add an explicit pat to handle versions of the watchdog that
>   	 * don't have TOPINIT.  This won't hurt on versions that have
>   	 * it.
>   	 */
> -	dw_wdt_keepalive();
> -
> -	dw_wdt_set_next_heartbeat();
> +	dw_wdt_ping(wdog);
>
> -	return dw_wdt_top_in_seconds(top_val);
> +	return 0;
>   }
>
>   static int dw_wdt_restart_handle(struct notifier_block *this,
>   				unsigned long mode, void *cmd)
>   {
>   	u32 val;
> +	struct dw_wdt_device *wdev = container_of(this,
> +						  struct dw_wdt_device,
> +						  restart_handler);
>
> -	writel(0, dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
> -	val = readl(dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
> +	writel(0, wdev->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
> +	val = readl(wdev->regs + WDOG_CONTROL_REG_OFFSET);
>   	if (val & WDOG_CONTROL_REG_WDT_EN_MASK)
> -		writel(WDOG_COUNTER_RESTART_KICK_VALUE, dw_wdt.regs +
> +		writel(WDOG_COUNTER_RESTART_KICK_VALUE, wdev->regs +
>   			WDOG_COUNTER_RESTART_REG_OFFSET);
>   	else
>   		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
> -		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
> +		       wdev->regs + WDOG_CONTROL_REG_OFFSET);
>
>   	/* wait for reset to assert... */
>   	mdelay(500);
> @@ -157,74 +156,52 @@ static int dw_wdt_restart_handle(struct notifier_block *this,
>   	return NOTIFY_DONE;
>   }
>
> -static void dw_wdt_ping(unsigned long data)
> +static void dw_wdt_timer_ping(unsigned long arg)
>   {
> -	if (time_before(jiffies, dw_wdt.next_heartbeat) ||
> -	    (!nowayout && !dw_wdt.in_use)) {
> -		dw_wdt_keepalive();
> -		mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
> -	} else
> -		pr_crit("keepalive missed, machine will reset\n");
> +	struct watchdog_device *wdog = (struct watchdog_device *)arg;
> +	struct dw_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +
> +	/* ping it every wdog->timeout / 2 seconds to prevent reboot */
> +	dw_wdt_ping(wdog);
> +	mod_timer(&wdev->timer, jiffies + wdog->timeout * HZ / 2);
>   }
>
> -static int dw_wdt_open(struct inode *inode, struct file *filp)
> +static int dw_wdt_start(struct watchdog_device *wdog)
>   {
> -	if (test_and_set_bit(0, &dw_wdt.in_use))
> -		return -EBUSY;
> -
> -	/* Make sure we don't get unloaded. */
> -	__module_get(THIS_MODULE);
> -
> -	if (!dw_wdt_is_enabled()) {
> -		/*
> -		 * The watchdog is not currently enabled. Set the timeout to
> -		 * something reasonable and then start it.
> -		 */
> -		dw_wdt_set_top(DW_WDT_DEFAULT_SECONDS);
> +	struct dw_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +
> +	if (!dw_wdt_is_enabled(wdev)) {
> +		dw_wdt_set_timeout(wdog, wdog->timeout);
>   		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
> -		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
> +		       wdev->regs + WDOG_CONTROL_REG_OFFSET);
> +	} else {
> +		/* delete the timer that pings the watchdog after close */
> +		del_timer_sync(&wdev->timer);
> +		dw_wdt_set_timeout(wdog, wdog->timeout);
>   	}
>
> -	dw_wdt_set_next_heartbeat();
> -
> -	return nonseekable_open(inode, filp);
> +	return 0;
>   }
>
> -static ssize_t dw_wdt_write(struct file *filp, const char __user *buf,
> -			    size_t len, loff_t *offset)
> +static int dw_wdt_stop(struct watchdog_device *wdog)
>   {
> -	if (!len)
> -		return 0;
> -
> -	if (!nowayout) {
> -		size_t i;
> -
> -		dw_wdt.expect_close = 0;
> -
> -		for (i = 0; i < len; ++i) {
> -			char c;
> -
> -			if (get_user(c, buf + i))
> -				return -EFAULT;
> -
> -			if (c == 'V') {
> -				dw_wdt.expect_close = 1;
> -				break;
> -			}
> -		}
> -	}
> -
> -	dw_wdt_set_next_heartbeat();
> -	dw_wdt_keepalive();
> -	mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
> -
> -	return len;
> +	/*
> +	 * We don't need a clk_disable_unprepare, the wdt cannot be disabled
> +	 * once started. We use a timer to ping the watchdog while the
> +	 * /dev/watchdog is closed
> +	 */
> +	dw_wdt_timer_ping((unsigned long)wdog);
> +	return 0;
>   }
>
> -static u32 dw_wdt_time_left(void)
> +static inline void dw_wdt_ping_if_active(struct watchdog_device *wdog)
>   {
> -	return readl(dw_wdt.regs + WDOG_CURRENT_COUNT_REG_OFFSET) /
> -		clk_get_rate(dw_wdt.clk);
> +	struct dw_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +
> +	if (dw_wdt_is_enabled(wdev)) {
> +		dw_wdt_set_timeout(wdog, wdog->timeout);
> +		dw_wdt_timer_ping((unsigned long)wdog);
> +	}
>   }
>
>   static const struct watchdog_info dw_wdt_ident = {
> @@ -233,78 +210,37 @@ static const struct watchdog_info dw_wdt_ident = {
>   	.identity	= "Synopsys DesignWare Watchdog",
>   };
>
> -static long dw_wdt_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> -{
> -	unsigned long val;
> -	int timeout;
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		return copy_to_user((void __user *)arg, &dw_wdt_ident,
> -				    sizeof(dw_wdt_ident)) ? -EFAULT : 0;
> -
> -	case WDIOC_GETSTATUS:
> -	case WDIOC_GETBOOTSTATUS:
> -		return put_user(0, (int __user *)arg);
> -
> -	case WDIOC_KEEPALIVE:
> -		dw_wdt_set_next_heartbeat();
> -		return 0;
> -
> -	case WDIOC_SETTIMEOUT:
> -		if (get_user(val, (int __user *)arg))
> -			return -EFAULT;
> -		timeout = dw_wdt_set_top(val);
> -		return put_user(timeout , (int __user *)arg);
> -
> -	case WDIOC_GETTIMEOUT:
> -		return put_user(dw_wdt_get_top(), (int __user *)arg);
> -
> -	case WDIOC_GETTIMELEFT:
> -		/* Get the time left until expiry. */
> -		if (get_user(val, (int __user *)arg))
> -			return -EFAULT;
> -		return put_user(dw_wdt_time_left(), (int __user *)arg);
> -
> -	default:
> -		return -ENOTTY;
> -	}
> -}
> -
> -static int dw_wdt_release(struct inode *inode, struct file *filp)
> -{
> -	clear_bit(0, &dw_wdt.in_use);
> -
> -	if (!dw_wdt.expect_close) {
> -		del_timer(&dw_wdt.timer);
> -
> -		if (!nowayout)
> -			pr_crit("unexpected close, system will reboot soon\n");
> -		else
> -			pr_crit("watchdog cannot be disabled, system will reboot soon\n");
> -	}
> -
> -	dw_wdt.expect_close = 0;
> -
> -	return 0;
> -}
> +static const struct watchdog_ops dw_wdt_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= dw_wdt_start,
> +	.stop		= dw_wdt_stop,
> +	.ping		= dw_wdt_ping,
> +	.set_timeout	= dw_wdt_set_timeout,
> +	.get_timeleft	= dw_wdt_get_timeleft,
> +};
>
>   #ifdef CONFIG_PM_SLEEP
>   static int dw_wdt_suspend(struct device *dev)
>   {
> -	clk_disable_unprepare(dw_wdt.clk);
> +	struct watchdog_device *wdog = dev_get_drvdata(dev);
> +	struct dw_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +
> +	clk_disable_unprepare(wdev->clk);
>
>   	return 0;
>   }
>
>   static int dw_wdt_resume(struct device *dev)
>   {
> -	int err = clk_prepare_enable(dw_wdt.clk);
> +	struct watchdog_device *wdog = dev_get_drvdata(dev);
> +	struct dw_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +
> +	int err = clk_prepare_enable(wdev->clk);
>
>   	if (err)
>   		return err;
>
> -	dw_wdt_keepalive();
> +	dw_wdt_ping(wdog);
>
>   	return 0;
>   }
> @@ -312,67 +248,75 @@ static int dw_wdt_resume(struct device *dev)
>
>   static SIMPLE_DEV_PM_OPS(dw_wdt_pm_ops, dw_wdt_suspend, dw_wdt_resume);
>
> -static const struct file_operations wdt_fops = {
> -	.owner		= THIS_MODULE,
> -	.llseek		= no_llseek,
> -	.open		= dw_wdt_open,
> -	.write		= dw_wdt_write,
> -	.unlocked_ioctl	= dw_wdt_ioctl,
> -	.release	= dw_wdt_release
> -};
> -
> -static struct miscdevice dw_wdt_miscdev = {
> -	.fops		= &wdt_fops,
> -	.name		= "watchdog",
> -	.minor		= WATCHDOG_MINOR,
> -};
> -
>   static int dw_wdt_drv_probe(struct platform_device *pdev)
>   {
>   	int ret;
> -	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	dw_wdt.regs = devm_ioremap_resource(&pdev->dev, mem);
> -	if (IS_ERR(dw_wdt.regs))
> -		return PTR_ERR(dw_wdt.regs);
> -
> -	dw_wdt.clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(dw_wdt.clk))
> -		return PTR_ERR(dw_wdt.clk);
> -
> -	ret = clk_prepare_enable(dw_wdt.clk);
> +	struct dw_wdt_device *wdev;
> +	struct watchdog_device *wdog;
> +	struct resource *mem;
> +
> +	wdev = devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
> +	if (!wdev)
> +		return -ENOMEM;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	wdev->regs = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(wdev->regs))
> +		return PTR_ERR(wdev->regs);
> +
> +	wdev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(wdev->clk))
> +		return PTR_ERR(wdev->clk);
> +
> +	wdog			= &wdev->wdog;
> +	wdog->info		= &dw_wdt_ident;
> +	wdog->ops		= &dw_wdt_ops;
> +	wdog->min_timeout	= dw_wdt_top_in_seconds(wdev, 0);
> +	wdog->max_timeout	= dw_wdt_top_in_seconds(wdev, DW_WDT_MAX_TOP);
> +
> +	ret = clk_prepare_enable(wdev->clk);
>   	if (ret)
>   		return ret;
>
> -	ret = misc_register(&dw_wdt_miscdev);
> -	if (ret)
> -		goto out_disable_clk;
> +	platform_set_drvdata(pdev, wdog);
> +	watchdog_set_drvdata(wdog, wdev);
> +	watchdog_set_nowayout(wdog, nowayout);
> +	watchdog_init_timeout(wdog, wdog->max_timeout, &pdev->dev);
>
> -	dw_wdt.restart_handler.notifier_call = dw_wdt_restart_handle;
> -	dw_wdt.restart_handler.priority = 128;
> -	ret = register_restart_handler(&dw_wdt.restart_handler);
> +	wdev->restart_handler.notifier_call = dw_wdt_restart_handle;
> +	wdev->restart_handler.priority = 128;
> +	ret = register_restart_handler(&wdev->restart_handler);
>   	if (ret)
> -		pr_warn("cannot register restart handler\n");
> +		dev_warn(&pdev->dev, "cannot register restart handler\n");
>
> -	dw_wdt_set_next_heartbeat();
> -	setup_timer(&dw_wdt.timer, dw_wdt_ping, 0);
> -	mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
> +	setup_timer(&wdev->timer, dw_wdt_timer_ping, (unsigned long)wdog);
> +
> +	dw_wdt_ping_if_active(wdog);
> +
> +	ret = watchdog_register_device(wdog);
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot register watchdog device\n");
> +		goto out_disable_clk;
> +	}
>
>   	return 0;
>
>   out_disable_clk:
> -	clk_disable_unprepare(dw_wdt.clk);
> +	clk_disable_unprepare(wdev->clk);
>
>   	return ret;
>   }
>
>   static int dw_wdt_drv_remove(struct platform_device *pdev)
>   {
> -	unregister_restart_handler(&dw_wdt.restart_handler);
> +	struct watchdog_device *wdog = platform_get_drvdata(pdev);
> +	struct dw_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +
> +	unregister_restart_handler(&wdev->restart_handler);
>
> -	misc_deregister(&dw_wdt_miscdev);
> +	watchdog_unregister_device(wdog);
>
> -	clk_disable_unprepare(dw_wdt.clk);
> +	clk_disable_unprepare(wdev->clk);
>
>   	return 0;
>   }
>

