Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751049AbdCQTlQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Mar 2017 15:41:16 -0400
Date: Fri, 17 Mar 2017 19:40:55 +0000
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
Subject: Re: [PATCH v21 11/13] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
Message-ID: <20170317194055.GE15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-12-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170206185015.12296-12-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 07, 2017 at 02:50:13AM +0800, fu.wei@linaro.org wrote:
> +static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block =
*block,
> +					 struct arch_timer_mem *data)

Please s/data/timer_mem/ here, to match the rest of the timer code.

> +{
> +	int i, j;
> +	struct acpi_gtdt_timer_entry *frame;

So as to make it clear what this is, and to make things a litlte simpler
below, please s/frame/gtdt_frame/ here.

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
> +
> +	data->cntctlbase =3D (phys_addr_t)block->block_address;
> +	/*
> +	 * According to "Table * CNTCTLBase memory map" of
> +	 * <ARM Architecture Reference Manual> for ARMv8,
> +	 * The size of the CNTCTLBase frame is 4KB(Offset 0x000 =E2=80=93 0xF=
FC).
> +	 */

As a general thing, please cite the version of the ARM ARM you're
referring to, as over time the internal numbering (and the headings)
change.

e.g.
	/*
	 * The CNTCTLBase frame is 4KB (register offsets 0x000 - 0xFFC).
	 * See ARM DDI 0487A.k_iss10775, page I1-5129, Table I1-3
	 * "CNTCTLBase memory map".
	 */

> +	data->size =3D SZ_4K;
> +
> +	frame =3D (void *)block + block->timer_offset;
> +	if (frame + block->timer_count !=3D (void *)block + block->header.len=
gth)
> +		return -EINVAL;
> +
> +	/*
> +	 * Get the GT timer Frame data for every GT Block Timer
> +	 */
> +	for (i =3D 0, j =3D 0; i < block->timer_count; i++, frame++) {

With the gtdt_frame rename as above, here we can do:

	struct arch_timer_mem_frame *frame =3D &timer_mem->frame[j];

> +		if (frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
> +			continue;
> +
> +		if (!frame->base_address || !frame->timer_interrupt)
> +			return -EINVAL;
> +
> +		data->frame[j].phys_irq =3D map_gt_gsi(frame->timer_interrupt,
> +						     frame->timer_flags);

... allowing us to simplify lines like this.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
