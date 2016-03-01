Return-path: <hidehiro.kawai.ez@hitachi.com>
Subject: [PATCH 3/3] hpwdt: Use nmi_panic() when kernel panics in NMI handler
To: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Mingarelli <thomas.mingarelli@hpe.com>,
        Wim Van Sebroeck <wim@iguana.be>, Corey Minyard <minyard@acm.org>
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>, Borislav Petkov <bp@alien8.de>,
        openipmi-developer@lists.sourceforge.net,
        Guenter Roeck <linux@roeck-us.net>
Date: Tue, 01 Mar 2016 10:50:41 +0900
Message-ID: <20160301015041.4318.93922.stgit@softrs>
In-Reply-To: <20160301015035.4318.78677.stgit@softrs>
References: <20160301015035.4318.78677.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

commit 58c5661f2144 ("panic, x86: Allow CPUs to save registers even
if looping in NMI context") introduced nmi_panic() which prevents
concurrent/recursive execution of panic().  It also saves registers
for the crash dump on x86.

hpwdt driver can call panic() from NMI handler, so replace it with
nmi_panic().

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Thomas Mingarelli <thomas.mingarelli@hpe.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/hpwdt.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 92443c3..fd0486f 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -496,11 +496,12 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 
 	if (!is_icru && !is_uefi) {
 		if (cmn_regs.u1.ral == 0) {
-			panic("An NMI occurred, "
+			nmi_panic(regs, "An NMI occurred, "
 				"but unable to determine source.\n");
+			goto handled;
 		}
 	}
-	panic("An NMI occurred. Depending on your system the reason "
+	nmi_panic(regs, "An NMI occurred. Depending on your system the reason "
 		"for the NMI is logged in any one of the following "
 		"resources:\n"
 		"1. Integrated Management Log (IML)\n"
@@ -508,6 +509,13 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 		"3. OA Forward Progress Log\n"
 		"4. iLO Event Log");
 
+handled:
+	/*
+	 * Returning from nmi_panic() means this CPU was processing panic()
+	 * before NMI.  Return NMI_HANDLED and go back to panic routines.
+	 */
+	return NMI_HANDLED;
+
 out:
 	return NMI_DONE;
 }
