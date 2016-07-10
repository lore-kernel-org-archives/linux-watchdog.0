Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44623 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757275AbcGJQC4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 10 Jul 2016 12:02:56 -0400
Subject: Re: [PATCH v3 2/3] dt-bindings: watchdog: Add Meson GXBB Watchdog
 bindings
To: Neil Armstrong <narmstrong@baylibre.com>,
	Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
 <1468141867-4172-3-git-send-email-narmstrong@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5782719E.7020002@roeck-us.net>
Date: Sun, 10 Jul 2016 09:02:38 -0700
MIME-Version: 1.0
In-Reply-To: <1468141867-4172-3-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/10/2016 02:11 AM, Neil Armstrong wrote:
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/meson-gxbb-wdt.txt      | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
> new file mode 100644
> index 0000000..c7fe36f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
> @@ -0,0 +1,16 @@
> +Meson GXBB SoCs Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be "amlogic,meson-gxbb-wdt"
> +- reg : Specifies base physical address and size of the registers.
> +- clocks : Should be a phandle to the Watchdog clock source, for GXBB the xtal
> +	   is the default clock source.
> +
> +Example:
> +
> +wdt: watchdog@98d0 {
> +	compatible = "amlogic,meson-gxbb-wdt";
> +	reg = <0 0x98d0 0x0 0x10>;
> +	clocks = <&xtal>;
> +};
>

