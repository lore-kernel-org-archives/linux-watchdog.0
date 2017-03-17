Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdCQUE0 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Mar 2017 16:04:26 -0400
Date: Fri, 17 Mar 2017 20:01:54 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com,
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
Subject: Re: [PATCH v21 13/13] acpi/arm64: Add SBSA Generic Watchdog support
 in GTDT driver
Message-ID: <20170317200153.GF15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-14-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170206185015.12296-14-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 02:50:15AM +0800, fu.wei@linaro.org wrote:
> +static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
> +					int index)
> +{
> +	struct platform_device *pdev;
> +	int irq =3D map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
> +	int no_irq =3D 1;
> +
> +	/*
> +	 * According to SBSA specification the size of refresh and control
> +	 * frames of SBSA Generic Watchdog is SZ_4K(Offset 0x000 =E2=80=93 0x=
FFF).
> +	 */
> +	struct resource res[] =3D {
> +		DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
> +		DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
> +		DEFINE_RES_IRQ(irq),
> +	};
> +
> +	pr_debug("found a Watchdog (0x%llx/0x%llx gsi:%u flags:0x%x).\n",
> +		 wd->refresh_frame_address, wd->control_frame_address,
> +		 wd->timer_interrupt, wd->timer_flags);
> +
> +	if (!(wd->refresh_frame_address && wd->control_frame_address)) {
> +		pr_err(FW_BUG "failed to get the Watchdog base address.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!wd->timer_interrupt)
> +		pr_warn(FW_BUG "failed to get the Watchdog interrupt.\n");

I've not been able to find where the ACPI spec says that zero is not a
valid GSIV. This may simply be an oversight/ambiguity in the spec.

Is there any statement to that effect?

> +	else if (irq <=3D 0)
> +		pr_warn("failed to map the Watchdog interrupt.\n");
> +	else
> +		no_irq =3D 0;
> +
> +	/*
> +	 * Add a platform device named "sbsa-gwdt" to match the platform driv=
er.
> +	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdo=
g
> +	 * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get dev=
ice
> +	 * info below by matching this name.
> +	 */
> +	pdev =3D platform_device_register_simple("sbsa-gwdt", index, res,
> +					       ARRAY_SIZE(res) - no_irq);

This no_irq variable is messy and confusing.

Get rid of no_irq, and replace it with nr_res, initialised to
ARRAY_SIZE(res). If there's no interrupt, subtract one.

[...]

> +	for_each_platform_timer(platform_timer) {
> +		if (is_watchdog(platform_timer)) {
> +			ret =3D gtdt_import_sbsa_gwdt(platform_timer, i);
> +			if (ret)
> +				break;
> +			i++;
> +		}
> +	}
> +
> +	if (i)
> +		pr_info("found %d SBSA generic Watchdog(s).\n", i);

My reading of SBSA is that there is one watchdog in the system.

Is that not the case?

[...]

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index acb00b5..c899df1 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -219,6 +219,7 @@ config ARM_SBSA_WATCHDOG
>  	tristate "ARM SBSA Generic Watchdog"
>  	depends on ARM64
>  	depends on ARM_ARCH_TIMER
> +	depends on ACPI_GTDT || !ACPI

I don't think this is necessary.

This series hasn't touched this driver code at all.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
