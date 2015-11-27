Return-path: <wimvs@spo001.leaseweb.nl>
Date: Fri, 27 Nov 2015 22:36:04 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Nicolas Boichat <drinkcat@chromium.org>,
	Shaohui Xie <Shaohui.Xie@freescale.com>,
	Andrew Chew <achew@nvidia.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL REQUEST] watchdog - v4.4-rc3 Fixes
Message-ID: <20151127213604.GA7720@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

It contains:
* a null pointer dereference fix for omap_wdt
* some clock related fixes for pnx4008
* an underflow fix in wdt_set_timeout() for w83977f_wdt
* restart fix for tegra wdt
* Kconfig change to support Freescale Layerscape platforms
* Fix for stopping the mtk_wdt watchdog

This will update the following files:

 Kconfig       |    2 +-
 mtk_wdt.c     |    1 +
 omap_wdt.c    |    2 +-
 pnx4008_wdt.c |    8 ++++----
 tegra_wdt.c   |    4 +++-
 w83977f_wdt.c |    2 +-
 6 files changed, 11 insertions(+), 8 deletions(-)

with these Changes:

commit 5da2bf1ac8fbe701a138efb340b9f2ef26c10ed7
Author: Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed Nov 18 10:45:01 2015 +0800

    watchdog: mtk_wdt: Use MODE_KEY when stopping the watchdog
    
    WDT_MODE value need to be or-ed with MODE_KEY when setting
    watchdog mode. Add it to mtk_wdt_stop function, so that the
    watchdog can be stopped (e.g. during suspend).
    
    Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
    Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 646251a59c73253a7a2c7b1d6adbedd2292390a0
Author: Shaohui Xie <Shaohui.Xie@freescale.com>
Date:   Tue Nov 17 17:53:19 2015 +0800

    watchdog: Add support for Freescale Layerscape platforms
    
    Modify watchdog/Kconfig file to support Layerscape platforms.
    
    Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
    Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
    Acked-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0879eee13f9cf79793ce88fb41bf0dd2a51093c0
Author: Andrew Chew <achew@nvidia.com>
Date:   Mon Nov 9 16:11:38 2015 -0800

    watchdog: tegra: Stop watchdog first if restarting
    
    If we need to restart the watchdog due to someone changing the timeout
    interval, stop the watchdog before restarting it.  Otherwise, the new
    timeout doesn't seem to take.
    
    Signed-off-by: Andrew Chew <achew@nvidia.com>
    Reviewed-by: Thierry Reding <treding@nvidia.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 62ed853c7de7a77bdf01421fb6836269c9b1aa1f
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Fri Nov 6 12:56:31 2015 +0300

    watchdog: w83977f_wdt: underflow in wdt_set_timeout()
    
    "t" is controlled by the user.  If "t" is a very large integer then it
    could lead to a negative "tmrval".  We cap the upper bound of "tmrval"
    but, in the current code, we allow negatives.  This is a bug and it
    causes a static checker warning.  Let's make "tmrval" unsigned to avoid
    this problem.
    
    Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 4c30737ce16612b0f3b840a7c9928385cbb67555
Author: Vladimir Zapolskiy <vz@mleia.com>
Date:   Wed Oct 28 02:55:35 2015 +0200

    watchdog: pnx4008: make global wdt_clk static
    
    Silences sparse warning:
    
      drivers/watchdog/pnx4008_wdt.c:83:25:
        warning: symbol 'wdt_clk' was not declared. Should it be static?
    
    Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b647d4297234e7f5456c16635ca0cdd82b7055db
Author: Vladimir Zapolskiy <vz@mleia.com>
Date:   Sat Oct 17 21:28:16 2015 +0300

    watchdog: pnx4008: fix warnings caused by enabling unprepared clock
    
    If common clock framework is configured, the driver generates a warning,
    which is fixed by this change:
    
        WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:727 clk_core_enable+0x2c/0xa4()
        Modules linked in:
        CPU: 0 PID: 1 Comm: swapper Tainted: G        W       4.3.0-rc2+ #171
        Hardware name: LPC32XX SoC (Flattened Device Tree)
        Backtrace:
        [<>] (dump_backtrace) from [<>] (show_stack+0x18/0x1c)
        [<>] (show_stack) from [<>] (dump_stack+0x20/0x28)
        [<>] (dump_stack) from [<>] (warn_slowpath_common+0x90/0xb8)
        [<>] (warn_slowpath_common) from [<>] (warn_slowpath_null+0x24/0x2c)
        [<>] (warn_slowpath_null) from [<>] (clk_core_enable+0x2c/0xa4)
        [<>] (clk_core_enable) from [<>] (clk_enable+0x24/0x38)
        [<>] (clk_enable) from [<>] (pnx4008_wdt_probe+0x78/0x11c)
        [<>] (pnx4008_wdt_probe) from [<>] (platform_drv_probe+0x50/0xa0)
        [<>] (platform_drv_probe) from [<>] (driver_probe_device+0x18c/0x408)
        [<>] (driver_probe_device) from [<>] (__driver_attach+0x70/0x94)
        [<>] (__driver_attach) from [<>] (bus_for_each_dev+0x74/0x98)
        [<>] (bus_for_each_dev) from [<>] (driver_attach+0x20/0x28)
        [<>] (driver_attach) from [<>] (bus_add_driver+0x11c/0x248)
        [<>] (bus_add_driver) from [<>] (driver_register+0xa4/0xe8)
        [<>] (driver_register) from [<>] (__platform_driver_register+0x50/0x64)
        [<>] (__platform_driver_register) from [<>] (platform_wdt_driver_init+0x18/0x20)
        [<>] (platform_wdt_driver_init) from [<>] (do_one_initcall+0x11c/0x1dc)
        [<>] (do_one_initcall) from [<>] (kernel_init_freeable+0x10c/0x1d4)
        [<>] (kernel_init_freeable) from [<>] (kernel_init+0x10/0xec)
        [<>] (kernel_init) from [<>] (ret_from_fork+0x14/0x24)
    
    Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit de55acd100993c70bb7c5ca9473b59cdc4debb20
Author: Peter Robinson <pbrobinson@gmail.com>
Date:   Mon Nov 2 02:20:20 2015 +0000

    watchdog: omap_wdt: fix null pointer dereference
    
    Fix issue from two patches overlapping causing a kernel oops
    
    [ 3569.297449] Unable to handle kernel NULL pointer dereference at virtual address 00000088
    [ 3569.306272] pgd = dc894000
    [ 3569.309287] [00000088] *pgd=00000000
    [ 3569.313104] Internal error: Oops: 5 [#1] SMP ARM
    [ 3569.317986] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_filter ebtable_nat ebtable_broute bridge stp llc ebtables ip6table_security ip6table_raw ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_filter ip6_tables iptable_security iptable_raw iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle musb_dsps cppi41 musb_hdrc phy_am335x udc_core phy_generic phy_am335x_control omap_sham omap_aes omap_rng omap_hwspinlock omap_mailbox hwspinlock_core musb_am335x omap_wdt at24 8250_omap leds_gpio cpufreq_dt smsc davinci_mdio mmc_block ti_cpsw cpsw_common ptp pps_core cpsw_ale davinci_cpdma omap_hsmmc omap_dma mmc_core i2c_dev
    [ 3569.386293] CPU: 0 PID: 1429 Comm: wdctl Not tainted 4.3.0-0.rc7.git0.1.fc24.armv7hl #1
    [ 3569.394740] Hardware name: Generic AM33XX (Flattened Device Tree)
    [ 3569.401179] task: dbd11a00 ti: dbaac000 task.ti: dbaac000
    [ 3569.406917] PC is at omap_wdt_get_timeleft+0xc/0x20 [omap_wdt]
    [ 3569.413106] LR is at watchdog_ioctl+0x3cc/0x42c
    [ 3569.417902] pc : [<bf0ab138>]    lr : [<c0739c54>]    psr: 600f0013
    [ 3569.417902] sp : dbaadf18  ip : 00000003  fp : 7f5d3bbe
    [ 3569.430014] r10: 00000000  r9 : 00000003  r8 : bef21ab8
    [ 3569.435535] r7 : dbbc0f7c  r6 : dbbc0f18  r5 : bef21ab8  r4 : 00000000
    [ 3569.442427] r3 : 00000000  r2 : 00000000  r1 : 8004570a  r0 : dbbc0f18
    [ 3569.449323] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
    [ 3569.456858] Control: 10c5387d  Table: 9c894019  DAC: 00000051
    [ 3569.462927] Process wdctl (pid: 1429, stack limit = 0xdbaac220)
    [ 3569.469179] Stack: (0xdbaadf18 to 0xdbaae000)
    [ 3569.473790] df00:                                                       bef21ab8 dbf60e38
    [ 3569.482441] df20: dc91b840 8004570a bef21ab8 c03988a4 dbaadf48 dc854000 00000000 dd313850
    [ 3569.491092] df40: ddf033b8 0000570a dc91b80b dbaadf3c dbf60e38 00000020 c0df9250 c0df6c48
    [ 3569.499741] df60: dc91b840 8004570a 00000000 dc91b840 dc91b840 8004570a bef21ab8 00000003
    [ 3569.508389] df80: 00000000 c03989d4 bef21b74 7f5d3bad 00000003 00000036 c020fcc4 dbaac000
    [ 3569.517037] dfa0: 00000000 c020fb00 bef21b74 7f5d3bad 00000003 8004570a bef21ab8 00000001
    [ 3569.525685] dfc0: bef21b74 7f5d3bad 00000003 00000036 00000001 00000000 7f5e4eb0 7f5d3bbe
    [ 3569.534334] dfe0: 7f5e4f10 bef21a3c 7f5d0a54 b6e97e0c a00f0010 00000003 00000000 00000000
    [ 3569.543038] [<bf0ab138>] (omap_wdt_get_timeleft [omap_wdt]) from [<c0739c54>] (watchdog_ioctl+0x3cc/0x42c)
    [ 3569.553266] [<c0739c54>] (watchdog_ioctl) from [<c03988a4>] (do_vfs_ioctl+0x5bc/0x698)
    [ 3569.561648] [<c03988a4>] (do_vfs_ioctl) from [<c03989d4>] (SyS_ioctl+0x54/0x7c)
    [ 3569.569400] [<c03989d4>] (SyS_ioctl) from [<c020fb00>] (ret_fast_syscall+0x0/0x3c)
    [ 3569.577413] Code: e12fff1e e52de004 e8bd4000 e5903060 (e5933088)
    [ 3569.584089] ---[ end trace cec3039bd3ae610a ]---
    
    Cc: <stable@vger.kernel.org> # v4.2+
    Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
    Acked-by: Lars Poeschel <poeschel@lemonage.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7a8a6c6..1c427be 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -446,7 +446,7 @@ config MAX63XX_WATCHDOG
 
 config IMX2_WDT
 	tristate "IMX2+ Watchdog"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || ARCH_LAYERSCAPE
 	select REGMAP_MMIO
 	select WATCHDOG_CORE
 	help
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 6ad9df9..b751f43 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -123,6 +123,7 @@ static int mtk_wdt_stop(struct watchdog_device *wdt_dev)
 
 	reg = readl(wdt_base + WDT_MODE);
 	reg &= ~WDT_MODE_EN;
+	reg |= WDT_MODE_KEY;
 	iowrite32(reg, wdt_base + WDT_MODE);
 
 	return 0;
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index d96bee0..6f17c93 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -205,7 +205,7 @@ static int omap_wdt_set_timeout(struct watchdog_device *wdog,
 
 static unsigned int omap_wdt_get_timeleft(struct watchdog_device *wdog)
 {
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 	void __iomem *base = wdev->base;
 	u32 value;
 
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 4224b3e..313cd1c 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -80,7 +80,7 @@ static unsigned int heartbeat = DEFAULT_HEARTBEAT;
 
 static DEFINE_SPINLOCK(io_lock);
 static void __iomem	*wdt_base;
-struct clk		*wdt_clk;
+static struct clk	*wdt_clk;
 
 static int pnx4008_wdt_start(struct watchdog_device *wdd)
 {
@@ -161,7 +161,7 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt_clk))
 		return PTR_ERR(wdt_clk);
 
-	ret = clk_enable(wdt_clk);
+	ret = clk_prepare_enable(wdt_clk);
 	if (ret)
 		return ret;
 
@@ -184,7 +184,7 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 	return 0;
 
 disable_clk:
-	clk_disable(wdt_clk);
+	clk_disable_unprepare(wdt_clk);
 	return ret;
 }
 
@@ -192,7 +192,7 @@ static int pnx4008_wdt_remove(struct platform_device *pdev)
 {
 	watchdog_unregister_device(&pnx4008_wdd);
 
-	clk_disable(wdt_clk);
+	clk_disable_unprepare(wdt_clk);
 
 	return 0;
 }
diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index 7f97cdd..9ec5760 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -140,8 +140,10 @@ static int tegra_wdt_set_timeout(struct watchdog_device *wdd,
 {
 	wdd->timeout = timeout;
 
-	if (watchdog_active(wdd))
+	if (watchdog_active(wdd)) {
+		tegra_wdt_stop(wdd);
 		return tegra_wdt_start(wdd);
+	}
 
 	return 0;
 }
diff --git a/drivers/watchdog/w83977f_wdt.c b/drivers/watchdog/w83977f_wdt.c
index 91bf55a..20e2bba 100644
--- a/drivers/watchdog/w83977f_wdt.c
+++ b/drivers/watchdog/w83977f_wdt.c
@@ -224,7 +224,7 @@ static int wdt_keepalive(void)
 
 static int wdt_set_timeout(int t)
 {
-	int tmrval;
+	unsigned int tmrval;
 
 	/*
 	 * Convert seconds to watchdog counter time units, rounding up.
