Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35301 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753804AbcKXD5Y (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 23 Nov 2016 22:57:24 -0500
Received: by mail-io0-f177.google.com with SMTP id a124so59390634ioe.2
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Nov 2016 19:57:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADyBb7sTVWC3d6kRDTA=SGYz9J4pwWvaJxXu3AMBAgQT4y7fTw@mail.gmail.com>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-14-git-send-email-fu.wei@linaro.org> <20161118142249.GA18029@red-moon>
 <CADyBb7sTVWC3d6kRDTA=SGYz9J4pwWvaJxXu3AMBAgQT4y7fTw@mail.gmail.com>
From: Fu Wei <fu.wei@linaro.org>
Date: Thu, 24 Nov 2016 11:57:23 +0800
Message-ID: <CADyBb7tqALWDSh2PK=aLTYfrPKpLnyj5ecgd4YGZcSe73XCwyA@mail.gmail.com>
Subject: Re: [PATCH v16 13/15] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

Hi Lorenzo,

On 23 November 2016 at 19:53, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Lorenzo,
>
> On 18 November 2016 at 22:22, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> On Wed, Nov 16, 2016 at 09:49:06PM +0800, fu.wei@linaro.org wrote:
>>> From: Fu Wei <fu.wei@linaro.org>
>>>
>>> On platforms booting with ACPI, architected memory-mapped timers'
>>> configuration data is provided by firmware through the ACPI GTDT
>>> static table.
>>>
>>> The clocksource architected timer kernel driver requires a firmware
>>> interface to collect timer configuration and configure its driver.
>>> this infrastructure is present for device tree systems, but it is
>>> missing on systems booting with ACPI.
>>>
>>> Implement the kernel infrastructure required to parse the static
>>> ACPI GTDT table so that the architected timer clocksource driver can
>>> make use of it on systems booting with ACPI, therefore enabling
>>> the corresponding timers configuration.
>>>
>>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> ---
>>>  drivers/acpi/arm64/gtdt.c | 95 +++++++++++++++++++++++++++++++++++++++=
++++++++
>>>  include/linux/acpi.h      |  1 +
>>>  2 files changed, 96 insertions(+)
>>>
>>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>>> index 2de79aa..08d9506 100644
>>> --- a/drivers/acpi/arm64/gtdt.c
>>> +++ b/drivers/acpi/arm64/gtdt.c
>>> @@ -51,6 +51,14 @@ static inline bool is_timer_block(void *platform_tim=
er)
>>>       return gh->type =3D=3D ACPI_GTDT_TYPE_TIMER_BLOCK;
>>>  }
>>>
>>> +static inline struct acpi_gtdt_timer_block *get_timer_block(unsigned i=
nt index)
>>> +{
>>> +     if (index >=3D acpi_gtdt_desc.timer_block_count || !timer_block)
>>> +             return NULL;
>>> +
>>> +     return timer_block[index];
>>> +}
>>> +
>>>  static inline bool is_watchdog(void *platform_timer)
>>>  {
>>>       struct acpi_gtdt_header *gh =3D platform_timer;
>>> @@ -214,3 +222,90 @@ int __init acpi_gtdt_init(struct acpi_table_header=
 *table)
>>>       acpi_gtdt_release();
>>>       return -EINVAL;
>>>  }
>>> +
>>> +/*
>>> + * Get ONE GT block info for memory-mapped timer from GTDT table.
>>> + * @data: the GT block data (parsing result)
>>> + * @index: the index number of GT block
>>> + * Note: we already verify @data in caller, it can't be NULL here.
>>> + * Returns 0 if success, -EINVAL/-ENODEV if error.
>>> + */
>>
>> Documentation/kernel-doc-nano-HOWTO.txt
>
> Great thanks , will fix all the comments :-)
>
>>
>>> +int __init gtdt_arch_timer_mem_init(struct arch_timer_mem *data,
>>> +                                 unsigned int index)
>>
>> Nit: acpi_arch_timer_mem_init() to make it consistent with other ACPI
>> calls ?
>
> yes, it makes sense, will do this way for the function  which is exported
>
>>
>>> +{
>>> +     struct acpi_gtdt_timer_block *block;
>>> +     struct acpi_gtdt_timer_entry *frame;
>>> +     int i;
>>> +
>>> +     block =3D get_timer_block(index);
>>> +     if (!block)
>>> +             return -ENODEV;
>>> +
>>> +     if (!block->timer_count) {
>>> +             pr_err(FW_BUG "GT block present, but frame count is zero.=
");
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     if (block->timer_count > ARCH_TIMER_MEM_MAX_FRAMES) {
>>> +             pr_err(FW_BUG "GT block lists %d frames, ACPI spec only a=
llows 8\n",
>>> +                    block->timer_count);
>>> +             return -EINVAL;
>>> +     }
>>
>> Nit: these two checks can be carried out at GTDT init where the GTDT
>> is parsed first. Actually you could have two functions one to init
>
> this check is  the verify the data in GT block, but the GTDT init
> won't get into the block,
> so I think that is better to keep this in GT block init function
> "acpi_arch_timer_mem_init()"
>
>> timers (say acpi_gtdt_timers_init()) and one watchdogs, that would
>> eliminate the duplicated timer_block/watchdog arrays (both sized
>> Platform Timer Count) and acpi_gtdt_timers_init() can return
>> the number of entries found so that you can loop with a determined
>> upper bound in the arm arch timer driver.
>
> Yes, I did this way in previous patchset, but we still need to do scan
> loop in both  functions for
> two types of platform timer.
> So I decide to keep the scan loop in the acpi_gtdt_init to get the
> number and the entries pointer
> of each type of platform timers in one go.  then we don't need to scan
> GTDT in two functions.

I have thought about this again, I think I should keep the loop in each
type of platform timers. The benefit we can get from this are:
(1) reduce the global variables:
static struct acpi_gtdt_timer_block **timer_block __initdata;
static struct acpi_gtdt_watchdog **watchdog __initdata;
make them in thire own init function.
(2) avoid allocating and free memory in different functions.

we also can return all the GT block info in one go.

>
>>
>> Just thinking aloud, these are just improvements I can carry them
>> out later, the more important question here is the interface between the
>> parsing code and the arch timer probing code which depends on other
>> patches and that needs to be agreed, this patch is not really a problem.
>
> yes, every time I modify the interface I have to change the driver :-(
>
>>
>>> +     data->cntctlbase =3D (phys_addr_t)block->block_address;
>>> +     /*
>>> +      * We can NOT get the size info from GTDT table,
>>> +      * but according to "Table * CNTCTLBase memory map" of
>>> +      * <ARM Architecture Reference Manual> for ARMv8,
>>> +      * it should be 4KB(Offset 0x000 =E2=80=93 0xFFC).
>>
>> That's the reason why it is not explicit in the GTDT table :)
>>
>>> +     data->size =3D SZ_4K;
>>> +     data->num_frames =3D block->timer_count;
>>> +
>>> +     frame =3D (void *)block + block->timer_offset;
>>> +     if (frame + block->timer_count !=3D (void *)block + block->header=
.length)
>>> +             return -EINVAL;
>>> +
>>> +     /*
>>> +      * Get the GT timer Frame data for every GT Block Timer
>>> +      */
>>> +     for (i =3D 0; i < block->timer_count; i++, frame++) {
>>> +             if (!frame->base_address || !frame->timer_interrupt)
>>> +                     return -EINVAL;
>>> +
>>> +             data->frame[i].phys_irq =3D map_gt_gsi(frame->timer_inter=
rupt,
>>> +                                                  frame->timer_flags);
>>> +             if (data->frame[i].phys_irq <=3D 0) {
>>> +                     pr_warn("failed to map physical timer irq in fram=
e %d.\n",
>>> +                             i);
>>> +                     return -EINVAL;
>>> +             }
>>> +
>>> +             if (frame->virtual_timer_interrupt) {
>>> +                     data->frame[i].virt_irq =3D
>>> +                             map_gt_gsi(frame->virtual_timer_interrupt=
,
>>> +                                        frame->virtual_timer_flags);
>>> +                     if (data->frame[i].virt_irq <=3D 0) {
>>> +                             pr_warn("failed to map virtual timer irq =
in frame %d.\n",
>>> +                                     i);
>>> +                             return -EINVAL;
>>
>> You should unregister phys_irq here for correctness, right ?
>
> yup, thanks for pointing this  bug out. :-)
>
>>
>>> +                     }
>>> +             }
>>> +
>>> +             data->frame[i].frame_nr =3D frame->frame_number;
>>> +             data->frame[i].cntbase =3D frame->base_address;
>>> +             /*
>>> +              * We can NOT get the size info from GTDT table,
>>> +              * but according to "Table * CNTBaseN memory map" of
>>> +              * <ARM Architecture Reference Manual> for ARMv8,
>>> +              * it should be 4KB(Offset 0x000 =E2=80=93 0xFFC).
>>
>> See above.
>
> yes, you are right, I will fix both comments
>
>>
>>> +              */
>>> +             data->frame[i].size =3D SZ_4K;
>>> +     }
>>> +
>>> +     if (acpi_gtdt_desc.timer_block_count)
>>> +             pr_info("parsed No.%d of %d memory-mapped timer block(s).=
\n",
>>> +                     index, acpi_gtdt_desc.timer_block_count);
>>
>> I am not sure how helpful this message can be honestly.
>
> yup, I will simplify it  :-)
>
>>
>>> +
>>> +     return 0;
>>> +}
>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>> index a1611d1..44b8c1b 100644
>>> --- a/include/linux/acpi.h
>>> +++ b/include/linux/acpi.h
>>> @@ -582,6 +582,7 @@ int acpi_gtdt_init(struct acpi_table_header *table)=
;
>>>  int acpi_gtdt_map_ppi(int type);
>>>  bool acpi_gtdt_c3stop(int type);
>>>  void acpi_gtdt_release(void);
>>> +int gtdt_arch_timer_mem_init(struct arch_timer_mem *data, unsigned int=
 index);
>>
>> See above.
>>
>> Overall it looks fine as long as the interface with clocksource is
>> settled, which is what really needs to be agreed upon in this series.
>
> Thanks for your help :-)
>
>>
>> Lorenzo
>>
>>>  #endif
>>>
>>>  #else        /* !CONFIG_ACPI */
>>> --
>>> 2.7.4
>>>
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat



--=20
Best regards,

Fu Wei
Software Engineer
Red Hat
