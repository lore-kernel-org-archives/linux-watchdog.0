Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Tue, 24 Oct 2017 14:07:19 -0500
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, cphealy@gmail.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Lee Jones <lee.jones@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavel Machek <pavel@ucw.cz>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>, Johan Hovold <johan@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v8 5/5] dt-bindings: watchdog: Add bindings for RAVE SP
 watchdog driver
Message-ID: <20171024190719.w4wy3omflkugkocg@rob-hp-laptop>
References: <20171018170136.12347-1-andrew.smirnov@gmail.com>
 <20171018170136.12347-6-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171018170136.12347-6-andrew.smirnov@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Oct 18, 2017 at 10:01:36AM -0700, Andrey Smirnov wrote:

Commit msg?

> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt b/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
> new file mode 100644
> index 000000000000..f242c3eed0dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
> @@ -0,0 +1,10 @@
> +Zodiac Inflight Innovations RAVE Supervisory Processor Watchdog
> +
> +Required properties:
> +
> + - compatible: Should be "zii,rave-sp-watchdog"
> +

Must be a child of ? defined in ?

> +Optional properties:
> +
> + - Two byte nvmem cell "wdt_timeout", specified as per
> +   Documentation/devicetree/bindings/nvmem/nvmem.txt

prop name: definition... is the normal format.

Also, don't use '_' in property names.

Rob
