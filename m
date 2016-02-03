Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33604 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933523AbcBCR1g (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Feb 2016 12:27:36 -0500
Subject: Re: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
To: fu.wei@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, wim@iguana.be, linux@roeck-us.net,
	corbet@lwn.net, catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	dyoung@redhat.com, panand@redhat.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, jcm@redhat.com,
	arnd@arndb.de, leo.duran@amd.com, sudeep.holla@arm.com
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <56B23883.7000501@codeaurora.org>
Date: Wed, 3 Feb 2016 11:27:31 -0600
MIME-Version: 1.0
In-Reply-To: <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

fu.wei@linaro.org wrote:
> +#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
> +static bool panic_enabled = true;

I think this should default to 'false', because IMHO, this seems like an 
odd feature.  I'm not crazy about the fact that there's a Kconfig option 
for it either, but I'm not going to NACK this patch.

I personally would prefer to drop this patch, and just wait for 
full-blown pre-timeout support.  It feels like a debugging feature that 
doesn't really belong upstream.  But like I said, it's just my opinion, 
and I won't complain if I'm outvoted.
