Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53053 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbKIPLN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Nov 2015 10:11:13 -0500
Subject: Re: [PATCH v3 4/4] ARM: dts: meson8b: Add watchdog node
To: Carlo Caione <carlo@caione.org>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	drake@endlessm.com, jerry.cao@amlogic.com, victor.wan@amlogic.com,
	romain.perier@gmail.com
References: <1446985137-25498-1-git-send-email-carlo@caione.org>
 <1446985137-25498-5-git-send-email-carlo@caione.org>
Cc: Carlo Caione <carlo@endlessm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5640B78E.8010200@roeck-us.net>
Date: Mon, 9 Nov 2015 07:11:10 -0800
MIME-Version: 1.0
In-Reply-To: <1446985137-25498-5-git-send-email-carlo@caione.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/08/2015 04:18 AM, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> With this patch we add the watchdog node in the meson8b DTS file.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/boot/dts/meson8b.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index ee352bf..8bad557 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -105,6 +105,12 @@
>   			#interrupt-cells = <3>;
>   		};
>
> +		wdt: watchdog@c1109900 {
> +			compatible = "amlogic,meson8b-wdt";
> +			reg = <0xc1109900 0x8>;
> +			interrupts = <0 0 1>;
> +		};
> +
>   		timer@c1109940 {
>   			compatible = "amlogic,meson6-timer";
>   			reg = <0xc1109940 0x18>;
>

