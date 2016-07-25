Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34488 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752884AbcGYPbS (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Jul 2016 11:31:18 -0400
Date: Mon, 25 Jul 2016 16:31:19 +0100
From: Will Deacon <will.deacon@arm.com>
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, marc.zyngier@arm.com,
	lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
	hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, rruigrok@codeaurora.org,
	harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org,
	graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com,
	wei@redhat.com, arnd@arndb.de, wim@iguana.be,
	catalin.marinas@arm.com, Suravee.Suthikulpanit@amd.com,
	leo.duran@amd.com, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v9 4/9] clocksource/drivers/arm_arch_timer: use readq to
 get 64-bit CNTVCT
Message-ID: <20160725153118.GD19209@arm.com>
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org>
 <1469460427-8643-5-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1469460427-8643-5-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 25, 2016 at 11:27:02PM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> This patch simplify arch_counter_get_cntvct_mem function by
> using readq to get 64-bit CNTVCT value instead of readl_relaxed.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index e6fd42d..483d2f9 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -418,15 +418,7 @@ u32 arch_timer_get_rate(void)
>  
>  static u64 arch_counter_get_cntvct_mem(void)
>  {
> -	u32 vct_lo, vct_hi, tmp_hi;
> -
> -	do {
> -		vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
> -		vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
> -		tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
> -	} while (vct_hi != tmp_hi);
> -
> -	return ((u64) vct_hi << 32) | vct_lo;
> +	return readq(arch_counter_base + CNTVCT_LO);

Please drop this patch. It doesn't work.

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445369.html

Will
