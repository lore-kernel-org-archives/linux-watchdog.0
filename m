Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753033AbcKROVv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 Nov 2016 09:21:51 -0500
Date: Fri, 18 Nov 2016 14:22:49 +0000
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
Subject: Re: [PATCH v16 13/15] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
Message-ID: <20161118142249.GA18029@red-moon>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-14-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1479304148-2965-14-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2016 at 09:49:06PM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>=20
> On platforms booting with ACPI, architected memory-mapped timers'
> configuration data is provided by firmware through the ACPI GTDT
> static table.
>=20
> The clocksource architected timer kernel driver requires a firmware
> interface to collect timer configuration and configure its driver.
> this infrastructure is present for device tree systems, but it is
> missing on systems booting with ACPI.
>=20
> Implement the kernel infrastructure required to parse the static
> ACPI GTDT table so that the architected timer clocksource driver can
> make use of it on systems booting with ACPI, therefore enabling
> the corresponding timers configuration.
>=20
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/arm64/gtdt.c | 95 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  include/linux/acpi.h      |  1 +
>  2 files changed, 96 insertions(+)
>=20
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index 2de79aa..08d9506 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -51,6 +51,14 @@ static inline bool is_timer_block(void *platform_tim=
er)
>  	return gh->type =3D=3D ACPI_GTDT_TYPE_TIMER_BLOCK;
>  }
> =20
> +static inline struct acpi_gtdt_timer_block *get_timer_block(unsigned i=
nt index)
> +{
> +	if (index >=3D acpi_gtdt_desc.timer_block_count || !timer_block)
> +		return NULL;
> +
> +	return timer_block[index];
> +}
> +
>  static inline bool is_watchdog(void *platform_timer)
>  {
>  	struct acpi_gtdt_header *gh =3D platform_timer;
> @@ -214,3 +222,90 @@ int __init acpi_gtdt_init(struct acpi_table_header=
 *table)
>  	acpi_gtdt_release();
>  	return -EINVAL;
>  }
> +
> +/*
> + * Get ONE GT block info for memory-mapped timer from GTDT table.
> + * @data: the GT block data (parsing result)
> + * @index: the index number of GT block
> + * Note: we already verify @data in caller, it can't be NULL here.
> + * Returns 0 if success, -EINVAL/-ENODEV if error.
> + */

Documentation/kernel-doc-nano-HOWTO.txt

> +int __init gtdt_arch_timer_mem_init(struct arch_timer_mem *data,
> +				    unsigned int index)

Nit: acpi_arch_timer_mem_init() to make it consistent with other ACPI
calls ?

> +{
> +	struct acpi_gtdt_timer_block *block;
> +	struct acpi_gtdt_timer_entry *frame;
> +	int i;
> +
> +	block =3D get_timer_block(index);
> +	if (!block)
> +		return -ENODEV;
> +
> +	if (!block->timer_count) {
> +		pr_err(FW_BUG "GT block present, but frame count is zero.");
> +		return -ENODEV;
> +	}
> +
> +	if (block->timer_count > ARCH_TIMER_MEM_MAX_FRAMES) {
> +		pr_err(FW_BUG "GT block lists %d frames, ACPI spec only allows 8\n",
> +		       block->timer_count);
> +		return -EINVAL;
> +	}

Nit: these two checks can be carried out at GTDT init where the GTDT
is parsed first. Actually you could have two functions one to init
timers (say acpi_gtdt_timers_init()) and one watchdogs, that would
eliminate the duplicated timer_block/watchdog arrays (both sized
Platform Timer Count) and acpi_gtdt_timers_init() can return
the number of entries found so that you can loop with a determined
upper bound in the arm arch timer driver.

Just thinking aloud, these are just improvements I can carry them
out later, the more important question here is the interface between the
parsing code and the arch timer probing code which depends on other
patches and that needs to be agreed, this patch is not really a problem.

> +	data->cntctlbase =3D (phys_addr_t)block->block_address;
> +	/*
> +	 * We can NOT get the size info from GTDT table,
> +	 * but according to "Table * CNTCTLBase memory map" of
> +	 * <ARM Architecture Reference Manual> for ARMv8,
> +	 * it should be 4KB(Offset 0x000 =E2=80=93 0xFFC).

That's the reason why it is not explicit in the GTDT table :)

> +	data->size =3D SZ_4K;
> +	data->num_frames =3D block->timer_count;
> +
> +	frame =3D (void *)block + block->timer_offset;
> +	if (frame + block->timer_count !=3D (void *)block + block->header.len=
gth)
> +		return -EINVAL;
> +
> +	/*
> +	 * Get the GT timer Frame data for every GT Block Timer
> +	 */
> +	for (i =3D 0; i < block->timer_count; i++, frame++) {
> +		if (!frame->base_address || !frame->timer_interrupt)
> +			return -EINVAL;
> +
> +		data->frame[i].phys_irq =3D map_gt_gsi(frame->timer_interrupt,
> +						     frame->timer_flags);
> +		if (data->frame[i].phys_irq <=3D 0) {
> +			pr_warn("failed to map physical timer irq in frame %d.\n",
> +				i);
> +			return -EINVAL;
> +		}
> +
> +		if (frame->virtual_timer_interrupt) {
> +			data->frame[i].virt_irq =3D
> +				map_gt_gsi(frame->virtual_timer_interrupt,
> +					   frame->virtual_timer_flags);
> +			if (data->frame[i].virt_irq <=3D 0) {
> +				pr_warn("failed to map virtual timer irq in frame %d.\n",
> +					i);
> +				return -EINVAL;

You should unregister phys_irq here for correctness, right ?

> +			}
> +		}
> +
> +		data->frame[i].frame_nr =3D frame->frame_number;
> +		data->frame[i].cntbase =3D frame->base_address;
> +		/*
> +		 * We can NOT get the size info from GTDT table,
> +		 * but according to "Table * CNTBaseN memory map" of
> +		 * <ARM Architecture Reference Manual> for ARMv8,
> +		 * it should be 4KB(Offset 0x000 =E2=80=93 0xFFC).

See above.

> +		 */
> +		data->frame[i].size =3D SZ_4K;
> +	}
> +
> +	if (acpi_gtdt_desc.timer_block_count)
> +		pr_info("parsed No.%d of %d memory-mapped timer block(s).\n",
> +			index, acpi_gtdt_desc.timer_block_count);

I am not sure how helpful this message can be honestly.

> +
> +	return 0;
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a1611d1..44b8c1b 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -582,6 +582,7 @@ int acpi_gtdt_init(struct acpi_table_header *table)=
;
>  int acpi_gtdt_map_ppi(int type);
>  bool acpi_gtdt_c3stop(int type);
>  void acpi_gtdt_release(void);
> +int gtdt_arch_timer_mem_init(struct arch_timer_mem *data, unsigned int=
 index);

See above.

Overall it looks fine as long as the interface with clocksource is
settled, which is what really needs to be agreed upon in this series.

Lorenzo

>  #endif
> =20
>  #else	/* !CONFIG_ACPI */
> --=20
> 2.7.4
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
