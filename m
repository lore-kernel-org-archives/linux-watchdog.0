Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32911 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbcGYPue (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Jul 2016 11:50:34 -0400
Subject: Re: [PATCH v9 4/9] clocksource/drivers/arm_arch_timer: use readq to
 get 64-bit CNTVCT
To: Will Deacon <will.deacon@arm.com>, fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, marc.zyngier@arm.com,
	lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
	hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, rruigrok@codeaurora.org,
	harba@codeaurora.org, cov@codeaurora.org,
	graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com,
	wei@redhat.com, arnd@arndb.de, wim@iguana.be,
	catalin.marinas@arm.com, Suravee.Suthikulpanit@amd.com,
	leo.duran@amd.com, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org>
 <1469460427-8643-5-git-send-email-fu.wei@linaro.org>
 <20160725153118.GD19209@arm.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <57963545.6020400@codeaurora.org>
Date: Mon, 25 Jul 2016 10:50:29 -0500
MIME-Version: 1.0
In-Reply-To: <20160725153118.GD19209@arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Will Deacon wrote:
>> >  {
>> >-	u32 vct_lo, vct_hi, tmp_hi;
>> >-
>> >-	do {
>> >-		vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
>> >-		vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
>> >-		tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
>> >-	} while (vct_hi != tmp_hi);
>> >-
>> >-	return ((u64) vct_hi << 32) | vct_lo;
>> >+	return readq(arch_counter_base + CNTVCT_LO);
> Please drop this patch. It doesn't work.

On systems where readq() does work, wouldn't it be more optimal than the 
above while-loop?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
