Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:59049 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598Ab3J3OPi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 10:15:38 -0400
Subject: Re: [RESEND] [PATCH V3 2/2] watchdog: s3c2410_wdt: use syscon regmap interface to configure pmu register
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@codeaurora.org>
In-Reply-To: <1383116464-5951-3-git-send-email-l.krishna@samsung.com>
Date: Wed, 30 Oct 2013 09:15:35 -0500
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be, t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B9207640-E74A-441D-B79F-5E5B60A8A5B1@codeaurora.org>
References: <1383116464-5951-1-git-send-email-l.krishna@samsung.com> <1383116464-5951-3-git-send-email-l.krishna@samsung.com>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On Oct 30, 2013, at 2:01 AM, Leela Krishna Amudala wrote:

> The syscon regmap interface is used to configure AUTOMATIC_WDT_RESET_DISABLE
> and MASK_WDT_RESET_REQUEST registers of PMU to mask/unmask enable/disable of
> watchdog in probe and s2r scenarios.
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
> .../devicetree/bindings/watchdog/samsung-wdt.txt   |   13 ++-
> drivers/watchdog/s3c2410_wdt.c                     |  114 ++++++++++++++++++--
> 2 files changed, 118 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> index 2aa486c..c46c7ce 100644
> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> @@ -5,10 +5,21 @@ after a preset amount of time during which the WDT reset event has not
> occurred.
> 
> Required properties:
> -- compatible : should be "samsung,s3c2410-wdt"
> +- compatible : should be "samsung,s3c2410-wdt" or "samsung,s3c5250-wdt" or "samsung,s3c5420-wdt"
> - reg : base physical address of the controller and length of memory mapped
> 	region.
> - interrupts : interrupt number to the cpu.
> +- samsung,pmusysreg : reference node to pmu sysreg (required only in case of Exynos5250 and 5420)

Rather than saying required only on Exynos5250 and 5420, how about saying required only in case of compatible being "samsung,s3c5250-wdt" or "samsung,s3c5420-wdt"

> 
> Optional properties:
> - timeout-sec : contains the watchdog timeout in seconds.
> +
> +watchdog@101D0000 {
> +	compatible = "samsung,s3c5250-wdt";
> +	reg = <0x101D0000 0x100>;
> +	interrupts = <0 42 0>;
> +	clocks = <&clock 336>;
> +	clock-names = "watchdog";
> +	samsung,sysreg = <&pmu_sys_reg>;
> +	status = "okay";
> +};

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

