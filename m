Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50708 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbcGSObb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jul 2016 10:31:31 -0400
Subject: Re: [PATCH v2] watchdog: renesas-wdt: Add support for the r8a7796 wdt
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1468928814-18817-1-git-send-email-geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <578E39BA.9050701@roeck-us.net>
Date: Tue, 19 Jul 2016 07:31:22 -0700
MIME-Version: 1.0
In-Reply-To: <1468928814-18817-1-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/19/2016 04:46 AM, Geert Uytterhoeven wrote:
> Document support for the Watchdog Timer (WDT) Controller in the Renesas
> R-Car M3-W (r8a7796) SoC.
>
> No driver update is needed.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
>    - Add Acked-by.
>
>   Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index b9512f1eb80a0205..da24e31334177768 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -1,7 +1,11 @@
>   Renesas Watchdog Timer (WDT) Controller
>
>   Required properties:
> -- compatible : Should be "renesas,r8a7795-wdt", or "renesas,rcar-gen3-wdt"
> +- compatible : Should be "renesas,<soctype>-wdt", and
> +	       "renesas,rcar-gen3-wdt" as fallback.
> +	       Examples with soctypes are:
> +	         - "renesas,r8a7795-wdt" (R-Car H3)
> +	         - "renesas,r8a7796-wdt" (R-Car M3-W)
>
>     When compatible with the generic version, nodes must list the SoC-specific
>     version corresponding to the platform first, followed by the generic
>

