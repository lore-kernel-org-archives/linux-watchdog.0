Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40423 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbbEUPc3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 11:32:29 -0400
Date: Thu, 21 May 2015 08:32:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: fu.wei@linaro.org
Cc: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, vgandhi@codeaurora.org,
	wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
	mark.rutland@arm.com
Subject: Re: [PATCH v2 5/7] Watchdog: introduce "pretimeout" into framework
Message-ID: <20150521153225.GA17441@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
 <1432197156-16947-6-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432197156-16947-6-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 21, 2015 at 04:32:34PM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> Also update Documentation/watchdog/watchdog-kernel-api.txt to
> introduce:
> (1)the new elements in the watchdog_device and watchdog_ops struct;
> (2)the new API "watchdog_init_timeouts".
> 
> Reasons:
> (1)kernel already has two watchdog drivers are using "pretimeout":
> 	drivers/char/ipmi/ipmi_watchdog.c
> 	drivers/watchdog/kempld_wdt.c(but the definition is different)
> (2)some other dirvers are going to use this: ARM SBSA Generic Watchdog
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---

[ ... ]

>  
> +/* Use the following function to check if a pretimeout value is invalid */
> +static inline bool watchdog_pretimeout_invalid(struct watchdog_device *wdd,
> +					       unsigned int t)
> +{
> +	return ((wdd->max_pretimeout != 0) &&
> +		(t < wdd->min_pretimeout || t > wdd->max_pretimeout));
> +}

Should this function also enforce "t < wdd->timeout", and
should watchdog_timeout_invalid() enforce "t > wdd->pretimeout" ?

Thanks,
Guenter
