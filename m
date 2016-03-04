Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36782 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbcCDT1q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Mar 2016 14:27:46 -0500
Received: by mail-qg0-f46.google.com with SMTP id u110so51468942qge.3
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Mar 2016 11:27:46 -0800 (PST)
From: Michal Nazarewicz <mina86@mina86.com>
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>
Cc: Javi Merino <javi.merino@arm.com>, Michal Hocko <mhocko@suse.com>,
	linux-watchdog@vger.kernel.org,
	"Steven Rostedt \(Red Hat\)" <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
	Borislav Petkov <bp@alien8.de>,
	Gobinda Charan Maji <gobinda.cemk07@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
	openipmi-developer@lists.sourceforge.net,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v3 PATCH 1/3] panic: Change nmi_panic from macro to function
In-Reply-To: <20160303105744.4587.1001.stgit@softrs>
References: <20160303105741.4587.49047.stgit@softrs> <20160303105744.4587.1001.stgit@softrs>
Date: Fri, 04 Mar 2016 14:27:43 -0500
Message-ID: <xa1tr3fq82mo.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 03 2016, Hidehiro Kawai wrote:
> Change nmi_panic() macro to a normal function for the portability.
> Also, export it for modules.
>
> Changes since v2:
> - Make nmi_panic receive a single string instead of printf style args
>
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Michal Nazarewicz <mina86@mina86.com>

Code does what the commit advertises so

Acked-by: Michal Nazarewicz <mina86@mina86.com>

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
>  include/linux/kernel.h |   21 +-------------------
>  kernel/panic.c         |   20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index f31638c..cbe7d70 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -255,7 +255,7 @@ extern long (*panic_blink)(int state);
>  __printf(1, 2)
>  void panic(const char *fmt, ...)
>  	__noreturn __cold;
> -void nmi_panic_self_stop(struct pt_regs *);
> +void nmi_panic(struct pt_regs *regs, const char *msg);
>  extern void oops_enter(void);
>  extern void oops_exit(void);
>  void print_oops_end_marker(void);
> @@ -455,25 +455,6 @@ extern atomic_t panic_cpu;
>  #define PANIC_CPU_INVALID	-1
> =20
>  /*
> - * A variant of panic() called from NMI context. We return if we've al=
ready
> - * panicked on this CPU. If another CPU already panicked, loop in
> - * nmi_panic_self_stop() which can provide architecture dependent code=
 such
> - * as saving register state for crash dump.
> - */
> -#define nmi_panic(regs, fmt, ...)					\
> -do {									\
> -	int old_cpu, cpu;						\
> -									\
> -	cpu =3D raw_smp_processor_id();					\
> -	old_cpu =3D atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, cpu);	\
> -									\
> -	if (old_cpu =3D=3D PANIC_CPU_INVALID)				\
> -		panic(fmt, ##__VA_ARGS__);				\
> -	else if (old_cpu !=3D cpu)					\
> -		nmi_panic_self_stop(regs);				\
> -} while (0)
> -
> -/*
>   * Only to be used by arch init code. If the user over-wrote the defau=
lt
>   * CONFIG_PANIC_TIMEOUT, honor it.
>   */
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d96469d..8abfc30 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -72,6 +72,26 @@ void __weak nmi_panic_self_stop(struct pt_regs *regs=
)
> =20
>  atomic_t panic_cpu =3D ATOMIC_INIT(PANIC_CPU_INVALID);
> =20
> +/*
> + * A variant of panic() called from NMI context. We return if we've al=
ready
> + * panicked on this CPU. If another CPU already panicked, loop in
> + * nmi_panic_self_stop() which can provide architecture dependent code=
 such
> + * as saving register state for crash dump.
> + */
> +void nmi_panic(struct pt_regs *regs, const char *msg)
> +{
> +	int old_cpu, cpu;
> +
> +	cpu =3D raw_smp_processor_id();
> +	old_cpu =3D atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, cpu);
> +
> +	if (old_cpu =3D=3D PANIC_CPU_INVALID)
> +		panic("%s", msg);
> +	else if (old_cpu !=3D cpu)
> +		nmi_panic_self_stop(regs);
> +}
> +EXPORT_SYMBOL(nmi_panic);
> +
>  /**
>   *	panic - halt the system
>   *	@fmt: The text string to print
>
>

--=20
Best regards
=E3=83=9F=E3=83=8F=E3=82=A6 =E2=80=9C=F0=9D=93=B6=F0=9D=93=B2=F0=9D=93=B7=
=F0=9D=93=AA86=E2=80=9D =E3=83=8A=E3=82=B6=E3=83=AC=E3=83=B4=E3=82=A4=E3=83=
=84
=C2=ABIf at first you don=E2=80=99t succeed, give up skydiving=C2=BB
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
