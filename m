Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:33414 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbdASJyh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 19 Jan 2017 04:54:37 -0500
Received: by mail-io0-f170.google.com with SMTP id v96so33596202ioi.0
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Jan 2017 01:54:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a47f2474-fb29-9217-3de1-6e2a6a36f21f@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org> <20170118132541.8989-12-fu.wei@linaro.org>
 <a47f2474-fb29-9217-3de1-6e2a6a36f21f@linaro.org>
From: Fu Wei <fu.wei@linaro.org>
Date: Thu, 19 Jan 2017 17:47:14 +0800
Message-ID: <CADyBb7uhwU_ACGQRvw8zPg-VCdxyO2L1MEoeZWS1zYdveLK6PA@mail.gmail.com>
Subject: Re: [PATCH v20 11/17] clocksource/drivers/arm_arch_timer: Introduce
 some new structs to prepare for GTDT
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
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

Hi Hanjun,

On 19 January 2017 at 16:28, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> On 2017/1/18 21:25, fu.wei@linaro.org wrote:
>>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch introduce two new structs: arch_timer_mem, arch_timer_mem_frame.
>> And also introduce a new define: ARCH_TIMER_MEM_MAX_FRAMES
>>
>> These will be used for refactoring the memory-mapped timer init code to
>> prepare for GTDT
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  include/clocksource/arm_arch_timer.h | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/include/clocksource/arm_arch_timer.h
>> b/include/clocksource/arm_arch_timer.h
>> index 4a98c06..b7dd185 100644
>> --- a/include/clocksource/arm_arch_timer.h
>> +++ b/include/clocksource/arm_arch_timer.h
>> @@ -57,6 +57,8 @@ enum arch_timer_spi_nr {
>>  #define ARCH_TIMER_MEM_PHYS_ACCESS     2
>>  #define ARCH_TIMER_MEM_VIRT_ACCESS     3
>>
>> +#define ARCH_TIMER_MEM_MAX_FRAMES      8
>> +
>>  #define ARCH_TIMER_USR_PCT_ACCESS_EN   (1 << 0) /* physical counter */
>>  #define ARCH_TIMER_USR_VCT_ACCESS_EN   (1 << 1) /* virtual counter */
>>  #define ARCH_TIMER_VIRT_EVT_EN         (1 << 2)
>> @@ -72,6 +74,21 @@ struct arch_timer_kvm_info {
>>         int virtual_irq;
>>  };
>>
>> +struct arch_timer_mem_frame {
>> +       int frame_nr;
>> +       phys_addr_t cntbase;
>> +       size_t size;
>> +       int phys_irq;
>> +       int virt_irq;
>> +};
>> +
>> +struct arch_timer_mem {
>> +       phys_addr_t cntctlbase;
>> +       size_t size;
>> +       int num_frames;
>> +       struct arch_timer_mem_frame frame[ARCH_TIMER_MEM_MAX_FRAMES];
>> +};
>
>
> Since struct is introduced but not used in this patch, how about
> squash it with patch 12/17?

In the previous patchset, I have been suggested that I should split it out.

>
> Thanks
> Hanjun



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
