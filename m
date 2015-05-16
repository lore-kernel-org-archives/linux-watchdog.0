Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33719 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbbEPMCD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 16 May 2015 08:02:03 -0400
Received: by padbw4 with SMTP id bw4so63737669pad.0
        for <linux-watchdog@vger.kernel.org>; Sat, 16 May 2015 05:02:03 -0700 (PDT)
Message-ID: <555731B1.3070805@linaro.org>
Date: Sat, 16 May 2015 20:01:53 +0800
From: Fu Wei <fu.wei@linaro.org>
Reply-To: Fu Wei <fu.wei@linaro.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net
Subject: Re: [PATCH 5/6] Watchdog: introdouce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1431689090-3125-1-git-send-email-fu.wei@linaro.org> <1431689090-3125-2-git-send-email-fu.wei@linaro.org> <2621121.Z4lZCvqDlK@wuerfel>
In-Reply-To: <2621121.Z4lZCvqDlK@wuerfel>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Arnd,
Great thanks for your review,
The feedback is inline below:

On 05/15/2015 09:57 PM, Arnd Bergmann wrote:
> On Friday 15 May 2015 19:24:49 fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>>     (1)Use linux kernel watchdog framework
>>     (2)Work with FDT on ARM64
>>     (3)Use "pretimeout" in watchdog framework
>>     (4)In first timeout(WS0), do panic to save system context
>>     (5)support geting timeout and pretimeout from
>>        parameter and FDT at the driver init stage.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> 
> The patch looks good overall. Please try to describe in the patch in 
> full sentences in the changelog, as we normally do.

Sure, you will see changelog in the next version.
 
> 
> A few tiny details that I'd do differently, but don't have to change
> if the watchdog maintainer is fine with your version:
> 
>> +struct sbsa_gwdt {
>> +	struct watchdog_device	wdd;
>> +	u32			clk;
>> +	void __iomem		*refresh_base;
>> +	void __iomem		*control_base;
>> +#ifdef CONFIG_PM_SLEEP
>> +	spinlock_t		lock;
>> +	u8			pm_status_store;
>> +#endif
>> +};
> 
> I would drop the #ifdef here, and favor readability over saving
> a few bytes.
yes, that make sense :-)

> 
>> +	/*
>> +	 * Try to determine the frequency from the cp15 interface
>> +	 */
>> +	clk = arch_timer_get_cntfrq();
>> +	if (!clk) {
>> +		dev_err(dev, "System Counter frequency not available\n");
>> +		return -EINVAL;
>> +	}
> 
> Is it guaranteed that the same clock feeds the arch timer and the
> watchdog? Maybe it would be better to use the clk API to read
> the frequency, so we can avoid this dependency.

yes. you are right. According to SBSA doc, the clocksource of SBSA watchdog is System Counter.
And System Counter is in (arm_)arch_timer. So I think we should do 

	depends on ARM_ARCH_TIMER

and use the relevant interface : 

	clk = arch_timer_get_rate();

will improve it, thanks for your suggestion!

> 
>> +
>> +	pr_debug("sbsa_gwdt: ioremap %s frame 0x%llx(size: %llu)-->%p.\n",
>> +		 res->name, (unsigned long long)res->start,
>> +		(unsigned long long)(res->end - res->start + 1), rf_base);
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
>> +	cf_base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(rf_base))
>> +		return PTR_ERR(rf_base);
>> +
>> +	pr_debug("sbsa_gwdt: ioremap %s frame 0x%llx(size: %llu)-->%p.\n",
>> +		 res->name, (unsigned long long)res->start,
>> +		(unsigned long long)(res->end - res->start + 1), cf_base);
> 
> I would probably drop the various pr_debug() calls here. Once the driver
> works fine, they are normally not that useful any more.

yes, for this drive, if it works fine, we can drop it, but I keep these info for some reason:
(1)they can help engineer debug GTDT table or DTS, if the info of watchdog goes wrong.
(2)check the memory map
(3)if DEBUG is disable, all pr_debug are no_printk, it won't increase Image size or output any through console.
 
> 
> 	Arnd
> 


-- 
Best regards,

Fu Wei
Software Engineer From Red Hat
LEG Team
Linaro.org | Open source software for ARM SoCs
Ph: +86 186 2020 4684 (mobile)
IRC: fuwei
Skype: tekkamanninja
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021 
