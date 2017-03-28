Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbdC1Pky (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Mar 2017 11:40:54 -0400
Date: Tue, 28 Mar 2017 16:41:12 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com, mark.rutland@arm.com,
        sudeep.holla@arm.com, hanjun.guo@linaro.org,
        linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org,
        al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v22 11/11] acpi/arm64: Add SBSA Generic Watchdog support
 in GTDT driver
Message-ID: <20170328154111.GC18046@red-moon>
References: <20170321163122.9183-1-fu.wei@linaro.org>
 <20170321163122.9183-12-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321163122.9183-12-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 12:31:22AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>=20
> This driver adds support for parsing SBSA Generic Watchdog timer
> in GTDT, parse all info in SBSA Generic Watchdog Structure in GTDT,
> and creating a platform device with that information.
>=20
> This allows the operating system to obtain device data from the
> resource of platform device. The platform device named "sbsa-gwdt"
> can be used by the ARM SBSA Generic Watchdog driver.
>=20
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/acpi/arm64/gtdt.c | 94 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 94 insertions(+)
>=20
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index f471873..5d167f0 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -14,6 +14,7 @@
>  #include <linux/acpi.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/platform_device.h>
> =20
>  #include <clocksource/arm_arch_timer.h>
> =20
> @@ -59,6 +60,17 @@ static inline bool is_timer_block(void *platform_tim=
er)
>  	return gh->type =3D=3D ACPI_GTDT_TYPE_TIMER_BLOCK;
>  }
> =20
> +static inline bool is_non_secure_watchdog(void *platform_timer)
> +{
> +	struct acpi_gtdt_header *gh =3D platform_timer;
> +	struct acpi_gtdt_watchdog *wd =3D platform_timer;
> +
> +	if (gh->type !=3D ACPI_GTDT_TYPE_WATCHDOG)
> +		return false;
> +
> +	return !(wd->timer_flags & ACPI_GTDT_WATCHDOG_SECURE);
> +}
> +
>  static int __init map_gt_gsi(u32 interrupt, u32 flags)
>  {
>  	int trigger, polarity;
> @@ -285,3 +297,85 @@ int __init acpi_arch_timer_mem_init(struct arch_ti=
mer_mem *timer_mem,
> =20
>  	return 0;
>  }
> +
> +/*
> + * Initialize a SBSA generic Watchdog platform device info from GTDT
> + */
> +static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
> +					int index)
> +{
> +	struct platform_device *pdev;
> +	int irq =3D map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
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
> +	int nr_res =3D ARRAY_SIZE(res);
> +
> +	pr_debug("found a Watchdog (0x%llx/0x%llx gsi:%u flags:0x%x).\n",
> +		 wd->refresh_frame_address, wd->control_frame_address,
> +		 wd->timer_interrupt, wd->timer_flags);
> +
> +	if (!(wd->refresh_frame_address && wd->control_frame_address)) {
> +		pr_err(FW_BUG "failed to get the Watchdog base address.\n");
> +		return -EINVAL;

You should unmap the gsi here.

> +	}
> +
> +	if (irq <=3D 0) {
> +		pr_warn("failed to map the Watchdog interrupt.\n");
> +		nr_res--;
> +	}
> +
> +	/*
> +	 * Add a platform device named "sbsa-gwdt" to match the platform driv=
er.
> +	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdo=
g
> +	 * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get dev=
ice

Nit: I would not hardcode drivers paths in comments.

> +	 * info below by matching this name.
> +	 */
> +	pdev =3D platform_device_register_simple("sbsa-gwdt", index, res, nr_=
res);
> +	if (IS_ERR(pdev)) {
> +		acpi_unregister_gsi(wd->timer_interrupt);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init gtdt_sbsa_gwdt_init(void)
> +{
> +	int ret, i =3D 0;
> +	void *platform_timer;
> +	struct acpi_table_header *table;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
> +		return -EINVAL;
> +
> +	ret =3D acpi_gtdt_init(table, NULL);
> +	if (ret)
> +		return ret;

Ok, I missed previous versions reviews so I miss the background
here and I apologise.

I do not understand why you call acpi_gtdt_init() again (or better,
why acpi_gtdt_init() does not return straight away) here if the
stashed pointer in acpi_gtdt_desc is already set. I am not a big fan
of the for_each_platform_timer macro either, here you can just read
the ACPI_SIG_GTDT and parse its entries, I see no point in calling
acpi_gtdt_init() again, there is nothing to stash for later probing,
is there ?

Or it is just to reuse common parsing code ? Regardless, if the
acpi_gtdt_desc struct is already initialized acpi_gtdt_init() should
just return or I am missing the point.

I would like clarifications on the acpi_gtdt_init() call above please
(plus GSI unmap fix), apart from that:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> +	for_each_platform_timer(platform_timer) {
> +		if (is_non_secure_watchdog(platform_timer)) {
> +			ret =3D gtdt_import_sbsa_gwdt(platform_timer, i);
> +			if (ret)
> +				break;
> +			i++;
> +		}
> +	}
> +
> +	if (i)
> +		pr_info("found %d SBSA generic Watchdog(s).\n", i);
> +
> +	return ret;
> +}
> +
> +device_initcall(gtdt_sbsa_gwdt_init);
> --=20
> 2.9.3
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
