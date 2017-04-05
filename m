Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] iTCO_wdt: all versions count down twice
Date: Wed,  5 Apr 2017 11:03:08 +0200
Message-Id: <20170405090308.10093-1-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

The ICH9 is listed as having TCO v2, and indeed the behavior in the
datasheet corresponds to v2 (for example the NO_REBOOT flag is
accessible via the 16KiB-aligned Root Complex Base Address).

However, the TCO counts twice just like in v1; the documentation
of the SECOND_TO_STS bit says: "ICH9 sets this bit to 1 to indicate
that the TIMEOUT bit had been (or is currently) set and a second
timeout occurred before the TCO_RLD register was written. If this
bit is set and the NO_REBOOT config bit is 0, then the ICH9 will
reboot the system after the second timeout.  The same can be found
in the BayTrail (Atom E3800) datasheet, and even HOWTOs around
the Internet say that it will reboot after _twice_ the specified
heartbeat.

I did not find the Apollo Lake datasheet, but because v4/v5 has
a SECOND_TO_STS bit just like the previous version I'm enabling
this for Apollo Lake as well.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/watchdog/watchdog-parameters.txt |  2 +-
 drivers/watchdog/iTCO_wdt.c                    | 23 ++++++++++-------------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 4f7d86dd0a5d..914518aeb972 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -117,7 +117,7 @@ nowayout: Watchdog cannot be stopped once started
 -------------------------------------------------
 iTCO_wdt:
 heartbeat: Watchdog heartbeat in seconds.
-	(2<heartbeat<39 (TCO v1) or 613 (TCO v2), default=30)
+	(5<=heartbeat<=74 (TCO v1) or 1226 (TCO v2), default=30)
 nowayout: Watchdog cannot be stopped once started
 	(default=kernel config parameter)
 -------------------------------------------------
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 3d0abc0d59b4..c9230a0cdc83 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -280,16 +280,15 @@ static int iTCO_wdt_ping(struct watchdog_device *wd_dev)
 
 	iTCO_vendor_pre_keepalive(p->smi_res, wd_dev->timeout);
 
+	/* Reset the timeout status bit so that the timer
+	 * needs to count down twice again before rebooting */
+	outw(0x0008, TCO1_STS(p));	/* write 1 to clear bit */
+
 	/* Reload the timer by writing to the TCO Timer Counter register */
-	if (p->iTCO_version >= 2) {
+	if (p->iTCO_version >= 2)
 		outw(0x01, TCO_RLD(p));
-	} else if (p->iTCO_version == 1) {
-		/* Reset the timeout status bit so that the timer
-		 * needs to count down twice again before rebooting */
-		outw(0x0008, TCO1_STS(p));	/* write 1 to clear bit */
-
+	else if (p->iTCO_version == 1)
 		outb(0x01, TCO_RLD(p));
-	}
 
 	spin_unlock(&p->io_lock);
 	return 0;
@@ -302,11 +301,8 @@ static int iTCO_wdt_set_timeout(struct watchdog_device *wd_dev, unsigned int t)
 	unsigned char val8;
 	unsigned int tmrval;
 
-	tmrval = seconds_to_ticks(p, t);
-
-	/* For TCO v1 the timer counts down twice before rebooting */
-	if (p->iTCO_version == 1)
-		tmrval /= 2;
+	/* The timer counts down twice before rebooting */
+	tmrval = seconds_to_ticks(p, t) / 2;
 
 	/* from the specs: */
 	/* "Values of 0h-3h are ignored and should not be attempted" */
@@ -359,8 +355,9 @@ static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
 		spin_lock(&p->io_lock);
 		val16 = inw(TCO_RLD(p));
 		val16 &= 0x3ff;
+		if (!(inw(TCO1_STS(p)) & 0x0008))
+			val16 += (inw(TCOv2_TMR(p)) & 0x3ff);
 		spin_unlock(&p->io_lock);
-
 		time_left = ticks_to_seconds(p, val16);
 	} else if (p->iTCO_version == 1) {
 		spin_lock(&p->io_lock);
-- 
2.9.3
