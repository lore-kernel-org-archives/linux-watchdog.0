Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Fri, 27 Oct 2017 09:37:58 -0500
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
Subject: Re: [PATCH v9 5/5] dt-bindings: watchdog: Add bindings for RAVE SP
 watchdog driver
Message-ID: <20171027143758.zmdafu65ykhwlmhg@rob-hp-laptop>
References: <20171025190421.18415-1-andrew.smirnov@gmail.com>
 <20171025190421.18415-6-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171025190421.18415-6-andrew.smirnov@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Oct 25, 2017 at 12:04:21PM -0700, Andrey Smirnov wrote:
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
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../bindings/watchdog/zii,rave-sp-wdt.txt          | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt

Acked-by: Rob Herring <robh@kernel.org>
