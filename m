Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:50075 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbbBWVfT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Feb 2015 16:35:19 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Mathieu Olivari <mathieu@codeaurora.org>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, wim@iguana.be, corbet@lwn.net,
	standby24x7@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/3] arm: msm: Use timer DT node for qcom watchdog config
Date: Mon, 23 Feb 2015 22:35:04 +0100
Message-ID: <5879121.Ud0l5ICsCF@wuerfel>
In-Reply-To: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Friday 20 February 2015 18:19:33 Mathieu Olivari wrote:
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
> 

What about the binding document in
Documentation/devicetree/bindings/watchdog/qcom-wdt.txt?

	Arnd
