Return-path: <hidehiro.kawai.ez@hitachi.com>
Subject: [v2 PATCH 3/3] hpwdt: Use nmi_panic() when kernel panics in NMI
 handler
To: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Mingarelli <thomas.mingarelli@hpe.com>,
        Wim Van Sebroeck <wim@iguana.be>, Corey Minyard <minyard@acm.org>
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>, Borislav Petkov <bp@alien8.de>,
        openipmi-developer@lists.sourceforge.net,
        Guenter Roeck <linux@roeck-us.net>
Date: Wed, 02 Mar 2016 19:36:31 +0900
Message-ID: <20160302103631.5058.70846.stgit@softrs>
In-Reply-To: <20160302103624.5058.35844.stgit@softrs>
References: <20160302103624.5058.35844.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

commit 1717f2096b54 ("panic, x86: Fix re-entrance problem due to
panic on NMI") introduced nmi_panic() which prevents concurrent and
recursive execution of panic().  It also saves registers for the
crash dump on x86 by later commit 58c5661f2144 ("panic, x86: Allow
CPUs to save registers even if looping in NMI context").

hpwdt driver can call panic() from NMI handler, so replace it with
nmi_panic().  Also, do some cleanups.

Changes since V1:
- Use direct return instead of goto
- Combine the panic message string into a single line

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Thomas Mingarelli <thomas.mingarelli@hpe.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/hpwdt.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 92443c3..a6c8797 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -483,7 +483,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	static int die_nmi_called;
 
 	if (!hpwdt_nmi_decoding)
-		goto out;
+		return NMI_DONE;
 
 	spin_lock_irqsave(&rom_lock, rom_pl);
 	if (!die_nmi_called && !is_icru && !is_uefi)
@@ -496,11 +496,11 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 
 	if (!is_icru && !is_uefi) {
 		if (cmn_regs.u1.ral == 0) {
-			panic("An NMI occurred, "
-				"but unable to determine source.\n");
+			nmi_panic(regs, "An NMI occurred, but unable to determine source.\n");
+			return NMI_HANDLED;
 		}
 	}
-	panic("An NMI occurred. Depending on your system the reason "
+	nmi_panic(regs, "An NMI occurred. Depending on your system the reason "
 		"for the NMI is logged in any one of the following "
 		"resources:\n"
 		"1. Integrated Management Log (IML)\n"
@@ -508,8 +508,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 		"3. OA Forward Progress Log\n"
 		"4. iLO Event Log");
 
-out:
-	return NMI_DONE;
+	return NMI_HANDLED;
 }
 #endif /* CONFIG_HPWDT_NMI_DECODING */
 
