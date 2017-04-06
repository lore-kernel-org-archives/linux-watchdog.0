Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:34503 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933053AbdDFRLf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Apr 2017 13:11:35 -0400
Received: by mail-io0-f174.google.com with SMTP id b140so34041680iof.1
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Apr 2017 10:11:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403104558.GA32414@red-moon>
References: <20170331175105.8370-1-fu.wei@linaro.org> <20170331175105.8370-10-fu.wei@linaro.org>
 <20170403104558.GA32414@red-moon>
From: Fu Wei <fu.wei@linaro.org>
Date: Fri, 7 Apr 2017 01:11:33 +0800
Message-ID: <CADyBb7uVfmc6d6Fcd2xJcXdCy87iSdVW9hQQdzOy+Y4FK0OrwA@mail.gmail.com>
Subject: Re: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in
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
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lorenzo,

On 3 April 2017 at 18:45, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Sat, Apr 01, 2017 at 01:51:03AM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> On platforms booting with ACPI, architected memory-mapped timers'
>> configuration data is provided by firmware through the ACPI GTDT
>> static table.
>>
>> The clocksource architected timer kernel driver requires a firmware
>> interface to collect timer configuration and configure its driver.
>> this infrastructure is present for device tree systems, but it is
>> missing on systems booting with ACPI.
>>
>> Implement the kernel infrastructure required to parse the static
>> ACPI GTDT table so that the architected timer clocksource driver can
>> make use of it on systems booting with ACPI, therefore enabling
>> the corresponding timers configuration.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  drivers/acpi/arm64/gtdt.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/acpi.h      |   1 +
>>  2 files changed, 147 insertions(+)
>>
>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>> index 3d95af8..3dd33f3 100644
>> --- a/drivers/acpi/arm64/gtdt.c
>> +++ b/drivers/acpi/arm64/gtdt.c
>> @@ -13,6 +13,7 @@
>>
>>  #include <linux/acpi.h>
>>  #include <linux/init.h>
>> +#include <linux/irqdomain.h>
>>  #include <linux/kernel.h>
>>
>>  #include <clocksource/arm_arch_timer.h>
>> @@ -37,6 +38,28 @@ struct acpi_gtdt_descriptor {
>>
>>  static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
>>
>> +static inline void *next_platform_timer(void *platform_timer)
>> +{
>> +     struct acpi_gtdt_header *gh = platform_timer;
>> +
>> +     platform_timer += gh->length;
>> +     if (platform_timer < acpi_gtdt_desc.gtdt_end)
>> +             return platform_timer;
>> +
>> +     return NULL;
>> +}
>> +
>> +#define for_each_platform_timer(_g)                          \
>> +     for (_g = acpi_gtdt_desc.platform_timer; _g;    \
>> +          _g = next_platform_timer(_g))
>> +
>> +static inline bool is_timer_block(void *platform_timer)
>> +{
>> +     struct acpi_gtdt_header *gh = platform_timer;
>> +
>> +     return gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK;
>> +}
>> +
>>  static int __init map_gt_gsi(u32 interrupt, u32 flags)
>>  {
>>       int trigger, polarity;
>> @@ -155,3 +178,126 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>>
>>       return 0;
>>  }
>> +
>> +static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
>> +                                      struct arch_timer_mem *timer_mem)
>> +{
>> +     int i;
>> +     struct arch_timer_mem_frame *frame;
>> +     struct acpi_gtdt_timer_entry *gtdt_frame;
>> +
>> +     if (!block->timer_count) {
>> +             pr_err(FW_BUG "GT block present, but frame count is zero.");
>> +             return -ENODEV;
>> +     }
>> +
>> +     if (block->timer_count > ARCH_TIMER_MEM_MAX_FRAMES) {
>> +             pr_err(FW_BUG "GT block lists %d frames, ACPI spec only allows 8\n",
>> +                    block->timer_count);
>> +             return -EINVAL;
>> +     }
>> +
>> +     timer_mem->cntctlbase = (phys_addr_t)block->block_address;
>> +     /*
>> +      * The CNTCTLBase frame is 4KB (register offsets 0x000 - 0xFFC).
>> +      * See ARM DDI 0487A.k_iss10775, page I1-5129, Table I1-3
>> +      * "CNTCTLBase memory map".
>> +      */
>> +     timer_mem->size = SZ_4K;
>> +
>> +     gtdt_frame = (void *)block + block->timer_offset;
>> +     if (gtdt_frame + block->timer_count != (void *)block + block->header.length)
>> +             return -EINVAL;
>> +
>> +     /*
>> +      * Get the GT timer Frame data for every GT Block Timer
>> +      */
>> +     for (i = 0; i < block->timer_count; i++, gtdt_frame++) {
>> +             if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
>> +                     continue;
>> +
>> +             if (!gtdt_frame->base_address || !gtdt_frame->timer_interrupt)
>> +                     goto error;
>> +
>> +             frame = &timer_mem->frame[gtdt_frame->frame_number];
>> +             frame->phys_irq = map_gt_gsi(gtdt_frame->timer_interrupt,
>> +                                          gtdt_frame->timer_flags);
>> +             if (frame->phys_irq <= 0) {
>> +                     pr_warn("failed to map physical timer irq in frame %d.\n",
>> +                             gtdt_frame->frame_number);
>> +                     goto error;
>> +             }
>> +
>> +             if (gtdt_frame->virtual_timer_interrupt) {
>> +                     frame->virt_irq =
>> +                             map_gt_gsi(gtdt_frame->virtual_timer_interrupt,
>> +                                        gtdt_frame->virtual_timer_flags);
>> +                     if (frame->virt_irq <= 0) {
>> +                             pr_warn("failed to map virtual timer irq in frame %d.\n",
>> +                                     gtdt_frame->frame_number);
>> +                             acpi_unregister_gsi(gtdt_frame->timer_interrupt);
>> +                             goto error;
>> +                     }
>> +             } else {
>> +                     frame->virt_irq = 0;
>> +                     pr_debug("virtual timer in frame %d not implemented.\n",
>> +                              gtdt_frame->frame_number);
>> +             }
>> +
>> +             frame->cntbase = gtdt_frame->base_address;
>> +             /*
>> +              * The CNTBaseN frame is 4KB (register offsets 0x000 - 0xFFC).
>> +              * See ARM DDI 0487A.k_iss10775, page I1-5130, Table I1-4
>> +              * "CNTBaseN memory map".
>> +              */
>> +             frame->size = SZ_4K;
>> +             frame->valid = true;
>> +     }
>> +
>> +     return 0;
>> +
>> +error:
>> +     for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
>> +             frame = &timer_mem->frame[i];
>> +             if (!frame->valid)
>> +                     continue;
>> +             irq_dispose_mapping(frame->phys_irq);
>> +             if (frame->virt_irq)
>> +                     irq_dispose_mapping(frame->virt_irq);
>> +     }
>
> You should unregister GSIs with the same API you use to register GSIs,
> I do not like code that assumes acpi_unregister_gsi() internal
> implementation, it is wrong to do that.

Thanks for pointing it out, I have thought about it.
But the the same API I use to register GSIs is acpi_unregister_gsi(GSI);
that means we need GSI as the parameter. But when the register goes
wrong, and goto error, the info we have is the IRQ but not GSI. So I
use the  acpi_unregister_gsi() internal implementation.
If we try to use the same API, we may need to add this info into
struct arch_timer_mem_frame only for unwinding.

But yes, we do have another way to do, that is  registering GSI untill
we figure out which is the "best_frame". But this requires some bigger
change(like using the  irq_of_parse_and_map() internal implementation
to get GSI but don't map), and map GSI untill get the "best_frame" .

which way do you prefer?

But I will unify the API in v24

>
> Other than that patch is ok:
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
>> +     return -EINVAL;
>> +}
>> +
>> +/**
>> + * acpi_arch_timer_mem_init() - Get the info of all GT blocks in GTDT table.
>> + * @timer_mem:       The pointer to the array of struct arch_timer_mem for returning
>> + *           the result of parsing. The element number of this array should
>> + *           be platform_timer_count(the total number of platform timers).
>> + * @timer_count: It points to a integer variable which is used for storing the
>> + *           number of GT blocks we have parsed.
>> + *
>> + * Return: 0 if success, -EINVAL/-ENODEV if error.
>> + */
>> +int __init acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem,
>> +                                 int *timer_count)
>> +{
>> +     int ret;
>> +     void *platform_timer;
>> +
>> +     *timer_count = 0;
>> +     for_each_platform_timer(platform_timer) {
>> +             if (is_timer_block(platform_timer)) {
>> +                     ret = gtdt_parse_timer_block(platform_timer, timer_mem);
>> +                     if (ret)
>> +                             return ret;
>> +                     timer_mem++;
>> +                     (*timer_count)++;
>> +             }
>> +     }
>> +
>> +     if (*timer_count)
>> +             pr_info("found %d memory-mapped timer block(s).\n",
>> +                     *timer_count);
>> +
>> +     return 0;
>> +}
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 4b5c146..3193724 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -599,6 +599,7 @@ int acpi_reconfig_notifier_unregister(struct notifier_block *nb);
>>  int acpi_gtdt_init(struct acpi_table_header *table, int *platform_timer_count);
>>  int acpi_gtdt_map_ppi(int type);
>>  bool acpi_gtdt_c3stop(int type);
>> +int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int *timer_count);
>>  #endif
>>
>>  #else        /* !CONFIG_ACPI */
>> --
>> 2.9.3
>>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
