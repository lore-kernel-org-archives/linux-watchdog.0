Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20160714134251.GA30657@red-moon>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
 <1468432402-4872-8-git-send-email-fu.wei@linaro.org> <20160714134251.GA30657@red-moon>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 20 Jul 2016 02:28:04 +0800
Message-ID: <CADyBb7vZTv9Gj5iUaXvgNK98kUcBDXgdyF05DMqovW19bSxe6g@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org,
	Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Leo Duran <leo.duran@amd.com>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kvalo@codeaurora.org, mchehab@kernel.org,
	Jiri Slaby <jslaby@suse.cz>, Christoffer Dall <christoffer.dall@linaro.org>,
	Julien Grall <julien.grall@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Lorenzo,

I have updated my patchset following all your comments.
I have just posted v8 patchset, please check.

Great thanks for your comments, they are very helpful :-)

On 14 July 2016 at 21:42, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Thu, Jul 14, 2016 at 01:53:20AM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This driver adds support for parsing memory-mapped timer in GTDT:
>> provide a kernel APIs to parse GT Block Structure in GTDT,
>> export all the info by filling the struct which provided
>> by parameter(pointer of the struct).
>>
>> By this driver, we can add ACPI support for memory-mapped timer in
>> arm_arch_timer drivers, and separate the ACPI GTDT knowledge from it.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  drivers/acpi/arm64/acpi_gtdt.c       | 90 ++++++++++++++++++++++++++++++++++++
>>  include/clocksource/arm_arch_timer.h | 15 ++++++
>>  include/linux/acpi.h                 |  1 +
>>  3 files changed, 106 insertions(+)
>>
>> diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_gtdt.c
>> index 9ee977d..ff62953 100644
>> --- a/drivers/acpi/arm64/acpi_gtdt.c
>> +++ b/drivers/acpi/arm64/acpi_gtdt.c
>> @@ -168,3 +168,93 @@ int __init gtdt_arch_timer_init(struct acpi_table_header *table)
>>
>>       return -EINVAL;
>>  }
>> +
>> +/*
>> + * Helper function for getting the pointer of a timer frame in GT block.
>> + */
>> +static void __init *gtdt_gt_timer_frame(struct acpi_gtdt_timer_block *gt_block,
>> +                                     int index)
>> +{
>> +     void *timer_frame = (void *)gt_block + gt_block->timer_offset +
>> +                         sizeof(struct acpi_gtdt_timer_entry) * index;
>> +
>> +     if (timer_frame <= (void *)gt_block + gt_block->header.length -
>> +                        sizeof(struct acpi_gtdt_timer_entry))
>> +             return timer_frame;
>
> Nit: gt_block is an array, right ? I think it would be much simpler
> if you treat is as such, so that indexing into it would be done
> automatically by the compiler. Actually, I do not even think you
> would need this function at all if you treat gt_block as an array,
> the length check could be done in gtdt_parse_gt_block() straight
> away.
>
>> +
>> +     return NULL;
>> +}
>> +
>> +static int __init gtdt_parse_gt_block(void *platform_timer, int index,
>> +                                   void *data)
>> +{
>> +     struct acpi_gtdt_timer_block *block;
>> +     struct acpi_gtdt_timer_entry *frame;
>> +     struct gt_block_data *block_data;
>> +     int i, j;
>> +
>> +     if (!platform_timer || !data)
>> +             return -EINVAL;
>> +
>> +     block = platform_timer;
>> +     block_data = data + sizeof(struct gt_block_data) * index;
>
> Nit: See above, data is a struct gt_block_data[] right ? These void
> pointers parameters are not really great, the caller context
> knows what they are and it can pass them as pointer to typed
> array elements anyway unless I am missing something.
>
>> +     if (!block->block_address || !block->timer_count) {
>> +             pr_err(FW_BUG "invalid GT Block data.\n");
>> +             return -EINVAL;
>> +     }
>> +     block_data->cntctlbase_phy = (phys_addr_t)block->block_address;
>> +     block_data->timer_count = block->timer_count;
>> +
>> +     /*
>> +      * Get the GT timer Frame data for every GT Block Timer
>> +      */
>> +     for (i = 0, j = 0; i < block->timer_count; i++) {
>
> What's j needed for (ie can't you use just i instead ?) ?
>
>> +             frame = gtdt_gt_timer_frame(block, i);
>> +             if (!frame || !frame->base_address || !frame->timer_interrupt) {
>> +                     pr_err(FW_BUG "invalid GT Block Timer data.\n");
>> +                     return -EINVAL;
>> +             }
>> +             block_data->timer[j].frame_nr = frame->frame_number;
>> +             block_data->timer[j].cntbase_phy = frame->base_address;
>> +             block_data->timer[j].irq = map_generic_timer_interrupt(
>> +                                                frame->timer_interrupt,
>> +                                                frame->timer_flags);
>> +             if (frame->virtual_timer_interrupt)
>> +                     block_data->timer[j].virt_irq =
>> +                             map_generic_timer_interrupt(
>> +                                     frame->virtual_timer_interrupt,
>> +                                     frame->virtual_timer_flags);
>> +             j++;
>> +     }
>> +
>> +     if (j)
>> +             return 0;
>> +
>> +     block_data->cntctlbase_phy = (phys_addr_t)NULL;
>
> This is wrong. NULL is not meant to be used as a physical address,
> you must not do that. Is not zeroeing timer_count enough ? I have
> to understand why you need this because casting NULL into it is
> not safe, at all.
>
>> +     block_data->timer_count = 0;
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +/*
>> + * Get the GT block info for memory-mapped timer from GTDT table.
>> + * Please make sure we have called gtdt_arch_timer_init, because it helps to
>> + * init the global variables.
>
> It is a helper function that you call once at boot, you easily
> determine when it is called, it is not meant to be used in different
> contexts from different subsystems; I think that this comment
> is not clear so either you make it clearer or you remove it.
>
>> + */
>> +int __init gtdt_arch_timer_mem_init(struct gt_block_data *data)
>> +{
>> +     void *platform_timer;
>> +     int index = 0;
>> +
>> +     for_each_platform_timer(platform_timer) {
>> +             if (is_timer_block(platform_timer) &&
>> +                 !gtdt_parse_gt_block(platform_timer, index, data))
>
> Passing around these opaque void* is a tad ugly, see my comments
> above about this.
>
> Apart from the NULL pointer assignment, everything else is just code
> clean-up.
>
> Thanks,
> Lorenzo
>
>> +                     index++;
>> +     }
>> +
>> +     if (index)
>> +             pr_info("found %d memory-mapped timer block.\n", index);
>> +
>> +     return index;
>> +}
>> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
>> index 16dcd10..ece6b3b 100644
>> --- a/include/clocksource/arm_arch_timer.h
>> +++ b/include/clocksource/arm_arch_timer.h
>> @@ -56,6 +56,8 @@ enum spi_nr {
>>  #define ARCH_TIMER_MEM_PHYS_ACCESS   2
>>  #define ARCH_TIMER_MEM_VIRT_ACCESS   3
>>
>> +#define ARCH_TIMER_MEM_MAX_FRAME     8
>> +
>>  #define ARCH_TIMER_USR_PCT_ACCESS_EN (1 << 0) /* physical counter */
>>  #define ARCH_TIMER_USR_VCT_ACCESS_EN (1 << 1) /* virtual counter */
>>  #define ARCH_TIMER_VIRT_EVT_EN               (1 << 2)
>> @@ -71,6 +73,19 @@ struct arch_timer_kvm_info {
>>       int virtual_irq;
>>  };
>>
>> +struct gt_timer_data {
>> +     int frame_nr;
>> +     phys_addr_t cntbase_phy;
>> +     int irq;
>> +     int virt_irq;
>> +};
>> +
>> +struct gt_block_data {
>> +     phys_addr_t cntctlbase_phy;
>> +     int timer_count;
>> +     struct gt_timer_data timer[ARCH_TIMER_MEM_MAX_FRAME];
>> +};
>> +
>>  #ifdef CONFIG_ARM_ARCH_TIMER
>>
>>  extern u32 arch_timer_get_rate(void);
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 8439579..b1cacbc 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -536,6 +536,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *);
>>  int __init gtdt_arch_timer_init(struct acpi_table_header *table);
>>  int __init acpi_gtdt_map_ppi(int type);
>>  int __init acpi_gtdt_c3stop(void);
>> +int __init gtdt_arch_timer_mem_init(struct gt_block_data *data);
>>  #endif
>>
>>  #else        /* !CONFIG_ACPI */
>> --
>> 2.5.5
>>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
