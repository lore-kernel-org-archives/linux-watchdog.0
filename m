Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:57864 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbbJQS2W (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 17 Oct 2015 14:28:22 -0400
From: Vladimir Zapolskiy <vz@mleia.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: pnx4008: fix warnings caused by enabling unprepared clock
Date: Sat, 17 Oct 2015 21:28:16 +0300
Message-Id: <1445106496-2074-1-git-send-email-vz@mleia.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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
---
 drivers/watchdog/pnx4008_wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 4224b3e..35319a4 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
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
-- 
2.1.4

