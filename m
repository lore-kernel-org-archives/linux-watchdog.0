Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36657 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932650AbdC3Hyq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 30 Mar 2017 03:54:46 -0400
Received: by mail-io0-f182.google.com with SMTP id l7so14075478ioe.3
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Mar 2017 00:54:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170329164705.GA11442@red-moon>
References: <20170321163122.9183-1-fu.wei@linaro.org> <20170321163122.9183-10-fu.wei@linaro.org>
 <20170329164705.GA11442@red-moon>
From: Fu Wei <fu.wei@linaro.org>
Date: Thu, 30 Mar 2017 15:54:43 +0800
Message-ID: <CADyBb7vzrK1qRWgVsE7knGijD=b424236Sf9todeepR0EeOPaQ@mail.gmail.com>
Subject: Re: [PATCH v22 09/11] acpi/arm64: Add memory-mapped timer support in
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

On 30 March 2017 at 00:47, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Wed, Mar 22, 2017 at 12:31:20AM +0800, fu.wei@linaro.org wrote:
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
>>  drivers/acpi/arm64/gtdt.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/acpi.h      |   1 +
>>  2 files changed, 131 insertions(+)
>>
>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>> index 8a03b4b..f471873 100644
>> --- a/drivers/acpi/arm64/gtdt.c
>> +++ b/drivers/acpi/arm64/gtdt.c
>> @@ -37,6 +37,28 @@ struct acpi_gtdt_descriptor {
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
>> @@ -155,3 +177,111 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>>
>>       return ret;
>>  }
>> +
>> +static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
>> +                                      struct arch_timer_mem *timer_mem)
>> +{
>> +     int i, j;
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
>> +     for (i = 0, j = 0; i < block->timer_count; i++, gtdt_frame++) {
>> +             struct arch_timer_mem_frame *frame = &timer_mem->frame[j];
>> +
>> +             if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
>> +                     continue;
>> +
>> +             if (!gtdt_frame->base_address || !gtdt_frame->timer_interrupt)
>> +                     return -EINVAL;
>> +
>> +             frame->phys_irq = map_gt_gsi(gtdt_frame->timer_interrupt,
>> +                                          gtdt_frame->timer_flags);
>> +             if (frame->phys_irq <= 0) {
>> +                     pr_warn("failed to map physical timer irq in frame %d.\n",
>> +                             i);
>> +                     return -EINVAL;
>> +             }
>> +
>> +             frame->virt_irq =
>> +                     map_gt_gsi(gtdt_frame->virtual_timer_interrupt,
>> +                                gtdt_frame->virtual_timer_flags);
>> +             if (frame->virt_irq <= 0) {
>> +                     pr_warn("failed to map virtual timer irq in frame %d.\n",
>> +                             i);
>> +                     acpi_unregister_gsi(gtdt_frame->timer_interrupt);
>> +                     return -EINVAL;
>> +             }
>> +
>> +             frame->frame_nr = gtdt_frame->frame_number;
>> +             frame->cntbase = gtdt_frame->base_address;
>> +             /*
>> +              * The CNTBaseN frame is 4KB (register offsets 0x000 - 0xFFC).
>> +              * See ARM DDI 0487A.k_iss10775, page I1-5130, Table I1-4
>> +              * "CNTBaseN memory map".
>> +              */
>> +             frame->size = SZ_4K;
>> +             j++;
>> +     }
>> +     timer_mem->num_frames = j;
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>> + * acpi_arch_timer_mem_init() - Get the info of all GT blocks in GTDT table.
>> + * @timer_mem:       the pointer to the array of struct arch_timer_mem for returning
>> + *           the result of parsing. The element number of this array should
>> + *           be platform_timer_count(the total number of platform timers).
>> + * @count:   The pointer of int variate for returning the number of GT
>> + *           blocks we have parsed.
>
> Nit: this comment was wrong on all the patches I reviewed :) must be
> some copy and paste.

Thanks ,

 * @timer_count: It points to a integer variable which is used for storing the
 *                         number of GT blocks we have parsed.

Is that OK for you?
>
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
>
> Isn't there some unwinding to carry out here (eg GSI) ?

Thanks for your reminding,
it should be in gtdt_parse_timer_block, will do

>
> Otherwise it looks fine (minus Mark's request for using frame numbers
> as indexes that you should change).
>
> Lorenzo
>
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
