Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44313 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbbC0FzZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Mar 2015 01:55:25 -0400
Date: Thu, 26 Mar 2015 22:55:23 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Mathieu Olivari <mathieu@codeaurora.org>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, corbet@lwn.net, standby24x7@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/3] arm: msm: Use timer DT node for qcom watchdog config
Message-ID: <20150327055523.GC5625@codeaurora.org>
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/20, Mathieu Olivari wrote:
> This change is done as a follow-up to the following thread:
> https://lkml.org/lkml/2014/10/1/436
> 
> qcom-wdt is currently assuming the presence of a dedicated node in DT
> to gets its configuration. However, on msm architecture, the watchdog is
> usually part of the timer block. So this patch-set is changing the driver
> and slightly enhancing the timer DT bindings to provide the relevant clocks
> and interrupts.
> 
> Mathieu Olivari (3):
>   watchdog: qcom: use timer devicetree binding
>   ARM: qcom: add description of KPSS WDT for IPQ8064
>   ARM: msm: add watchdog entries to DT timer binding doc
> 
>  Documentation/devicetree/bindings/arm/msm/timer.txt | 16 +++++++++++++---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi                 | 14 +++++++++++++-
>  drivers/watchdog/qcom-wdt.c                         | 21 +++++++++++++++------
>  3 files changed, 41 insertions(+), 10 deletions(-)
> 

Can this patchset be applied? Or should we resend with collected
acks?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
