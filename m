Return-path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 5/8] ARM: dts: exynos: Enable watchdog on all Exynos4
 boards
Date: Tue, 14 Mar 2017 14:00:20 +0100
Message-id: <4885890.jl6tPtmvlV@amdc3058>
In-reply-to: <20170311172527.16368-6-krzk@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-6-krzk@kernel.org>
 <CGME20170314130022epcas5p4e771120ec9ea3f488e1dee644c0b1d07@epcas5p4.samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>


Hi,

On Saturday, March 11, 2017 07:25:24 PM Krzysztof Kozlowski wrote:
> Watchdog module does not have external dependencies so it can be safely
> enabled in exynos4.dtsi thus making it available for all Exynos4-based
> boards.

Please fix the patch description (patch #3 moved watchdog node out from
exynos4.dtsi).

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts         | 4 ----
>  arch/arm/boot/dts/exynos4210.dtsi               | 1 -
>  arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 4 ----
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 4 ----
>  arch/arm/boot/dts/exynos4412-origen.dts         | 4 ----
>  arch/arm/boot/dts/exynos4412.dtsi               | 1 -
>  6 files changed, 18 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
