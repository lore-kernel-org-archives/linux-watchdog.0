Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:30769 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbeHBXRO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Aug 2018 19:17:14 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 2/4] watchdog: hpwdt: Claim NMI from iLO
Date: Thu,  2 Aug 2018 15:15:39 -0600
Message-Id: <1533244541-42310-3-git-send-email-jerry.hoemann@hpe.com>
In-Reply-To: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The hwpdt driver is overloaded for handling both the iLO
watchdog and the explicit "Generate NMI to System" virutal
button.

Claim the iLO NMI virtual button even if we are not claiming
the iLO watchdog pretimeout.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 369022d..8a85ddd 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -162,7 +162,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	if (ilo5 && ulReason == NMI_UNKNOWN && !mynmi)
 		return NMI_DONE;
 
-	if (ilo5 && !pretimeout)
+	if (ilo5 && !pretimeout && !(mynmi & 0x4))
 		return NMI_DONE;
 
 	hpwdt_stop();
-- 
1.8.3.1

