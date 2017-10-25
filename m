Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 Oct 2017 03:32:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: cpwd: Convert timers to use timer_setup()
Message-ID: <20171025103210.GA146019@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. Switches to using the global that is
used everywhere else.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/watchdog/cpwd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 3d43775548e5..aee0b25cf10d 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -230,9 +230,9 @@ static void cpwd_resetbrokentimer(struct cpwd *p, int index)
  * interrupts within the PLD so me must continually
  * reset the timers ad infinitum.
  */
-static void cpwd_brokentimer(unsigned long data)
+static void cpwd_brokentimer(struct timer_list *unused)
 {
-	struct cpwd *p = (struct cpwd *) data;
+	struct cpwd *p = cpwd_device;
 	int id, tripped = 0;
 
 	/* kill a running timer instance, in case we
@@ -275,7 +275,7 @@ static void cpwd_stoptimer(struct cpwd *p, int index)
 
 		if (p->broken) {
 			p->devs[index].runstatus |= WD_STAT_BSTOP;
-			cpwd_brokentimer((unsigned long) p);
+			cpwd_brokentimer(NULL);
 		}
 	}
 }
@@ -608,7 +608,7 @@ static int cpwd_probe(struct platform_device *op)
 	}
 
 	if (p->broken) {
-		setup_timer(&cpwd_timer, cpwd_brokentimer, (unsigned long)p);
+		timer_setup(&cpwd_timer, cpwd_brokentimer, 0);
 		cpwd_timer.expires	= WD_BTIMEOUT;
 
 		pr_info("PLD defect workaround enabled for model %s\n",
-- 
2.7.4


-- 
Kees Cook
Pixel Security
