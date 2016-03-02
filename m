Return-path: <hidehiro.kawai.ez@hitachi.com>
Subject: [v2 PATCH 2/3] ipmi/watchdog: Use nmi_panic() when kernel panics in
 NMI handler
To: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Mingarelli <thomas.mingarelli@hpe.com>,
        Wim Van Sebroeck <wim@iguana.be>, Corey Minyard <minyard@acm.org>
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Corey Minyard <cminyard@mvista.com>, Michal Hocko <mhocko@suse.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>, Borislav Petkov <bp@alien8.de>,
        openipmi-developer@lists.sourceforge.net,
        Guenter Roeck <linux@roeck-us.net>
Date: Wed, 02 Mar 2016 19:36:29 +0900
Message-ID: <20160302103629.5058.60500.stgit@softrs>
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

ipmi_watchdog driver can call panic() from NMI handler, so replace
it with nmi_panic().

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Michal Hocko <mhocko@suse.com>
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
