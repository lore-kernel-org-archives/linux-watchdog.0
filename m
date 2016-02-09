Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46044 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787AbcBIRjb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Feb 2016 12:39:31 -0500
Subject: Re: [PATCH v11 4/4] Watchdog: introduce ARM SBSA watchdog driver
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
References: <1455037240-16192-1-git-send-email-fu.wei@linaro.org>
 <1455037240-16192-5-git-send-email-fu.wei@linaro.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <56BA244E.1020402@codeaurora.org>
Date: Tue, 9 Feb 2016 11:39:26 -0600
MIME-Version: 1.0
In-Reply-To: <1455037240-16192-5-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

fu.wei@linaro.org wrote:

> +		if (!action)
> +			dev_warn(dev, "fall back to signle stage mode.\n");

"falling back to single stage mode"

Acked-by: Timur Tabi <timur@codeaurora.org>

The whole "calculate the timeouts different if 'action' is enabled" 
seems clunky to me, but I can't think of a better way to handle it.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
