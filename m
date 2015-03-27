Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:56618 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751638AbbC0H7l (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Mar 2015 03:59:41 -0400
Date: Fri, 27 Mar 2015 08:59:31 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Mathieu Olivari <mathieu@codeaurora.org>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, corbet@lwn.net, standby24x7@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/3] arm: msm: Use timer DT node for qcom watchdog config
Message-ID: <20150327075931.GC24918@spo001.leaseweb.nl>
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mathieu,

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

This patchset has been added to linux-watchdog-next.

Kind regards,
Wim.

