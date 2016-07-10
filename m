Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45284 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbcGJQDp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 10 Jul 2016 12:03:45 -0400
Subject: Re: [PATCH v3 3/3] ARM64: dts: amlogic: meson-gxbb: Add watchdog node
To: Neil Armstrong <narmstrong@baylibre.com>,
	Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
 <1468141867-4172-4-git-send-email-narmstrong@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <578271D3.4080704@roeck-us.net>
Date: Sun, 10 Jul 2016 09:03:31 -0700
MIME-Version: 1.0
In-Reply-To: <1468141867-4172-4-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/10/2016 02:11 AM, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Would this go in through one of the arm trees ?

Guenter

> ---
>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 832815d..bcca82f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -136,6 +136,12 @@
>   				clocks = <&xtal>;
>   				status = "disabled";
>   			};
> +
> +			watchdog@98d0 {
> +				compatible = "amlogic,meson-gxbb-wdt";
> +				reg = <0x0 0x098d0 0x0 0x10>;
> +				clocks = <&xtal>;
> +			};
>   		};
>
>   		gic: interrupt-controller@c4301000 {
>

