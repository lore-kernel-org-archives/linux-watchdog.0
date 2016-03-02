Return-path: <bp@alien8.de>
Date: Wed, 2 Mar 2016 14:22:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Michal Hocko <mhocko@kernel.org>
Cc: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>, Corey Minyard <minyard@acm.org>,
	Javi Merino <javi.merino@arm.com>, linux-watchdog@vger.kernel.org,
	"Steven Rostedt (Red Hat)" <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
	Gobinda Charan Maji <gobinda.cemk07@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
	openipmi-developer@lists.sourceforge.net,
	Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v2 PATCH 1/3] panic: Change nmi_panic from macro to function
Message-ID: <20160302132251.GH16954@pd.tnic>
References: <20160302103624.5058.35844.stgit@softrs>
 <20160302103626.5058.74361.stgit@softrs>
 <20160302131824.GH26686@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160302131824.GH26686@dhcp22.suse.cz>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Mar 02, 2016 at 02:18:24PM +0100, Michal Hocko wrote:
> On Wed 02-03-16 19:36:26, Hidehiro Kawai wrote:
> [...]
> > +void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
> 
> Do we really need vargs? All the current users seem to be OK with a
> simple string. This makes the code slightly more complicated without any
> apparent reason.

I was just wondering the exactly same thing...

The contra-arg would be that in case someone wants to do nmi_panic()
with more than a string, then it won't work.

The question is, does nmi_panic() even need to dump something more than
regs and a string?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
