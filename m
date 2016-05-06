Return-path: <falakreyaz@gmail.com>
From: Muhammad Falak R Wani <falakreyaz@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] watchdog: cpwd: Use setup_timer()
Date: Fri,  6 May 2016 18:29:40 +0530
Message-Id: <1462539581-26207-1-git-send-email-falakreyaz@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

The function setup_timer combines the initialization of a timer with
the initialization of the timer's function and data fields.
The multiline code for timer initialization is now replaced
with function setup_timer.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/watchdog/cpwd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 0200768..71ee079 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -611,9 +611,7 @@ static int cpwd_probe(struct platform_device *op)
 	}
 
 	if (p->broken) {
-		init_timer(&cpwd_timer);
-		cpwd_timer.function	= cpwd_brokentimer;
-		cpwd_timer.data		= (unsigned long) p;
+		setup_timer(&cpwd_timer, cpwd_brokentimer, (unsigned long)p);
 		cpwd_timer.expires	= WD_BTIMEOUT;
 
 		pr_info("PLD defect workaround enabled for model %s\n",
-- 
1.9.1
