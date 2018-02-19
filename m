Return-Path: <matthias.bgg@gmail.com>
Return-path: <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 5/7] watchdog: mtk: allow setting timeout in devicetree
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
 Barry Song <baohua@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
 Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux
 <slemieux.tyco@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
 <20180211200847.25000-5-marcus.folkesson@gmail.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e179fed7-225f-2c07-2c00-41ccd28d4784@gmail.com>
Date: Mon, 19 Feb 2018 18:02:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180211200847.25000-5-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>



On 02/11/2018 09:08 PM, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> By following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt, it also
> let us to set timout-sec property in devicetree.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 4 ++++
>  drivers/watchdog/mtk_wdt.c                             | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index 5b38a30e608c..859dee167b91 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -11,9 +11,13 @@ Required properties:
>  
>  - reg : Specifies base physical address and size of the registers.
>  
> +Optional properties:
> +- timeout-sec: contains the watchdog timeout in seconds.
> +
>  Example:
>  
>  wdt: watchdog@10000000 {
>  	compatible = "mediatek,mt6589-wdt";
>  	reg = <0x10000000 0x18>;
> +	timeout-sec = <10>;
>  };
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 7ed417a765c7..fcdc10ec28a3 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -57,7 +57,7 @@
>  #define DRV_VERSION		"1.0"
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> -static unsigned int timeout = WDT_MAX_TIMEOUT;
> +static unsigned int timeout;
>  
>  struct mtk_wdt_dev {
>  	struct watchdog_device wdt_dev;
> 

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
