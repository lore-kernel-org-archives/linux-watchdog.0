Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:49919 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab3KJTX5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 10 Nov 2013 14:23:57 -0500
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be, t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Subject: Re: [PATCH V6 1/3] ARM: dts: Add pmu sysreg node to Exynos5 dtsi file
Date: Sun, 10 Nov 2013 20:23:55 +0100
Message-ID: <7285526.XmfYtBHBpD@flatron>
In-Reply-To: <1383825078-24515-2-git-send-email-l.krishna@samsung.com>
References: <1383825078-24515-1-git-send-email-l.krishna@samsung.com> <1383825078-24515-2-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela,

On Thursday 07 of November 2013 17:21:16 Leela Krishna Amudala wrote:
> This patch adds pmusysreg node to Exynos5 dtsi file to handle PMU
> register accesses in a centralized way using syscon driver
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5.dtsi |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> index e52b038..ad6e47c9 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -106,4 +106,9 @@
>  		#size-cells = <0>;
>  		status = "disabled";
>  	};
> +
> +	pmu_syscon: syscon@10040000 {
> +		compatible = "syscon";
> +		reg = <0x10040000 0x5000>;
> +	};
>  };
> 

Just to be safe, I would also add some SoC-specific compatible value to
this node. My proposal is "samsung,exynos5250-pmu" for the PMU of
Exynos5250 (unless all Exynos 5 SoCs really have identical set of PMU
registers, but based on your patch to WDT driver, I don't think so) and
put the node in dtsi of particular SoC.

We already have a PMU driver in arch/arm/mach-exynos and we should rather
allow it to bind to some device tree node and access the registers it
needs when we finally stop mapping PMU registers statically.

You should also document such binding somewhere. IMHO [1] would be a good
place for it.

[1] - Documentation/devicetree/bindings/arm/samsung/pmu.txt

Best regards,
Tomasz

