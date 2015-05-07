Return-path: <dianders@chromium.org>
From: Doug Anderson <dianders@chromium.org>
To: wim@iguana.be,
	linux@roeck-us.net
Cc: jszhang@marvell.com,
	Doug Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] watchdog: dw_wdt: keepalive the watchdog at write time
Date: Thu,  7 May 2015 15:09:24 -0700
Message-Id: <1431036564-4189-2-git-send-email-dianders@chromium.org>
In-Reply-To: <1431036564-4189-1-git-send-email-dianders@chromium.org>
References: <1431036564-4189-1-git-send-email-dianders@chromium.org>
List-ID: <linux-watchdog@vger.kernel.org>

If you've got code that does this in a tight loop
  1. Open watchdog
  2. Send 'expect close'
  3. Close watchdog
...you'll eventually trigger a watchdog reset.  You can reproduce this
by using daisydog (1) and running:
  while true; do daisydog -c > /dev/null; done

The problem is that each time you write to the watchdog for 'expect
close' it moves the timer .5 seconds out.  The timer thus never fires
and never pats the watchdog for you.

1: http://git.chromium.org/gitweb/?p=chromiumos/third_party/daisydog.git

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/watchdog/dw_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 3fa2f19..ff5d734 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -220,6 +220,7 @@ static ssize_t dw_wdt_write(struct file *filp, const char __user *buf,
 	}
 
 	dw_wdt_set_next_heartbeat();
+	dw_wdt_keepalive();
 	mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
 
 	return len;
-- 
2.2.0.rc0.207.ga3a616c
