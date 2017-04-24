Return-path: <mdf@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: moritz.fischer@ettus.com,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	wim@iguana.be,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	alex.williams@ni.com,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 2/2] rtc: ds1374: wdt: Fix stop/start ioctl always returning -EINVAL
Date: Mon, 24 Apr 2017 15:05:12 -0700
Message-Id: <1493071512-5718-3-git-send-email-mdf@kernel.org>
In-Reply-To: <1493071512-5718-1-git-send-email-mdf@kernel.org>
References: <1493071512-5718-1-git-send-email-mdf@kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Fix commit 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")

The WDIOC_SETOPTIONS case in the watchdog ioctl would alwayss falls
through to the -EINVAL case. This is wrong since thew watchdog does
actually get stopped or started correctly.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/rtc/rtc-ds1374.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 2a8b5b3..38a2e9e 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -546,14 +546,15 @@ static long ds1374_wdt_ioctl(struct file *file, unsigned int cmd,
 		if (options & WDIOS_DISABLECARD) {
 			pr_info("disable watchdog\n");
 			ds1374_wdt_disable();
+			return 0;
 		}
 
 		if (options & WDIOS_ENABLECARD) {
 			pr_info("enable watchdog\n");
 			ds1374_wdt_settimeout(wdt_margin);
 			ds1374_wdt_ping();
+			return 0;
 		}
-
 		return -EINVAL;
 	}
 	return -ENOTTY;
-- 
2.7.4
