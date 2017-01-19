Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33898 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbdASIEY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 19 Jan 2017 03:04:24 -0500
Received: by mail-pg0-f44.google.com with SMTP id 14so12220426pgg.1
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Jan 2017 00:02:54 -0800 (PST)
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-9-fu.wei@linaro.org>
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
Message-ID: <cafa8c7a-9c7c-51ba-5566-0cfe1fe6f764@linaro.org>
Date: Thu, 19 Jan 2017 16:02:28 +0800
MIME-Version: 1.0
In-Reply-To: <20170118132541.8989-9-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fuwei,

One comments below.

On 2017/1/18 21:25, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> The counter frequency detection call(arch_timer_detect_rate) combines two
> ways to get counter frequency: system coprocessor register and MMIO timer.
> But in a specific timer init code, we only need one way to try:
> getting frequency from MMIO timer register will be needed only when we
> init MMIO timer; getting frequency from system coprocessor register will
> be needed only when we init arch timer.
>
> This patch separates paths to determine frequency:
> Separate out the MMIO frequency and the sysreg frequency detection call,
> and use the appropriate one for the counter.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 40 ++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 6484f84..9482481 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -488,23 +488,33 @@ static int arch_timer_starting_cpu(unsigned int cpu)
>  	return 0;
>  }
>
> -static void arch_timer_detect_rate(void __iomem *cntbase)
> +static void __arch_timer_determine_rate(u32 rate)
>  {
> -	/* Who has more than one independent system counter? */
> -	if (arch_timer_rate)
> -		return;
> +	/* Check the timer frequency. */
> +	if (!arch_timer_rate) {
> +		if (rate)
> +			arch_timer_rate = rate;
> +		else
> +			pr_warn("frequency not available\n");
> +	} else if (rate && arch_timer_rate != rate) {
                         ^
Typo? I think it's "&" here.

Thanks
Hanjun
