Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailxx.hitachi.co.jp ([133.145.228.50]:34190 "EHLO
	mailxx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcCAC24 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Feb 2016 21:28:56 -0500
Subject: [PATCH 0/3] Use nmi_panic() in panic on NMI case
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: openipmi-developer@lists.sourceforge.net,
	Michal Hocko <mhocko@kernel.org>,
	Borislav Petkov <bp@alien8.de>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Tue, 01 Mar 2016 10:50:35 +0900
Message-ID: <20160301015035.4318.78677.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit 1717f2096b54 ("panic, x86: Fix re-entrance problem due to
panic on NMI") and commit 58c5661f2144 ("panic, x86: Allow CPUs to
save registers even if looping in NMI context") introduced nmi_panic()
which prevents concurrent/recursive execution of panic().  It also
saves registers for the crash dump on x86.

However, there are some cases where NMI handlers still use panic().
This patch set partially replaces them with nmi_panic() in those
cases.

---
Even if applying this patch set, some NMI or similar handlers (e.g.
MCE handler) remains to use panic().  This is because I can't test
them well and actual problems won't happen.  For example, the
possibility that normal panic and panic on MCE happen simultaneously
is very low.

Hidehiro Kawai (3):
      panic: Export panic_cpu and nmi_panic_self_stop
      ipmi/watchdog: Use nmi_panic() when kernel panics in NMI handler
      hpwdt: Use nmi_panic() when kernel panics in NMI handler


 drivers/char/ipmi/ipmi_watchdog.c |    2 +-
 drivers/watchdog/hpwdt.c          |   12 ++++++++++--
 kernel/panic.c                    |    2 ++
 3 files changed, 13 insertions(+), 3 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group


