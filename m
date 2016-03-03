Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:54048 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbcCCNPG (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2016 08:15:06 -0500
Date: Thu, 3 Mar 2016 14:14:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>,
	Javi Merino <javi.merino@arm.com>,
	Michal Hocko <mhocko@suse.com>, linux-watchdog@vger.kernel.org,
	"Steven Rostedt (Red Hat)" <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	Michal Nazarewicz <mina86@mina86.com>,
	Michal Hocko <mhocko@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
	Gobinda Charan Maji <gobinda.cemk07@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
	openipmi-developer@lists.sourceforge.net,
	Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v3 PATCH 1/3] panic: Change nmi_panic from macro to function
Message-ID: <20160303131458.GD24621@pd.tnic>
References: <20160303105741.4587.49047.stgit@softrs>
 <20160303105744.4587.1001.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160303105744.4587.1001.stgit@softrs>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 03, 2016 at 07:57:44PM +0900, Hidehiro Kawai wrote:
> Change nmi_panic() macro to a normal function for the portability.

portability?

> Also, export it for modules.
> 
> Changes since v2:
> - Make nmi_panic receive a single string instead of printf style args
> 
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Michal Nazarewicz <mina86@mina86.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
> Cc: Javi Merino <javi.merino@arm.com>
> Cc: Gobinda Charan Maji <gobinda.cemk07@gmail.com>
> Cc: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> Cc: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/kernel.h |   21 +--------------------
>  kernel/panic.c         |   20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 20 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
