Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751802AbcKRSxi (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 Nov 2016 13:53:38 -0500
Date: Fri, 18 Nov 2016 18:52:52 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rruigrok@codeaurora.org,
        harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org,
        graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com,
        wei@redhat.com, arnd@arndb.de, catalin.marinas@arm.com,
        will.deacon@arm.com, Suravee.Suthikulpanit@amd.com,
        leo.duran@amd.com, wim@iguana.be, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, tn@semihalf.com,
        christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v16 05/15] clocksource/drivers/arm_arch_timer: fix a bug
 in arch_timer_register about arch_timer_uses_ppi
Message-ID: <20161118185252.GI1197@leverpostej>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-6-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479304148-2965-6-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 16, 2016 at 09:48:58PM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The patch fix a potential bug about arch_timer_uses_ppi in
> arch_timer_register.
> On ARM64, we don't use ARCH_TIMER_PHYS_SECURE_PPI in Linux, so we will
> just igorne it in init code. 

That's not currently the case. I assume you mean we will in later
patches? If so, please make that clear in the commit message.

> If arch_timer_uses_ppi is ARCH_TIMER_PHYS_NONSECURE_PPI, the orignal
> code of arch_timer_uses_ppi may go wrong.

How? What specifically happens?

We don't currently assign ARCH_TIMER_PHYS_NONSECURE_PPI to
arch_timer_uses_ppi, so I assume a later patch changes this. This change
should be folded into said patch; it doesn't make sense in isolation.

Thanks,
Mark.

> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index dd1040d..6de164f 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -699,7 +699,7 @@ static int __init arch_timer_register(void)
>  	case ARCH_TIMER_PHYS_NONSECURE_PPI:
>  		err = request_percpu_irq(ppi, arch_timer_handler_phys,
>  					 "arch_timer", arch_timer_evt);
> -		if (!err && arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]) {
> +		if (!err && arch_timer_has_nonsecure_ppi()) {
>  			ppi = arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI];
>  			err = request_percpu_irq(ppi, arch_timer_handler_phys,
>  						 "arch_timer", arch_timer_evt);
> -- 
> 2.7.4
> 
