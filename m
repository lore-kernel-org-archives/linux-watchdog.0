Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:29805 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHVm5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 8 Aug 2018 17:42:57 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 2/5] watchdog: hpwdt: Claim NMI from iLO
Date: Wed,  8 Aug 2018 13:13:24 -0600
Message-Id: <1533755607-71418-3-git-send-email-jerry.hoemann@hpe.com>
In-Reply-To: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The hwpdt driver is overloaded for handling both the iLO
watchdog and the explicit "Generate NMI to System" virutal
button.  Hence NMI handler needs to claim NMI resulting
from the virutal button.

Claim if iLO generated accommodating firmware that might
set wrong bit.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index fae9364..bb41714 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -162,7 +162,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	if (ilo5 && ulReason == NMI_UNKNOWN && !mynmi)
 		return NMI_DONE;
 
-	if (ilo5 && !pretimeout)
+	if (ilo5 && !pretimeout && !mynmi)
 		return NMI_DONE;
 
 	hpwdt_stop();
-- 
1.8.3.1

