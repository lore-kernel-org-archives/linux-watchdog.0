Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:48167 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753909AbdJaRWN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 31 Oct 2017 13:22:13 -0400
Date: Tue, 31 Oct 2017 10:22:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v10 5/5] dt-bindings: watchdog: Add bindings for RAVE SP
 watchdog driver
Message-ID: <20171031172211.GG28688@roeck-us.net>
References: <20171031163656.24552-1-andrew.smirnov@gmail.com>
 <20171031163656.24552-6-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171031163656.24552-6-andrew.smirnov@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 31, 2017 at 09:36:56AM -0700, Andrey Smirnov wrote:
> Add Device Tree bindings for RAVE SP watchdog drvier - an MFD cell of
> parent RAVE SP driver (documented in
> Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).
> 
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
> Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../bindings/watchdog/zii,rave-sp-wdt.txt          | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt b/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
> new file mode 100644
> index 000000000000..ab16659e781d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
> @@ -0,0 +1,39 @@
> +Zodiac Inflight Innovations RAVE Supervisory Processor Watchdog Bindings
> +
> +RAVE SP watchdog device is a "MFD cell" device corresponding to
> +watchdog functionality of RAVE Supervisory Processor. It is expected
> +that its Device Tree node is specified as a child of the node
> +corresponding to the parent RAVE SP device (as documented in
> +Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
> +
> +Required properties:
> +- compatible:	Should be "zii,rave-sp-watchdog"
> +
> +Optional properties:
> +
> +- wdt-timeout:	Two byte nvmem cell specified as per
> +		Documentation/devicetree/bindings/nvmem/nvmem.txt
> +
> +Example:
> +
> +	rave-sp {
> +		compatible = "zii,rave-sp-rdu1";
> +		current-speed = <38400>;
> +
> +		eeprom {
> +			compatible = "zii,pic-main-eeprom";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			wdt_timeout: wdt-timeout@8E {
> +				reg = <0x8E 2>;
> +			};
> +		};
> +
> +		watchdog {
> +			compatible = "zii,rave-sp-watchdog";
> +			nvmem-cells = <&wdt_timeout>;
> +			nvmem-cell-names = "wdt-timeout";
> +		};
> +	}
> +
> -- 
> 2.13.6
> 
