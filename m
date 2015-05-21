Return-path: <timur@codeaurora.org>
Message-ID: <555DFCD4.3040701@codeaurora.org>
Date: Thu, 21 May 2015 10:42:12 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
 linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
 al.stone@linaro.org, hanjun.guo@linaro.org, ashwin.chaugule@linaro.org,
 arnd@arndb.de, linux@roeck-us.net, vgandhi@codeaurora.org,
 wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
 mark.rutland@arm.com
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1432197156-16947-1-git-send-email-fu.wei@linaro.org> <1432197156-16947-7-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1432197156-16947-7-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/21/2015 03:32 AM, fu.wei@linaro.org wrote:

> +static void reload_timeout_to_wcv(struct watchdog_device *wdd)
> +{
> +	struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
> +	u64 wcv;
> +
> +	wcv = arch_counter_get_cntvct() +
> +		(u64)(wdd->timeout - wdd->pretimeout) * gwdt->clk;
> +
> +	sbsa_gwdt_set_wcv(wdd, wcv);
> +}

...

> +static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
> +				 unsigned int timeout)
> +{
> +	wdd->timeout = timeout;
> +
> +	return 0;
> +}

...

> +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
> +{
> +	struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
> +	struct watchdog_device *wdd = &gwdt->wdd;
> +	u32 status;
> +
> +	status = sbsa_gwdt_cf_read(SBSA_GWDT_WCS, wdd);
> +
> +	if (status & SBSA_GWDT_WCS_WS0)
> +		panic("SBSA Watchdog pre-timeout");
> +
> +	return IRQ_HANDLED;
> +}

There's one thing I don't understand about your driver.  The 'timeout' 
value from the kernel is supposed to to be the number of seconds until 
the system reboots.  You are programming the WCV with that value, which 
means that the WS0 interrupt will fire when the timeout expires the 
first time.  However, you don't reboot the system during this interrupt. 
  The "panic" will cause the system to halt, but not reboot.  Instead, 
it will just sit there.  You're waiting for the WS1 timeout for the 
system to reboot, but this is not a clean reboot, and it occurs at 
2*timeout seconds.

That's why I like my driver better.  It doesn't have any of this 
pretimeout stuff, and when the timeout expires during the WS0 interrupt, 
it calls emergency_restart() which reboots the system properly.  The WS1 
hard reset is used as a "backup" reset in case emergency_restart() fails.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
