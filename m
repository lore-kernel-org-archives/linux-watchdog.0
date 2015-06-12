Return-path: <timur@codeaurora.org>
Message-ID: <557A58A5.4010208@codeaurora.org>
Date: Thu, 11 Jun 2015 22:57:25 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
 linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
 al.stone@linaro.org, hanjun.guo@linaro.org,
 ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
 vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
 leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH non-pretimeout 4/7] Watchdog: introduce ARM SBSA
 watchdog driver
References: <=fu.wei@linaro.org> <1433958452-23721-1-git-send-email-fu.wei@linaro.org> <1433958452-23721-5-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1433958452-23721-5-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

fu.wei@linaro.org wrote:
> +	if (timeout <= gwdt->max_wor_timeout)
> +		writel_relaxed(timeout * gwdt->clk,
> +			       gwdt->control_base + SBSA_GWDT_WOR);
> +	else
> +		writel_relaxed(gwdt->max_wor_timeout * gwdt->clk,
> +			       gwdt->control_base + SBSA_GWDT_WOR);

You pre-calculate the maximum timeout possible already, so why do you 
need the if-statement?

Frankly, your non-pretimeout driver is almost identical to mine, which 
was posted weeks ago.  At this point, you're really just copying my 
driver but putting your name on it.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
