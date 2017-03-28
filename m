Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38867 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbdC1PCv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Mar 2017 11:02:51 -0400
Received: by mail-wm0-f54.google.com with SMTP id t189so1056283wmt.1
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Mar 2017 08:02:44 -0700 (PDT)
Date: Tue, 28 Mar 2017 17:02:20 +0200
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
Subject: Re: [PATCH v22 03/11] clocksource: arm_arch_timer: refactor
 arch_timer_needs_probing
Message-ID: <20170328150220.GF2123@mai>
References: <20170321163122.9183-1-fu.wei@linaro.org>
 <20170321163122.9183-4-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321163122.9183-4-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 12:31:14AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>=20
> When system init with device-tree, we don't know which node will be
> initialized first. And the code in arch_timer_common_init should wait
> until per-cpu timer and MMIO timer are both initialized. So we need
> arch_timer_needs_probing to detect the init status of system.
>=20
> But currently the code is dispersed in arch_timer_needs_probing and
> arch_timer_common_init. And the function name doesn't specify that
> it's only for device-tree. This is somewhat confusing.

Can the following patch help you to solve nicely the situation ?

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1360007.html
=20
> This patch move all related code from arch_timer_common_init to
> arch_timer_needs_probing, refactor it, and rename it to
> arch_timer_needs_of_probing. And make sure that it will be called
> only if acpi is disabled.
>=20
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 34 +++++++++++++++++++---------=
------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource=
/arm_arch_timer.c
> index 29ca7d6..d1a05d9 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -839,15 +839,28 @@ static const struct of_device_id arch_timer_mem_o=
f_match[] __initconst =3D {
>  	{},
>  };
> =20
> -static bool __init
> -arch_timer_needs_probing(int type, const struct of_device_id *matches)
> +static bool __init arch_timer_needs_of_probing(void)
>  {
>  	struct device_node *dn;
>  	bool needs_probing =3D false;
> +	unsigned int mask =3D ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
> =20
> -	dn =3D of_find_matching_node(NULL, matches);
> -	if (dn && of_device_is_available(dn) && !(arch_timers_present & type)=
)
> +	/* We have two timers, and both device-tree nodes are probed. */
> +	if ((arch_timers_present & mask) =3D=3D mask)
> +		return false;
> +
> +	/*
> +	 * Only one type of timer is probed,
> +	 * check if we have another type of timer node in device-tree.
> +	 */
> +	if (arch_timers_present & ARCH_TIMER_TYPE_CP15)
> +		dn =3D of_find_matching_node(NULL, arch_timer_mem_of_match);
> +	else
> +		dn =3D of_find_matching_node(NULL, arch_timer_of_match);
> +
> +	if (dn && of_device_is_available(dn))
>  		needs_probing =3D true;
> +
>  	of_node_put(dn);
> =20
>  	return needs_probing;
> @@ -855,17 +868,8 @@ arch_timer_needs_probing(int type, const struct of=
_device_id *matches)
> =20
>  static int __init arch_timer_common_init(void)
>  {
> -	unsigned mask =3D ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
> -
> -	/* Wait until both nodes are probed if we have two timers */
> -	if ((arch_timers_present & mask) !=3D mask) {
> -		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_MEM,
> -					     arch_timer_mem_of_match))
> -			return 0;
> -		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_CP15,
> -					     arch_timer_of_match))
> -			return 0;
> -	}
> +	if (acpi_disabled && arch_timer_needs_of_probing())
> +		return 0;
> =20
>  	arch_timer_banner(arch_timers_present);
>  	arch_counter_register(arch_timers_present);
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
