Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51228 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750824AbbCBJSY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Mar 2015 04:18:24 -0500
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
	Mike Turquette <mturquette@linaro.org>,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 1/6] PM / wakeup: export pm_system_wakeup symbol
Date: Mon,  2 Mar 2015 10:18:13 +0100
Message-Id: <1425287898-15093-2-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Export pm_system_wakeup function to allow irq handlers to deal with system
wakeup.
This is needed for shared IRQ lines where one of the handler is registered
with IRQF_NO_SUSPEND, while the other ones want to configure it as a wakeup
source.
In this specific case, irq core does not handle the wakeup process and
leave the decision to each irq handler.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/base/power/wakeup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index c2744b3..aab7158 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -730,6 +730,7 @@ void pm_system_wakeup(void)
 	pm_abort_suspend = true;
 	freeze_wake();
 }
+EXPORT_SYMBOL_GPL(pm_system_wakeup);
 
 void pm_wakeup_clear(void)
 {
-- 
1.9.1

