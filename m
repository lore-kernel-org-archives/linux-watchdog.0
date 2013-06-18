Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:52256 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567Ab3FRPUx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 11:20:53 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so4109576pab.13
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 08:20:52 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wim@iguana.be
Cc: marc.zyngier@arm.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 01/14] watchdog/mpcore_wdt: Mark it as BROKEN
Date: Tue, 18 Jun 2013 20:50:25 +0530
Message-Id: <22d22fe6eea294c5132e47b8901e094d60b0e99d.1371535242.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This driver was broken since ever.

- Interrupt request doesn't use the right API: The TWD watchdog uses a per-cpu
  interrupt (usually interrupt #30), and the GIC configuration should flag it as
  such. With this setup, request_irq() should fail, and the right API is
  request_percpu_irq(), together with enable_percpu_irq()/disable_percpu_irq().

- Nothing ensures the userspace ioctl() will end-up kicking the watchdog on the
  right CPU.

Was last discussed here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-April/095960.html

Lets mark it broken until somebody with this hardware gets up and fixes it.

Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9d03af1..c7dabe9 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -223,7 +223,7 @@ config DW_WATCHDOG
 
 config MPCORE_WATCHDOG
 	tristate "MPcore watchdog"
-	depends on HAVE_ARM_TWD
+	depends on HAVE_ARM_TWD && BROKEN
 	help
 	  Watchdog timer embedded into the MPcore system.
 
-- 
1.7.12.rc2.18.g61b472e

