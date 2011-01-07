Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41659 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316Ab1AGQnv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Jan 2011 11:43:51 -0500
Received: by iyi12 with SMTP id 12so15930429iyi.19
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Jan 2011 08:43:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1294401797-24158-1-git-send-email-jamie@jamieiles.com>
References: <1294401797-24158-1-git-send-email-jamie@jamieiles.com>
Date: Fri, 7 Jan 2011 22:13:50 +0530
Message-ID: <AANLkTi=s4Wuj1YyALL7f1AK-MQjvPre8mvviLhw5TdPH@mail.gmail.com>
Subject: Re: [PATCHv3] watchdog: add support for the Synopsys DesignWare WDT
From: viresh kumar <viresh.linux@gmail.com>
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jan 7, 2011 at 5:33 PM, Jamie Iles <jamie@jamieiles.com> wrote:

(...)

> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> new file mode 100644
> index 0000000..e0d0e377
> --- /dev/null
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -0,0 +1,300 @@

(...)

> +static inline int dw_wdt_is_enabled(void)
> +{
> +#define WDOG_CONTROL_REG_WDT_EN_MASK           0x01

can be moved to top, with other macros.

> +       return readl(dw_wdt.regs + WDOG_CONTROL_REG_OFFSET) &
> +               WDOG_CONTROL_REG_WDT_EN_MASK;
> +}
> +

(...)

> +static void dw_wdt_keepalive(void)
> +{
> +#define WDOG_COUNTER_RESTART_KICK_VALUE            0x76

ditto...

> +       writel(WDOG_COUNTER_RESTART_KICK_VALUE, dw_wdt.regs +
> +              WDOG_COUNTER_RESTART_REG_OFFSET);
> +}
> +
> +static int dw_wdt_open(struct inode *inode, struct file *filp)
> +{
> +       /* Make sure we don't get unloaded. */
> +       __module_get(THIS_MODULE);
> +
> +       spin_lock(&dw_wdt.lock);
> +       if (!dw_wdt_is_enabled()) {
> +               /*
> +                * The watchdog is not currently enabled. Set the timeout to
> +                * the maximum and then start it.
> +                */
> +               dw_wdt_set_top(DW_WDT_MAX_TOP);

shouldn't we check return value here??

> +               writel(WDOG_CONTROL_REG_WDT_EN_MASK,
> +                      dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
> +       }
> +       spin_unlock(&dw_wdt.lock);
> +
> +       return nonseekable_open(inode, filp);
> +}
> +

(...)

> +static const struct dev_pm_ops dw_wdt_pm_ops = {
> +       .suspend        = dw_wdt_suspend,
> +       .resume         = dw_wdt_resume,
> +};
> +
> +#define DW_WDT_PM_OPS  (&dw_wdt_pm_ops)
> +#else /* CONFIG_PM */
> +#define DW_WDT_PM_OPS  NULL
> +#endif /* CONFIG_PM */

This can be rewritten as:
static struct platform_driver dw_wdt_driver = {
...
+#ifdef CONFIG_PM
               .pm     = dw_wdt_pm_ops,
#endif
}

> +static int __devinit dw_wdt_drv_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +       if (!mem)
> +               return -EINVAL;
> +
> +       if (!devm_request_mem_region(&pdev->dev, mem->start, resource_size(mem),
> +                                    "iomem"))
> +               return -ENOMEM;
> +
> +       dw_wdt.regs = devm_ioremap(&pdev->dev, mem->start,
> +                                            resource_size(mem));
> +       if (!dw_wdt.regs)
> +               return -ENOMEM;

should release mem_region in case of error.

> +
> +       dw_wdt.clk = clk_get(&pdev->dev, NULL);
> +       if (IS_ERR_OR_NULL(dw_wdt.clk))
> +               return -ENODEV;

should release mem_region and free ioremaped space.
Also, may be we can continue here in case of error too.
Some platforms might nor support clock framework. You can enable and
disable clk's
if dw_wdt.clk is !NULL

> +       clk_enable(dw_wdt.clk);
> +
> +       ret = misc_register(&dw_wdt_miscdev);
> +       if (ret)
> +               goto register_failed;
> +
> +       return 0;
> +
> +register_failed:
> +       clk_disable(dw_wdt.clk);
> +       clk_put(dw_wdt.clk);

also iounmap and release_mem_region...

> +
> +       return ret;
> +}
> +
> +static int __devexit dw_wdt_drv_remove(struct platform_device *pdev)
> +{
> +       clk_disable(dw_wdt.clk);
> +       clk_put(dw_wdt.clk);
> +
> +       misc_deregister(&dw_wdt_miscdev);

also iounmap and release_mem_region...

> +
> +       return 0;
> +}
> +
> +static struct platform_driver dw_wdt_driver = {
> +       .probe          = dw_wdt_drv_probe,
> +       .remove         = __devexit_p(dw_wdt_drv_remove),
> +       .driver         = {
> +               .name   = "dw_wdt",
> +               .owner  = THIS_MODULE,
> +               .pm     = DW_WDT_PM_OPS,
> +       },
> +};
> +
> +static int __init dw_wdt_watchdog_init(void)
> +{
> +       spin_lock_init(&dw_wdt.lock);

This can be moved to probe. spin_lock_init should be only called when we have
some device for this driver.

> +
> +       return platform_driver_register(&dw_wdt_driver);
> +}
> +
> +static void __exit dw_wdt_watchdog_exit(void)
> +{
> +       platform_driver_unregister(&dw_wdt_driver);
> +}
> +
> +module_init(dw_wdt_watchdog_init);
> +module_exit(dw_wdt_watchdog_exit);

should be moved after init & exit routines without any blank lines.

--
viresh
ST Microelectronics
