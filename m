Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:32990 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbcCBRDO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Mar 2016 12:03:14 -0500
Subject: Re: [v2 PATCH 1/3] panic: Change nmi_panic from macro to function
To: Michal Hocko <mhocko@kernel.org>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
References: <20160302103624.5058.35844.stgit@softrs>
 <20160302103626.5058.74361.stgit@softrs>
 <20160302131824.GH26686@dhcp22.suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>,
	Javi Merino <javi.merino@arm.com>,
	linux-watchdog@vger.kernel.org,
	"Steven Rostedt (Red Hat)" <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	Michal Nazarewicz <mina86@mina86.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
	Borislav Petkov <bp@alien8.de>,
	Gobinda Charan Maji <gobinda.cemk07@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
	openipmi-developer@lists.sourceforge.net,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D71CCA.20809@roeck-us.net>
Date: Wed, 2 Mar 2016 09:03:06 -0800
MIME-Version: 1.0
In-Reply-To: <20160302131824.GH26686@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/02/2016 05:18 AM, Michal Hocko wrote:
> On Wed 02-03-16 19:36:26, Hidehiro Kawai wrote:
> [...]
>> +void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
>
> Do we really need vargs? All the current users seem to be OK with a
> simple string. This makes the code slightly more complicated without any
> apparent reason.
>
>> +{
>> +	static char buf[1024]; /* protected by panic_cpu */

I am also not too happy with this additional stack allocation.
panic() itself takes varargs. Can those be passed on ?
I understand this would need something like vpanic(), so
maybe that isn't feasible.

Dropping the format, at least for now, might be a simpler option.

Guenter

>> +	va_list args;
>> +	int old_cpu, cpu;
>> +
>> +	cpu = raw_smp_processor_id();
>> +	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, cpu);
>> +
>> +	if (old_cpu == PANIC_CPU_INVALID) {
>> +		va_start(args, fmt);
>> +		vsnprintf(buf, sizeof(buf), fmt, args);
>> +		va_end(args);
>> +
>> +		panic("%s", buf);
>> +	} else if (old_cpu != cpu)
>> +		nmi_panic_self_stop(regs);
>> +}
>> +EXPORT_SYMBOL(nmi_panic);
>> +
>>   /**
>>    *	panic - halt the system
>>    *	@fmt: The text string to print
>>
>>
>

