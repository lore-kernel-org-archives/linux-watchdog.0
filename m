Return-path: <hidehiro.kawai.ez@hitachi.com>
Subject: [v3 PATCH 0/3] Use nmi_panic() in panic on NMI case
To: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Mingarelli <thomas.mingarelli@hpe.com>,
        Wim Van Sebroeck <wim@iguana.be>, Corey Minyard <minyard@acm.org>
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>, Borislav Petkov <bp@alien8.de>,
        openipmi-developer@lists.sourceforge.net,
        Guenter Roeck <linux@roeck-us.net>
Date: Thu, 03 Mar 2016 19:57:42 +0900
Message-ID: <20160303105741.4587.49047.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

commit 1717f2096b54 ("panic, x86: Fix re-entrance problem due to
panic on NMI") and commit 58c5661f2144 ("panic, x86: Allow CPUs to
save registers even if looping in NMI context") introduced nmi_panic()
which prevents concurrent/recursive execution of panic().  It also
saves registers for the crash dump on x86.

However, there are some cases where NMI handlers still use panic().
This patch set partially replaces them with nmi_panic() in those
cases.

Changes since v2 (https://lkml.org/lkml/2016/3/2/173):
- Make nmi_panic receive a single string instead of printf style args
  (PATCH 1/3)

Changes since v1 (https://lkml.org/lkml/2016/2/29/858):
- Replace nmi_panic() macro with a function version instead of
  exporting symbols referred by the macro (PATCH 1/3)
- Improve the patch descriptions (PATCH 2/3 and 3/3)
- Do small cleanups (PATCH 3/3)

---
Even if applying this patch set, some NMI or similar handlers (e.g.
MCE handler) remains to use panic().  This is because I can't test
them well and actual problems won't happen.  For example, the
possibility that normal panic and panic on MCE happen simultaneously
is very low.

Hidehiro Kawai (3):
      panic: Change nmi_panic from macro to function
      ipmi/watchdog: Use nmi_panic() when kernel panics in NMI handler
      hpwdt: Use nmi_panic() when kernel panics in NMI handler


 drivers/char/ipmi/ipmi_watchdog.c |    2 +-
 drivers/watchdog/hpwdt.c          |   11 +++++------
 include/linux/kernel.h            |   21 +--------------------
 kernel/panic.c                    |   20 ++++++++++++++++++++
 4 files changed, 27 insertions(+), 27 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
