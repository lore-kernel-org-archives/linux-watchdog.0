Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52022 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbbKIPHF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Nov 2015 10:07:05 -0500
Subject: Re: [PATCH v3 3/4] Documentation: watchdog: Add new bindings for
 meson8b
To: Carlo Caione <carlo@caione.org>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	drake@endlessm.com, jerry.cao@amlogic.com, victor.wan@amlogic.com,
	romain.perier@gmail.com
References: <1446985137-25498-1-git-send-email-carlo@caione.org>
 <1446985137-25498-4-git-send-email-carlo@caione.org>
Cc: Carlo Caione <carlo@endlessm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5640B696.4080007@roeck-us.net>
Date: Mon, 9 Nov 2015 07:07:02 -0800
MIME-Version: 1.0
In-Reply-To: <1446985137-25498-4-git-send-email-carlo@caione.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/08/2015 04:18 AM, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> We make the documentation not meson6 specific anymore and add the new
> binding for meson8b SoC.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>   Documentation/devicetree/bindings/watchdog/meson-wdt.txt  | 13 +++++++++++++
>   Documentation/devicetree/bindings/watchdog/meson6-wdt.txt | 13 -------------
>   2 files changed, 13 insertions(+), 13 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
>   delete mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt

This will need an Ack from a DT maintainer for the rename.

Guenter

>
> diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> new file mode 100644
> index 0000000..ae70185
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> @@ -0,0 +1,13 @@
> +Meson SoCs Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be "amlogic,meson6-wdt" or "amlogic,meson8b-wdt"
> +- reg : Specifies base physical address and size of the registers.
> +
> +Example:
> +
> +wdt: watchdog@c1109900 {
> +	compatible = "amlogic,meson6-wdt";
> +	reg = <0xc1109900 0x8>;
> +};
> diff --git a/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
> deleted file mode 100644
> index 9200fc2..0000000
> --- a/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -Meson SoCs Watchdog timer
> -
> -Required properties:
> -
> -- compatible : should be "amlogic,meson6-wdt"
> -- reg : Specifies base physical address and size of the registers.
> -
> -Example:
> -
> -wdt: watchdog@c1109900 {
> -	compatible = "amlogic,meson6-wdt";
> -	reg = <0xc1109900 0x8>;
> -};
>

