Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:52636 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486Ab3KOXnU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Nov 2013 18:43:20 -0500
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be, t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Subject: Re: [PATCH V8 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and exynos5420 dtsi files
Date: Sat, 16 Nov 2013 00:43:19 +0100
Message-ID: <1736135.JdedDOBENL@flatron>
In-Reply-To: <1384238088-9862-2-git-send-email-l.krishna@samsung.com>
References: <1384238088-9862-1-git-send-email-l.krishna@samsung.com> <1384238088-9862-2-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 12 of November 2013 12:04:46 Leela Krishna Amudala wrote:
> This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
> handle PMU register accesses in a centralized way using syscon driver
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.txt |   13 +++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi                     |    5 +++++
>  arch/arm/boot/dts/exynos5420.dtsi                     |    5 +++++
>  3 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> new file mode 100644
> index 0000000..90f975d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> @@ -0,0 +1,13 @@
> +SAMSUNG Exynos SoC series PMU Registers
> +
> +Properties:
> + - name : should be 'syscon';
> + - compatible : should contain "samsung,<chip name>-pmu", "syscon";

AFAIR there was a discussion about using <chip name> wildcards some
time ago and if I remember correctly, the conclusion was that the list
of all supported compatible values should be provided anyway, so there
is no point in using such wildcards.

This is how I would write this:

 - compatible : should contain two values. First value must be one from
   following list:
     - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
     - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
   Second value must be always "syscon".

Best regards,
Tomasz

