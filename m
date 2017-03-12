Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48163 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935168AbdCLUvL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 12 Mar 2017 16:51:11 -0400
Subject: Re: [PATCH v2 7/8] ARM: dts: s3c64xx: Fix infinite interrupt in soft
 mode
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-8-krzk@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ba33cc5b-bc2c-ec84-d697-45022e6879fe@roeck-us.net>
Date: Sun, 12 Mar 2017 13:51:07 -0700
MIME-Version: 1.0
In-Reply-To: <20170311172527.16368-8-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/11/2017 09:25 AM, Krzysztof Kozlowski wrote:
> In soft (no-reboot) mode, the driver self-pings watchdog upon expiration
> of an interrupt.  The interrupt has to be cleared, because otherwise
> system enters infinite interrupt handling loop.
>
> Use a samsung,s3c6410-wdt compatible to select appropriate quirk for
> clearing the watchdog interrupt.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/boot/dts/s3c64xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
> index 6caec5f27d38..c55cbb3af2c0 100644
> --- a/arch/arm/boot/dts/s3c64xx.dtsi
> +++ b/arch/arm/boot/dts/s3c64xx.dtsi
> @@ -94,7 +94,7 @@
>  		};
>
>  		watchdog: watchdog@7e004000 {
> -			compatible = "samsung,s3c2410-wdt";
> +			compatible = "samsung,s3c6410-wdt";
>  			reg = <0x7e004000 0x1000>;
>  			interrupt-parent = <&vic0>;
>  			interrupts = <26>;
>

