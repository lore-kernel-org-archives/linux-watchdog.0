Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:47064 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752443AbcLHVe5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 8 Dec 2016 16:34:57 -0500
Message-ID: <1481231430.5946.34.camel@perches.com>
Subject: Re: [PATCH v18 03/15] clocksource/drivers/arm_arch_timer: Improve
 printk relevant code
From: Joe Perches <joe@perches.com>
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org,
        al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com
Date: Thu, 08 Dec 2016 13:10:30 -0800
In-Reply-To: <20161208173319.6618-4-fu.wei@linaro.org>
References: <20161208173319.6618-1-fu.wei@linaro.org>
         <20161208173319.6618-4-fu.wei@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 2016-12-09 at 01:33 +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> This patch defines pr_fmt(fmt) for all pr_* functions,
> then the pr_* doesn't need to add "arch_timer:" everytime.

trivia:

> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
[]
> @@ -966,7 +967,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
>  
>  	ret = -EINVAL;
>  	if (!irq) {
> -		pr_err("arch_timer: Frame missing %s irq",
> +		pr_err("Frame missing %s irq",
>  		       arch_timer_mem_use_virtual ? "virt" : "phys");
>  		goto out;
>  	}

Missing terminating newline

		pr_err("Frame missing %s irq\n",
