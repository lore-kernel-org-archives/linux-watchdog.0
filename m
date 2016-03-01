Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34256 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbcCAIt2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Mar 2016 03:49:28 -0500
Date: Tue, 1 Mar 2016 09:49:25 +0100
From: Michal Hocko <mhocko@kernel.org>
To: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
	<hidehiro.kawai.ez@hitachi.com>
Cc: 'Borislav Petkov' <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
	Tejun Heo <tj@kernel.org>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] panic: Export panic_cpu and nmi_panic_self_stop
Message-ID: <20160301084924.GA9461@dhcp22.suse.cz>
References: <20160301015035.4318.78677.stgit@softrs>
 <20160301015037.4318.33155.stgit@softrs>
 <20160301072456.GA2997@nazgul.tnic>
 <04EAB7311EE43145B2D3536183D1A84454B0661B@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454B0661B@GSjpTKYDCembx31.service.hitachi.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue 01-03-16 07:48:10, 河合英宏 / KAWAI，HIDEHIRO wrote:
> Hi Borislav,
> 
> > From: Borislav Petkov [mailto:bp@alien8.de]
> > On Tue, Mar 01, 2016 at 10:50:37AM +0900, Hidehiro Kawai wrote:
> > > Export panic_cpu and nmi_panic_self_stop symbols for modules which
> > > use nmi_panic() macro.
> > >
> > > Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Borislav Petkov <bp@suse.de>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> > > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > ---
> > >  kernel/panic.c |    2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > index d96469d..f4e8035 100644
> > > --- a/kernel/panic.c
> > > +++ b/kernel/panic.c
> > > @@ -69,8 +69,10 @@ void __weak nmi_panic_self_stop(struct pt_regs *regs)
> > >  {
> > >  	panic_smp_self_stop();
> > >  }
> > > +EXPORT_SYMBOL(nmi_panic_self_stop);
> > >
> > >  atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
> > > +EXPORT_SYMBOL(panic_cpu);
> > 
> > Can we make nmi_panic() at least a proper function and export that
> > instead of exporting all those implementation details...?
> 
> The reason I implemented nmi_panic() as a macro is to pass
> variable arguments directly to panic().  Fortunately, since all
> invocations of nmi_panic() just pass a fixed string, I can change it
> to a normal function like:
> 
> int nmi_panic(struct pt_regs *regs, const char *msg)
> {
> ...
> 	panic("%s", msg);
> 
> If people don't mind if that, I'll change it.

Yeah, I think this is better. If we ever need a variable strings we can
reconsider.
-- 
Michal Hocko
SUSE Labs
