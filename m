Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: fu.wei@linaro.org
Cc: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, tekkamanninja@gmail.com, graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org, ashwin.chaugule@linaro.org, linux@roeck-us.net, vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net
Subject: Re: [PATCH 5/6] Watchdog: introdouce ARM SBSA watchdog driver
Date: Fri, 15 May 2015 15:57:13 +0200
Message-ID: <2621121.Z4lZCvqDlK@wuerfel>
In-Reply-To: <1431689090-3125-2-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org> <1431689090-3125-1-git-send-email-fu.wei@linaro.org> <1431689090-3125-2-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Friday 15 May 2015 19:24:49 fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
>     (1)Use linux kernel watchdog framework
>     (2)Work with FDT on ARM64
>     (3)Use "pretimeout" in watchdog framework
>     (4)In first timeout(WS0), do panic to save system context
>     (5)support geting timeout and pretimeout from
>        parameter and FDT at the driver init stage.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

The patch looks good overall. Please try to describe in the patch in 
full sentences in the changelog, as we normally do. 

A few tiny details that I'd do differently, but don't have to change
if the watchdog maintainer is fine with your version:

> +struct sbsa_gwdt {
> +	struct watchdog_device	wdd;
> +	u32			clk;
> +	void __iomem		*refresh_base;
> +	void __iomem		*control_base;
> +#ifdef CONFIG_PM_SLEEP
> +	spinlock_t		lock;
> +	u8			pm_status_store;
> +#endif
> +};

I would drop the #ifdef here, and favor readability over saving
a few bytes.

> +	/*
> +	 * Try to determine the frequency from the cp15 interface
> +	 */
> +	clk = arch_timer_get_cntfrq();
> +	if (!clk) {
> +		dev_err(dev, "System Counter frequency not available\n");
> +		return -EINVAL;
> +	}

Is it guaranteed that the same clock feeds the arch timer and the
watchdog? Maybe it would be better to use the clk API to read
the frequency, so we can avoid this dependency.

> +
> +	pr_debug("sbsa_gwdt: ioremap %s frame 0x%llx(size: %llu)-->%p.\n",
> +		 res->name, (unsigned long long)res->start,
> +		(unsigned long long)(res->end - res->start + 1), rf_base);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
> +	cf_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(rf_base))
> +		return PTR_ERR(rf_base);
> +
> +	pr_debug("sbsa_gwdt: ioremap %s frame 0x%llx(size: %llu)-->%p.\n",
> +		 res->name, (unsigned long long)res->start,
> +		(unsigned long long)(res->end - res->start + 1), cf_base);

I would probably drop the various pr_debug() calls here. Once the driver
works fine, they are normally not that useful any more.

	Arnd
