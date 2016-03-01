Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:35611 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbcCAHZ7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Mar 2016 02:25:59 -0500
Date: Tue, 1 Mar 2016 08:24:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>,
	Michal Hocko <mhocko@suse.com>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
	Tejun Heo <tj@kernel.org>,
	openipmi-developer@lists.sourceforge.net,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] panic: Export panic_cpu and nmi_panic_self_stop
Message-ID: <20160301072456.GA2997@nazgul.tnic>
References: <20160301015035.4318.78677.stgit@softrs>
 <20160301015037.4318.33155.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160301015037.4318.33155.stgit@softrs>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Mar 01, 2016 at 10:50:37AM +0900, Hidehiro Kawai wrote:
> Export panic_cpu and nmi_panic_self_stop symbols for modules which
> use nmi_panic() macro.
> 
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> ---
>  kernel/panic.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d96469d..f4e8035 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -69,8 +69,10 @@ void __weak nmi_panic_self_stop(struct pt_regs *regs)
>  {
>  	panic_smp_self_stop();
>  }
> +EXPORT_SYMBOL(nmi_panic_self_stop);
>  
>  atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
> +EXPORT_SYMBOL(panic_cpu);

Can we make nmi_panic() at least a proper function and export that
instead of exporting all those implementation details...?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
