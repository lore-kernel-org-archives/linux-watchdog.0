Return-path: <fu.wei@linaro.org>
Subject: Re: [PATCH v12 7/8] clocksource/drivers/arm_arch_timer: Add GTDT
 support for memory-mapped timer
To: Marc Zyngier <marc.zyngier@arm.com>, rjw@rjwysocki.net, lenb@kernel.org,
 daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com,
 lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, hanjun.guo@linaro.org
References: <1473763144-5653-1-git-send-email-fu.wei@linaro.org>
 <1473763144-5653-8-git-send-email-fu.wei@linaro.org>
 <57D7DC59.6000705@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
 timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org,
 jcm@redhat.com, wei@redhat.com, arnd@arndb.de, catalin.marinas@arm.com,
 will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, leo.duran@amd.com,
 wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org,
 tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com
From: Fu Wei <fu.wei@linaro.org>
Message-ID: <cc5a4eea-a8d9-3657-1938-610d2b4e855e@linaro.org>
Date: Tue, 13 Sep 2016 19:31:36 +0800
MIME-Version: 1.0
In-Reply-To: <57D7DC59.6000705@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Marc,


On 09/13/2016 07:00 PM, Marc Zyngier wrote:
> Argh, new version...
>
> On 13/09/16 11:39, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch add memory-mapped timer register support by using the information
>> provided by the new GTDT driver of ACPI.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 127 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 124 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 0197ef9..d33802b 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -888,7 +888,128 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>>  		       arch_timer_mem_init);
>>  
>>  #ifdef CONFIG_ACPI_GTDT
>> -/* Initialize per-processor generic timer */
>> +static struct gt_timer_data __init *arch_timer_mem_get_timer(
>> +						struct gt_block_data *gt_blocks)
>> +{
>> +	struct gt_block_data *gt_block = gt_blocks;
>> +	struct gt_timer_data *best_frame = NULL;
>> +	void __iomem *cntctlbase;
>> +	u32 cnttidr;
>> +	int i;
>> +
>> +	/*
>> +	 * According to ARMv8 Architecture Reference Manual(ARM),
>> +	 * the size of CNTCTLBase frame of memory-mapped timer
>> +	 * is SZ_4K(Offset 0x000 – 0xFFF).
>> +	 */
>> +	cntctlbase = ioremap(gt_block->cntctlbase_phy, SZ_4K);
>> +	if (!cntctlbase) {
>> +		pr_err("Failed to map mem timer control frame base address\n");
>> +		return NULL;
>> +	}
>> +	cnttidr = readl_relaxed(cntctlbase + CNTTIDR);
>> +
>> +	/*
>> +	 * Try to find a virtual capable frame. Otherwise fall back to a
>> +	 * physical capable frame.
>> +	 */
>> +	for (i = 0; i < gt_block->timer_count; i++) {
>> +		int n;
>> +		u32 cntacr;
>> +
>> +		n = gt_block->timer[i].frame_nr;
>> +
>> +		/* Try enabling everything, and see what sticks */
>> +		cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
>> +			 CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
>> +		writel_relaxed(cntacr, cntctlbase + CNTACR(n));
>> +		cntacr = readl_relaxed(cntctlbase + CNTACR(n));
>> +
>> +		if ((cnttidr & CNTTIDR_VIRT(n)) &&
>> +		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
>> +			best_frame = &gt_block->timer[i];
>> +			arch_timer_mem_use_virtual = true;
>> +			break;
>> +		}
>> +
>> +		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
>> +			continue;
>> +
>> +		best_frame = &gt_block->timer[i];
>> +	}
>> +	iounmap(cntctlbase);
> As I just said in my reply to the same patch in v11, all of this is
> duplicating existing infrastructure that already exists for DT. Please
> consider decoupling the core driver code from the firmware side and make
> this reusable.

Great thanks for your help, I am working on it now.
Any suggestion for other arm_arch_timer patches?

> Thanks,
>
> 	M.

-- 
Best regards,

Fu Wei
Software Engineer
Red Hat 
