Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rwright@hpe.com,
	maurice.a.saldivar@hpe.com,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 09/10] watchdog/hpwdt: condition early return of NMI handler on iLO5
Date: Tue,  6 Feb 2018 15:58:54 -0700
Message-Id: <20180206225855.30582-10-jerry.hoemann@hpe.com>
In-Reply-To: <20180206225855.30582-1-jerry.hoemann@hpe.com>
References: <20180206225855.30582-1-jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>

Modify prior change to not claim an NMI unless originated
from iLO to apply only to iLO5 and later going forward.
This restores hpwdt traditional behavior of calling panic
if the NMI is NMI_IO_CHECK, NMI_SERR, or NMI_UNKNOWN for
legacy hardware.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 1edbcb8f1537..9bfb668115f8 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -33,6 +33,7 @@
 static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static unsigned int allow_kdump = 1;
+static bool iLO5;
 #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
 static bool pretimeout = 1;
 #else
@@ -140,14 +141,14 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 		"3. OA Forward Progress Log\n"
 		"4. iLO Event Log";
 
-	if ((ulReason == NMI_UNKNOWN) && !mynmi)
-		return NMI_DONE;
-
 	pr_debug("nmi: ulReason=%d, mynmi=0x%0x\n", ulReason, mynmi);
 
 	if (!pretimeout)
 		return NMI_DONE;
 
+	if (iLO5 && (ulReason == NMI_UNKNOWN) && !mynmi)
+		return NMI_DONE;
+
 	if (allow_kdump)
 		hpwdt_stop(&hpwdt_dev);
 
@@ -280,6 +281,9 @@ static int hpwdt_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 			", timer margin: %d seconds (nowayout=%d).\n",
 			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
 
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
+		iLO5 = 1;
+
 	return 0;
 
 error_wd_register:
-- 
2.13.6
