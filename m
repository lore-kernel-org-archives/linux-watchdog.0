Return-path: <timur@codeaurora.org>
Subject: Re: [PATCH v12 4/4] Watchdog: introduce ARM SBSA watchdog driver
To: fu.wei@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com,
 mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
 wim@iguana.be, linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com,
 will.deacon@arm.com, Suravee.Suthikulpanit@amd.com
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
 rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
 dyoung@redhat.com, panand@redhat.com, graeme.gregory@linaro.org,
 al.stone@linaro.org, hanjun.guo@linaro.org, jcm@redhat.com, arnd@arndb.de,
 leo.duran@amd.com, sudeep.holla@arm.com
References: <1455611785-2407-1-git-send-email-fu.wei@linaro.org>
 <1455611785-2407-5-git-send-email-fu.wei@linaro.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <56D0A72B.8020100@codeaurora.org>
Date: Fri, 26 Feb 2016 13:27:39 -0600
MIME-Version: 1.0
In-Reply-To: <1455611785-2407-5-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

fu.wei@linaro.org wrote:
> +	if (action) {
> +		irq = platform_get_irq(pdev, 0);
> +		if (irq < 0) {
> +			action = 0;
> +			dev_warn(dev, "unable to get ws0 interrupt.\n");
> +		} else {
> +			if (devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
> +					     pdev->name, gwdt)) {
> +				action = 0;
> +				dev_warn(dev, "unable to request IRQ %d.\n",
> +					 irq);
> +			}
> +		}
> +		if (!action)
> +			dev_warn(dev, "falling back to signle stage mode.\n");
> +	}
> +
> +	/*
> +	 * Get the frequency of system counter from the cp15 interface of ARM
> +	 * Generic timer. We don't need to check it, because if it returns "0",
> +	 * system would panic in very early stage.
> +	 */
> +	gwdt->clk = arch_timer_get_cntfrq();
> +	gwdt->refresh_base = rf_base;
> +	gwdt->control_base = cf_base;

I think you need to ping the watchdog before enabling the interrupt, in 
case there is a pending interrupt.  This just happened to me in testing, 
so I recommend this:

> 	/*
> 	 * Get the frequency of system counter from the cp15 interface of ARM
> 	 * Generic timer. We don't need to check it, because if it returns "0",
> 	 * system would panic in very early stage.
> 	 */
> 	gwdt->clk = arch_timer_get_cntfrq();
> 	gwdt->refresh_base = rf_base;
> 	gwdt->control_base = cf_base;
>
> 	if (action) {
> 		irq = platform_get_irq(pdev, 0);
> 		if (irq < 0) {
> 			action = 0;
> 			dev_warn(dev, "unable to get ws0 interrupt.\n");
> 		} else {
> 			sbsa_gwdt_keepalive(&gwdt->wdd);
> 			if (devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
> 					     pdev->name, gwdt)) {
> 				action = 0;
> 				dev_warn(dev, "unable to request IRQ %d.\n",
> 					 irq);
> 			}
> 		}
> 		if (!action)
> 			dev_warn(dev, "falling back to single stage mode.\n");
> 	}

In fact, I think you need to move the "if (action) {" block near the end 
of sbsa_gwdt_probe().  We don't want to enable the interrupt until the 
watchdog is fully initialized.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
