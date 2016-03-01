Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailxx.hitachi.co.jp ([133.145.228.50]:34191 "EHLO
	mailxx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcCAC24 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Feb 2016 21:28:56 -0500
Subject: [PATCH 1/3] panic: Export panic_cpu and nmi_panic_self_stop
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
	Borislav Petkov <bp@alien8.de>, Tejun Heo <tj@kernel.org>,
	openipmi-developer@lists.sourceforge.net,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 01 Mar 2016 10:50:37 +0900
Message-ID: <20160301015037.4318.33155.stgit@softrs>
In-Reply-To: <20160301015035.4318.78677.stgit@softrs>
References: <20160301015035.4318.78677.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Export panic_cpu and nmi_panic_self_stop symbols for modules which
use nmi_panic() macro.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
---
 kernel/panic.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index d96469d..f4e8035 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -69,8 +69,10 @@ void __weak nmi_panic_self_stop(struct pt_regs *regs)
 {
 	panic_smp_self_stop();
 }
+EXPORT_SYMBOL(nmi_panic_self_stop);
 
 atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
+EXPORT_SYMBOL(panic_cpu);
 
 /**
  *	panic - halt the system


