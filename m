Return-path: <baruch@tkos.co.il>
Date: Sun, 22 Mar 2015 20:08:57 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] watchdog: digicolor: driver for Conexant Digicolor
 CX92755 SoC
Message-ID: <20150322180857.GI2825@tarshish>
References: <6bc6e867b500cd3cfc629b96f90442f5c0aced3a.1427028036.git.baruch@tkos.co.il>
 <409ece75204d3911dc526a9bc0c908fc30893b26.1427028036.git.baruch@tkos.co.il>
 <550EF4DA.6040407@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550EF4DA.6040407@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On Sun, Mar 22, 2015 at 09:59:06AM -0700, Guenter Roeck wrote:
> On 03/22/2015 05:40 AM, Baruch Siach wrote:
> >This commit add a driver for the watchdog functionality of the Conexant CX92755
> >SoC, from the Digicolor series of SoCs. Of 8 system timers provided by the
> >CX92755, the first one, timer A, can reset the chip when its counter reaches
> >zero. This driver uses this capability to provide userspace with a standard
> >watchdog, using the watchdog timer driver core framework. This driver also
> >implements a reboot handler for the reboot(2) system call.
> >
> >The watchdog driver shares the timer registers with the CX92755 timer driver
> >(drivers/clocksource/timer-digicolor.c). The timer driver, however, uses only
> >timers other than A, so both drivers should coexist.
> >
> >Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> 
> Looks pretty good. Couple of comments below.

Thanks. Please see my responses below.

> >  drivers/watchdog/Kconfig         |  10 ++
> >  drivers/watchdog/Makefile        |   1 +
> >  drivers/watchdog/digicolor_wdt.c | 203 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 214 insertions(+)
> >  create mode 100644 drivers/watchdog/digicolor_wdt.c
> >
> >diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >index 16f202350997..7d73d6c78cf6 100644
> >--- a/drivers/watchdog/Kconfig
> >+++ b/drivers/watchdog/Kconfig
> >@@ -515,6 +515,16 @@ config MEDIATEK_WATCHDOG
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called mtk_wdt.
> >
> >+config DIGICOLOR_WATCHDOG
> >+	tristate "Conexant Digicolor SoCs watchdog support"
> >+	depends on ARCH_DIGICOLOR
> >+	select WATCHDOG_CORE
> 
> This doesn't (directly) depend on HAVE_CLK, meaning clk_get can return NULL
> if HAVE_CLK is not configured. Can that happen ?

ARCH_DIGICOLOR depends on ARCH_MULTI_V7 which depends on ARCH_MULTIPLATFORM, 
which in turn selects COMMON_CLK. So using the clk API should be safe.

[...]

> >+#define DC_WDT_DEFAULT_TIME	5
> 
> Five seconds is an extremely low default timeout. More common would be
> 30 or 60 seconds. Any special reason for selecting this default ?

I copied this value from an old Conexant provided watchdog driver, so I 
thought it should be a safe default. In fact, the RTC timer is clocked at 
200MHz by default, and since the counter is only 32bit wide, we can't set 
timeout much longer than 20 seconds anyway.

[...]

> >+static int dc_wdt_start(struct watchdog_device *wdog)
> >+{
> >+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
> >+	unsigned long flags;
> >+
> >+	spin_lock_irqsave(&wdt->lock, flags);
> >+
> >+	writel_relaxed(0, wdt->base + TIMER_A_CONTROL);
> >+	writel_relaxed(wdog->timeout * clk_get_rate(wdt->clk),
> >+		       wdt->base + TIMER_A_COUNT);
> >+	writel_relaxed(TIMER_A_ENABLE_COUNT | TIMER_A_ENABLE_WATCHDOG,
> >+		       wdt->base + TIMER_A_CONTROL);
> >+
> >+	spin_unlock_irqrestore(&wdt->lock, flags);
> >+
> You have this sequence twice, so a little helper function taking
> wdt and the timeout as parameters might be useful.

Right. Will do.

> >+	return 0;
> >+}
> >+
> >+static int dc_wdt_stop(struct watchdog_device *wdog)
> >+{
> >+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
> >+
> >+	writel_relaxed(0, wdt->base + TIMER_A_CONTROL);
> >+
> >+	return 0;
> >+}
> >+
> >+static int dc_wdt_set_timeout(struct watchdog_device *wdog, unsigned int t)
> >+{
> >+	wdog->timeout = t;
> >+
> No updating the timer count register ?
> 
> If you increase the timeout significantly, the next ping may come too late.

Some other drivers are doing the same (e.g. bcm2835_wdt, orion_wdt). Are they 
buggy? Will fix, anyway.

> >+	return 0;
> >+}
> >+
> >+static unsigned int dc_wdt_get_timeleft(struct watchdog_device *wdog)
> >+{
> >+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
> >+	uint32_t count = readl_relaxed(wdt->base + TIMER_A_COUNT);
> >+
> >+	return (count / clk_get_rate(wdt->clk));
> >+}
> >+
> >+static struct watchdog_ops dc_wdt_ops = {
> >+	.owner		= THIS_MODULE,
> >+	.start		= dc_wdt_start,
> >+	.stop		= dc_wdt_stop,
> 
> Since you don't have a ping function, each ping will stop the watchdog,
> update the timer, and restart it. Is this intentional ?

No. Just copied other drivers. I guess I can set .ping to dc_wdt_start as 
well.

[...]

> >+static int dc_wdt_probe(struct platform_device *pdev)
> >+{
> >+	struct device *dev = &pdev->dev;
> >+	struct device_node *np = dev->of_node;
> >+	struct dc_wdt *wdt;
> >+	int ret;
> >+
> >+	wdt = devm_kzalloc(dev, sizeof(struct dc_wdt), GFP_KERNEL);
> >+	if (!wdt)
> >+		return -ENOMEM;
> >+	platform_set_drvdata(pdev, wdt);
> >+
> >+	wdt->base = of_iomap(np, 0);
> >+	if (!wdt->base) {
> >+		dev_err(dev, "Failed to remap watchdog regs");
> >+		return -ENODEV;
> >+	}
> >+
> >+	wdt->clk = clk_get(&pdev->dev, NULL);
> >+	if (IS_ERR(wdt->clk))
> >+		return PTR_ERR(wdt->clk);
> 
> iounmap missing.

Will fix.

> >+	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
> >+
> >+	spin_lock_init(&wdt->lock);
> >+
> >+	watchdog_set_drvdata(&dc_wdt_wdd, wdt);
> >+	watchdog_init_timeout(&dc_wdt_wdd, timeout, dev);
> >+	ret = watchdog_register_device(&dc_wdt_wdd);
> >+	if (ret) {
> >+		dev_err(dev, "Failed to register watchdog device");
> >+		iounmap(wdt->base);
> 
> I don't see clk_put in any of the error cases. How about using devm_clk_get above ?

Will fix.

> 
> >+		return ret;
> >+	}
> >+
> >+	wdt->restart_handler.notifier_call = dc_restart_handler;
> >+	wdt->restart_handler.priority = 128;
> 
> Is 128 intentional, ie is this the expected reset method for this platform ?
> If not, it may be better to select a lower priority (eg 64). Using a watchdog
> to reset a system should in general be a method of last resort.

Copied this value from imx2_wdt. grep indicates that almost all other watchdog 
drivers implementing restart_handler use priority of 128 (except bcm47xx_wdt). 
What is the policy here?

> 
> >+	ret = register_restart_handler(&wdt->restart_handler);
> >+	if (ret)
> >+		dev_err(&pdev->dev, "cannot register restart handler\n");
> 
> dev_warn would be better here, since this is non-fatal.

Again, copied from imx2_wdt. But I'll fix that anyway.

> >+	return 0;
> >+}
> >+
> >+static int dc_wdt_remove(struct platform_device *pdev)
> >+{
> >+	struct dc_wdt *wdt = platform_get_drvdata(pdev);
> >+
> >+	unregister_restart_handler(&wdt->restart_handler);
> >+	watchdog_unregister_device(&dc_wdt_wdd);
> >+	iounmap(wdt->base);
> 
> clk_put missing (or use devm_clk_get).

Will fix.

Thanks for reviewing.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
