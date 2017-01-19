Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34257 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdASI2l (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 19 Jan 2017 03:28:41 -0500
Received: by mail-pf0-f175.google.com with SMTP id e4so11789252pfg.1
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Jan 2017 00:28:41 -0800 (PST)
Subject: Re: [PATCH v20 11/17] clocksource/drivers/arm_arch_timer: Introduce
 some new structs to prepare for GTDT
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-12-fu.wei@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org,
        al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <a47f2474-fb29-9217-3de1-6e2a6a36f21f@linaro.org>
Date: Thu, 19 Jan 2017 16:28:30 +0800
MIME-Version: 1.0
In-Reply-To: <20170118132541.8989-12-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 2017/1/18 21:25, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> The patch introduce two new structs: arch_timer_mem, arch_timer_mem_frame.
> And also introduce a new define: ARCH_TIMER_MEM_MAX_FRAMES
>
> These will be used for refactoring the memory-mapped timer init code to
> prepare for GTDT
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  include/clocksource/arm_arch_timer.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 4a98c06..b7dd185 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -57,6 +57,8 @@ enum arch_timer_spi_nr {
>  #define ARCH_TIMER_MEM_PHYS_ACCESS	2
>  #define ARCH_TIMER_MEM_VIRT_ACCESS	3
>
> +#define ARCH_TIMER_MEM_MAX_FRAMES	8
> +
>  #define ARCH_TIMER_USR_PCT_ACCESS_EN	(1 << 0) /* physical counter */
>  #define ARCH_TIMER_USR_VCT_ACCESS_EN	(1 << 1) /* virtual counter */
>  #define ARCH_TIMER_VIRT_EVT_EN		(1 << 2)
> @@ -72,6 +74,21 @@ struct arch_timer_kvm_info {
>  	int virtual_irq;
>  };
>
> +struct arch_timer_mem_frame {
> +	int frame_nr;
> +	phys_addr_t cntbase;
> +	size_t size;
> +	int phys_irq;
> +	int virt_irq;
> +};
> +
> +struct arch_timer_mem {
> +	phys_addr_t cntctlbase;
> +	size_t size;
> +	int num_frames;
> +	struct arch_timer_mem_frame frame[ARCH_TIMER_MEM_MAX_FRAMES];
> +};

Since struct is introduced but not used in this patch, how about
squash it with patch 12/17?

Thanks
Hanjun
