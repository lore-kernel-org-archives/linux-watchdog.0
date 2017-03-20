Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:35483 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754553AbdCTNij (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Mar 2017 09:38:39 -0400
Received: by mail-it0-f51.google.com with SMTP id y18so33291251itc.0
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Mar 2017 06:38:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317194055.GE15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org> <20170206185015.12296-12-fu.wei@linaro.org>
 <20170317194055.GE15909@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Mon, 20 Mar 2017 21:38:16 +0800
Message-ID: <CADyBb7s0Bwn17YMSEwxmhrZ6E1pOJLdifZ-JJL+vqRBRD+H-dw@mail.gmail.com>
Subject: Re: [PATCH v21 11/13] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        G Gregory <graeme.gregory@linaro.org>,
        Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>,
        Wei Huang <wei@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Leo Duran <leo.duran@amd.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Julien Grall <julien.grall@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark,

On 18 March 2017 at 03:40, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Tue, Feb 07, 2017 at 02:50:13AM +0800, fu.wei@linaro.org wrote:
>> +static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *=
block,
>> +                                      struct arch_timer_mem *data)
>
> Please s/data/timer_mem/ here, to match the rest of the timer code.
>
>> +{
>> +     int i, j;
>> +     struct acpi_gtdt_timer_entry *frame;
>
> So as to make it clear what this is, and to make things a litlte simpler
> below, please s/frame/gtdt_frame/ here.
>
>> +
>> +     if (!block->timer_count) {
>> +             pr_err(FW_BUG "GT block present, but frame count is zero."=
);
>> +             return -ENODEV;
>> +     }
>> +
>> +     if (block->timer_count > ARCH_TIMER_MEM_MAX_FRAMES) {
>> +             pr_err(FW_BUG "GT block lists %d frames, ACPI spec only al=
lows 8\n",
>> +                    block->timer_count);
>> +             return -EINVAL;
>> +     }
>> +
>> +     data->cntctlbase =3D (phys_addr_t)block->block_address;
>> +     /*
>> +      * According to "Table * CNTCTLBase memory map" of
>> +      * <ARM Architecture Reference Manual> for ARMv8,
>> +      * The size of the CNTCTLBase frame is 4KB(Offset 0x000 =E2=80=93 =
0xFFC).
>> +      */
>
> As a general thing, please cite the version of the ARM ARM you're
> referring to, as over time the internal numbering (and the headings)
> change.
>
> e.g.
>         /*
>          * The CNTCTLBase frame is 4KB (register offsets 0x000 - 0xFFC).
>          * See ARM DDI 0487A.k_iss10775, page I1-5129, Table I1-3
>          * "CNTCTLBase memory map".
>          */
>
>> +     data->size =3D SZ_4K;
>> +
>> +     frame =3D (void *)block + block->timer_offset;
>> +     if (frame + block->timer_count !=3D (void *)block + block->header.=
length)
>> +             return -EINVAL;
>> +
>> +     /*
>> +      * Get the GT timer Frame data for every GT Block Timer
>> +      */
>> +     for (i =3D 0, j =3D 0; i < block->timer_count; i++, frame++) {
>
> With the gtdt_frame rename as above, here we can do:
>
>         struct arch_timer_mem_frame *frame =3D &timer_mem->frame[j];
>
>> +             if (frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
>> +                     continue;
>> +
>> +             if (!frame->base_address || !frame->timer_interrupt)
>> +                     return -EINVAL;
>> +
>> +             data->frame[j].phys_irq =3D map_gt_gsi(frame->timer_interr=
upt,
>> +                                                  frame->timer_flags);
>
> ... allowing us to simplify lines like this.

Thanks, will follow all the suggestion above.
:-)

>
> Thanks,
> Mark.



--=20
Best regards,

Fu Wei
Software Engineer
Red Hat
