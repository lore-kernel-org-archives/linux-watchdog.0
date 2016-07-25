Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33030 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbcGYQGL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Jul 2016 12:06:11 -0400
Received: by mail-oi0-f54.google.com with SMTP id j185so258382469oih.0
        for <linux-watchdog@vger.kernel.org>; Mon, 25 Jul 2016 09:06:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160721124053.GB7982@red-moon>
References: <1468952284-28942-1-git-send-email-fu.wei@linaro.org>
 <1468952284-28942-8-git-send-email-fu.wei@linaro.org> <20160721124053.GB7982@red-moon>
From: Fu Wei <fu.wei@linaro.org>
Date: Tue, 26 Jul 2016 00:06:10 +0800
Message-ID: <CADyBb7uuYrKu6=3kQm0HbqSHZocW7YBooh+PRGB7_rADyfGEkg@mail.gmail.com>
Subject: Re: [PATCH v8 7/9] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	rruigrok@codeaurora.org, harba@codeaurora.org,
	Christopher Covington <cov@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>,
	wei@redhat.com, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Leo Duran <leo.duran@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lorenzo,

On 21 July 2016 at 20:40, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Wed, Jul 20, 2016 at 02:18:02AM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This driver adds support for parsing memory-mapped timer in GTDT:
>> provide a kernel APIs to parse GT Block Structure in GTDT,
>> export all the info by filling the struct which provided
>> by parameter(pointer of the struct).
>>
>> By this driver, we can add ACPI support for memory-mapped timer in
>> arm_arch_timer drivers, and separate the ACPI GTDT knowledge from it.
>
> "On platforms booting with ACPI, architected memory timers configuration
> data is provided by firmware through the ACPI GTDT static table.
>
> The clocksource architected timer kernel driver requires a firmware
> interface to collect timer configuration and configure its driver;
> this infrastructure is present for device tree systems but it is
> missing on systems booting with ACPI.
>
> Implement the kernel infrastructure required to parse the static
> ACPI GTDT table so that the architected timer clocksource driver can
> make use of it on systems booting with ACPI, therefore enabling
> the corresponding timers configuration."

Thanks , I  have used it in my v9 patchset

>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  drivers/acpi/arm64/acpi_gtdt.c       | 72 ++++++++++++++++++++++++++++++++++++
>>  include/clocksource/arm_arch_timer.h | 15 ++++++++
>>  include/linux/acpi.h                 |  1 +
>>  3 files changed, 88 insertions(+)
>>
>> diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_gtdt.c
>> index e1cfc9e..b48e443 100644
>> --- a/drivers/acpi/arm64/acpi_gtdt.c
>> +++ b/drivers/acpi/arm64/acpi_gtdt.c
>> @@ -150,3 +150,75 @@ int __init acpi_gtdt_init(struct acpi_table_header *table)
>>
>>       return gtdt->platform_timer_count;
>>  }
>> +
>> +static int __init gtdt_parse_gt_block(void *platform_timer,
>> +                                   struct gt_block_data *data)
>> +{
>
> Nit: you can directly pass a struct acpi_gtdt_timer_block* pointer.

good idea, :-)
>
>> +     struct acpi_gtdt_timer_block *block = platform_timer;
>> +     struct acpi_gtdt_timer_entry *frame;
>> +     int i;
>> +
>> +     if (!block || !data)
>> +             return -EINVAL;
>> +
>> +     if (!block->block_address || !block->timer_count)
>> +             goto error;
>
> Here we jump to print an error and bail out. The only reason
> why we need a goto is to print a common error message and that's
> exactly what we do _not_ need, if there is a FW error we want
> to understand which one is that, otherwise the information you
> are printing is useless for debugging (provided we can make use
> of this info, which is questionable anyway).

yes, I have fixed in my v9

>
>> +     data->cntctlbase_phy = (phys_addr_t)block->block_address;
>> +     data->timer_count = block->timer_count;
>> +
>> +     frame = (void *)block + block->timer_offset;
>> +     if (frame + block->timer_count != (void *)block + block->header.length)
>> +             goto error;
>
> See above.
>
>> +     /*
>> +      * Get the GT timer Frame data for every GT Block Timer
>> +      */
>> +     for (i = 0; i < block->timer_count; i++) {
>> +             frame += i;
>
> This is wrong, if you have multiple frames, pointers would add up and
> that's not correct.

Great thanks for pointing it out, this is a bug, I have fixed it in my v9.

Thanks for your help

>
>> +             if (!frame->base_address || !frame->timer_interrupt)
>> +                     goto error;
>
> See above.
>
>> +             data->timer[i].frame_nr = frame->frame_number;
>> +             data->timer[i].cntbase_phy = frame->base_address;
>> +             data->timer[i].irq =
>> +                     map_generic_timer_interrupt(frame->timer_interrupt,
>> +                                                 frame->timer_flags);
>
> AFAIK map_generic_timer_interrupt() may fail, you should cater for that.
>
>> +             if (frame->virtual_timer_interrupt)
>> +                     data->timer[i].virt_irq =
>> +                             map_generic_timer_interrupt(
>> +                                     frame->virtual_timer_interrupt,
>> +                                     frame->virtual_timer_flags);
>
> Ditto.
>
>> +     }
>> +     return 0;
>> +
>> +error:
>> +     pr_err(FW_BUG "invalid GT Block data.\n");
>> +     return -EINVAL;
>
> See above.
>
>> +}
>> +
>> +/*
>> + * Get the GT block info for memory-mapped timer from GTDT table.
>> + * Please make sure we have called acpi_gtdt_init, because it helps to
>> + * init the global variables.
>
> I already commented on this. I think the second part of this comment
> is useless (it is a function with one caller, make sure you respect
> the calling sequence and be done with this).

I have deleted the second part  in my v9 , thanks :-)

>
> Thanks,
> Lorenzo
>
>> + */
>> +int __init gtdt_arch_timer_mem_init(struct gt_block_data *data)
>> +{
>> +     void *platform_timer;
>> +     int index = 0;
>> +     int ret;
>> +
>> +     for_each_platform_timer(platform_timer) {
>> +             if (!is_timer_block(platform_timer))
>> +                     continue;
>> +             ret = gtdt_parse_gt_block(platform_timer, data + index);
>> +             if (ret)
>> +                     return ret;
>> +             index++;
>> +     }
>> +
>> +     if (index)
>> +             pr_info("found %d memory-mapped timer block(s).\n", index);
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
>> index fb8b689..24b1750 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -536,6 +536,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *);
>>  int acpi_gtdt_init(struct acpi_table_header *table);
>>  int acpi_gtdt_map_ppi(int type);
>>  bool acpi_gtdt_c3stop(void);
>> +int gtdt_arch_timer_mem_init(struct gt_block_data *data);
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
