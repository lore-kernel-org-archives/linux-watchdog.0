Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45910 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935335AbdCLUtf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 12 Mar 2017 16:49:35 -0400
Subject: Re: [PATCH v2 4/8] ARM: dts: s3c64xx: Enable watchdog on all S3C64xx
 boards
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-5-krzk@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0d8ee3a3-b8df-854a-4443-5b87babc00e9@roeck-us.net>
Date: Sun, 12 Mar 2017 13:49:32 -0700
MIME-Version: 1.0
In-Reply-To: <20170311172527.16368-5-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/11/2017 09:25 AM, Krzysztof Kozlowski wrote:
> Watchdog module does not have external dependencies so it can be safely
> enabled in s3c64xx.dtsi thus making it available for all S3C64xx-based
> boards.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/boot/dts/s3c64xx.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
> index 0ccb414cd268..6caec5f27d38 100644
> --- a/arch/arm/boot/dts/s3c64xx.dtsi
> +++ b/arch/arm/boot/dts/s3c64xx.dtsi
> @@ -100,7 +100,6 @@
>  			interrupts = <26>;
>  			clock-names = "watchdog";
>  			clocks = <&clocks PCLK_WDT>;
> -			status = "disabled";
>  		};
>
>  		i2c0: i2c@7f004000 {
>

