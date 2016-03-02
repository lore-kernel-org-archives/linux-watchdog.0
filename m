Return-path: <mstsxfx@gmail.com>
Date: Wed, 2 Mar 2016 14:18:24 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>, Corey Minyard <minyard@acm.org>,
	Javi Merino <javi.merino@arm.com>, linux-watchdog@vger.kernel.org,
	"Steven Rostedt (Red Hat)" <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
	Borislav Petkov <bp@alien8.de>,
	Gobinda Charan Maji <gobinda.cemk07@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
	openipmi-developer@lists.sourceforge.net,
	Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v2 PATCH 1/3] panic: Change nmi_panic from macro to function
Message-ID: <20160302131824.GH26686@dhcp22.suse.cz>
References: <20160302103624.5058.35844.stgit@softrs>
 <20160302103626.5058.74361.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160302103626.5058.74361.stgit@softrs>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed 02-03-16 19:36:26, Hidehiro Kawai wrote:
[...]
> +void nmi_panic(struct pt_regs *regs, const char *fmt, ...)

Do we really need vargs? All the current users seem to be OK with a
simple string. This makes the code slightly more complicated without any
apparent reason.

> +{
> +	static char buf[1024]; /* protected by panic_cpu */
> +	va_list args;
> +	int old_cpu, cpu;
> +
> +	cpu = raw_smp_processor_id();
> +	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, cpu);
> +
> +	if (old_cpu == PANIC_CPU_INVALID) {
> +		va_start(args, fmt);
> +		vsnprintf(buf, sizeof(buf), fmt, args);
> +		va_end(args);
> +
> +		panic("%s", buf);
> +	} else if (old_cpu != cpu)
> +		nmi_panic_self_stop(regs);
> +}
> +EXPORT_SYMBOL(nmi_panic);
> +
>  /**
>   *	panic - halt the system
>   *	@fmt: The text string to print
> 
> 

-- 
Michal Hocko
SUSE Labs
