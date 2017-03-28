Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36447 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752600AbdC1O6Z (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Mar 2017 10:58:25 -0400
Received: by mail-wr0-f170.google.com with SMTP id w11so89918434wrc.3
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Mar 2017 07:58:19 -0700 (PDT)
Date: Tue, 28 Mar 2017 16:58:14 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rruigrok@codeaurora.org,
        harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org,
        graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com,
        wei@redhat.com, arnd@arndb.de, catalin.marinas@arm.com,
        will.deacon@arm.com, Suravee.Suthikulpanit@amd.com,
        leo.duran@amd.com, wim@iguana.be, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, tn@semihalf.com,
        christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v22 02/11] clocksource: arm_arch_timer: separate out
 device-tree code and remove arch_timer_detect_rate
Message-ID: <20170328145814.GE2123@mai>
References: <20170321163122.9183-1-fu.wei@linaro.org>
 <20170321163122.9183-3-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321163122.9183-3-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 12:31:13AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>=20
> Currently, the counter frequency detection call(arch_timer_detect_rate)
> includes getting the frequency from the device-tree property, the per-c=
pu
> arch-timer and the memory-mapped (MMIO) timer interfaces.
> But reading device-tree property will be needed only when system boot w=
ith
> device-tree, and reading from the per-cpu arch-timer and the memory-map=
ped
> (MMIO) timer interfaces will be needed only when the system initializes
> the relevant timer.
>=20
> This patch separates out device-tree code, keep them in device-tree ini=
t
> function, and removes arch_timer_detect_rate founction, then uses the
> arch_timer_get_cntfrq and arch_timer_mem_get_cntfrq directly.
>=20
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 58 +++++++++++++++++++---------=
--------
>  1 file changed, 30 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource=
/arm_arch_timer.c
> index 843f923..29ca7d6 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -560,30 +560,6 @@ static u32 arch_timer_mem_get_cntfrq(void __iomem =
*cntbase)
>  	return readl_relaxed(cntbase + CNTFRQ);
>  }
> =20
> -static void
> -arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
> -{
> -	/* Who has more than one independent system counter? */
> -	if (arch_timer_rate)
> -		return;
> -
> -	/*
> -	 * Try to determine the frequency from the device tree or CNTFRQ,
> -	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
> -	 */
> -	if (!acpi_disabled ||
> -	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
> -		if (cntbase)
> -			arch_timer_rate =3D arch_timer_mem_get_cntfrq(cntbase);
> -		else
> -			arch_timer_rate =3D arch_timer_get_cntfrq();
> -	}
> -
> -	/* Check the timer frequency. */
> -	if (arch_timer_rate =3D=3D 0)
> -		pr_warn("frequency not available\n");
> -}
> -
>  static void arch_timer_banner(unsigned type)
>  {
>  	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
> @@ -958,7 +934,17 @@ static int __init arch_timer_of_init(struct device=
_node *np)
>  	for (i =3D ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; =
i++)
>  		arch_timer_ppi[i] =3D irq_of_parse_and_map(np, i);
> =20
> -	arch_timer_detect_rate(NULL, np);
> +	/*
> +	 * Try to determine the frequency from the device tree,
> +	 * if fail, get the frequency from the sysreg CNTFRQ.
> +	 */
> +	if (!arch_timer_rate &&

This variable is set only if "arm,armv7-timer" and "arm,armv7-timer-mem" =
are
declared together in the DT, right ?

Two declarations for a single variable ? Ignore the !arch_timer_rate.

> +	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
> +		arch_timer_rate =3D arch_timer_get_cntfrq();
> +	if (!arch_timer_rate) {
> +		pr_err(FW_BUG "frequency not available.\n");
> +		return -EINVAL;
> +	}

Please, clarify this block, the conditions are unclear.

> =20
>  	arch_timer_c3stop =3D !of_property_read_bool(np, "always-on");
> =20
> @@ -1069,7 +1055,19 @@ static int __init arch_timer_mem_init(struct dev=
ice_node *np)
>  		goto out;
>  	}
> =20
> -	arch_timer_detect_rate(base, np);
> +	/*
> +	 * Try to determine the frequency from the device tree,
> +	 * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
> +	 */
> +	if (!arch_timer_rate &&
> +	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
> +		arch_timer_rate =3D arch_timer_mem_get_cntfrq(base);
> +	if (!arch_timer_rate) {
> +		pr_err(FW_BUG "MMIO frequency not available.\n");
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
>  	ret =3D arch_timer_mem_register(base, irq);
>  	if (ret)
>  		goto out;
> @@ -1130,8 +1128,12 @@ static int __init arch_timer_acpi_init(struct ac=
pi_table_header *table)
>  		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
>  		gtdt->non_secure_el2_flags);
> =20
> -	/* Get the frequency from CNTFRQ */
> -	arch_timer_detect_rate(NULL, NULL);
> +	/* Get the frequency from the sysreg CNTFRQ */
> +	arch_timer_rate =3D arch_timer_get_cntfrq();
> +	if (!arch_timer_rate) {
> +		pr_err(FW_BUG "frequency not available.\n");
> +		return -EINVAL;
> +	}
> =20
>  	arch_timer_uses_ppi =3D arch_timer_select_ppi();
>  	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
> --=20
> 2.9.3
>=20

--=20

 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
