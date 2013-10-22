Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37071 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753904Ab3JVPCY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Oct 2013 11:02:24 -0400
Date: Tue, 22 Oct 2013 16:02:02 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "dinguyen@altera.com" <dinguyen@altera.com>
Cc: "dinh.linux@gmail.com" <dinh.linux@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jamie Iles <jamie@jamieiles.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Pavel Machek <pavel@denx.de>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCHv5] watchdog: dw: Enable OF support for DW watchdog timer
Message-ID: <20131022150201.GB4691@kartoffel>
References: <1382452727-20685-1-git-send-email-dinguyen@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1382452727-20685-1-git-send-email-dinguyen@altera.com>
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 22, 2013 at 03:38:47PM +0100, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add device tree support to the DW watchdog timer.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Jamie Iles <jamie@jamieiles.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> ---
> v5:
> - Add documentation for clocks property
> v4:
> - Add interrupts as an optional property, use "should contain".
> v3:
> - Clean up documentation
> v2:
> - Use of_match_ptr() for of_match_table
> ---
>  .../devicetree/bindings/watchdog/dw_wdt.txt        |   20 ++++++++++++++++++++
>  drivers/watchdog/dw_wdt.c                          |    8 ++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> new file mode 100644
> index 0000000..3af5c13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> @@ -0,0 +1,20 @@
> +Synopsys Designware Watchdog Timer
> +
> +Required Properties:
> +
> +- compatible	: Should contain "snps,dw-wdt"
> +- reg		: Base address and size of the watchdog timer register.

s/register/registers/ ?

> +- clocks	: phandle to the clock that drives the watchdog timer.

Nit: clocks aren't necessarily described by just a phandle.

How about:

- clocks: phandle + clock-specifier for the clock that drives the watchdog
          timer.

Otherwise, given previous comments this looks fine to me.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
