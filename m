Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:51542 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750793AbaAJHlQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Jan 2014 02:41:16 -0500
Date: Fri, 10 Jan 2014 08:41:13 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, dianders@chromium.org,
	kgene.kim@samsung.com, t.figa@samsung.com,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, linux@roeck-us.net
Subject: Re: [PATCH V12 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and exynos5420 dtsi files
Message-ID: <20140110074113.GB12119@spo001.leaseweb.com>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com> <1386308868-30264-2-git-send-email-l.krishna@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1386308868-30264-2-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela,

> This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
> handle PMU register accesses in a centralized way using syscon driver
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>
> ---
...
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index b1fa334..cd47db0 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -402,4 +402,9 @@
>  		clock-names = "gscl";
>  		samsung,power-domain = <&gsc_pd>;
>  	};

I can't add this patch since there is no "gscl" in the current linux-tree.
Is this depending on another patch or are we going to fix this in another way?

Kind regards,
Wim.

