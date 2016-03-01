Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:34445 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbcCAB5e (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Feb 2016 20:57:34 -0500
Subject: [PATCH 2/3] ipmi/watchdog: Use nmi_panic() when kernel panics in
 NMI handler
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: openipmi-developer@lists.sourceforge.net,
	Michal Hocko <mhocko@kernel.org>,
	Borislav Petkov <bp@alien8.de>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Tue, 01 Mar 2016 10:50:39 +0900
Message-ID: <20160301015039.4318.58063.stgit@softrs>
In-Reply-To: <20160301015035.4318.78677.stgit@softrs>
References: <20160301015035.4318.78677.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit 58c5661f2144 ("panic, x86: Allow CPUs to save registers even
if looping in NMI context") introduced nmi_panic() which prevents
concurrent/recursive execution of panic().  It also saves registers
for the crash dump on x86.

ipmi_watchdog driver can call panic() from NMI handler, so replace
it with nmi_panic().

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net
---
 drivers/char/ipmi/ipmi_watchdog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 096f0ce..4facc75 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -1140,7 +1140,7 @@ ipmi_nmi(unsigned int val, struct pt_regs *regs)
 		   the timer.   So do so. */
 		pretimeout_since_last_heartbeat = 1;
 		if (atomic_inc_and_test(&preop_panic_excl))
-			panic(PFX "pre-timeout");
+			nmi_panic(regs, PFX "pre-timeout");
 	}
 
 	return NMI_HANDLED;


