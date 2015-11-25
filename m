Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34389 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbKYUGc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 15:06:32 -0500
Date: Wed, 25 Nov 2015 14:06:30 -0600
From: Rob Herring <robh@kernel.org>
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Add binding documentation for Zodiac Watchdog
 Timer
Message-ID: <20151125200630.GH30473@rob-hp-laptop>
References: <1448453015-16126-1-git-send-email-martyn.welch@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448453015-16126-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 25, 2015 at 12:03:34PM +0000, Martyn Welch wrote:
> This patchs adds documentation for the binding of the Zodiac RAVE
> Switch Watchdog Processor. This is an i2c based watchdog.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> ---
> 
> v2: Addition of optional properties.
> v3: Correct naming of reset-duration-msec -> reset-duration-ms

I acked v2, so please add it.

Acked-by: Rob Herring <robh@kernel.org>

> 
>  .../devicetree/bindings/watchdog/ziirave-wdt.txt      | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt b/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt
> new file mode 100644
> index 0000000..3d87818
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt
> @@ -0,0 +1,19 @@
> +Zodiac RAVE Watchdog Timer
> +
> +Required properties:
> +- compatible: must be "zii,rave-wdt"
> +- reg: i2c slave address of device, usually 0x38
> +
> +Optional Properties:
> +- timeout-sec: Watchdog timeout value in seconds.
> +- reset-duration-ms: Duration of the pulse generated when the watchdog times
> +  out. Value in milliseconds.
> +
> +Example:
> +
> +	watchdog@38 {
> +		compatible = "zii,rave-wdt";
> +		reg = <0x38>;
> +		timeout-sec = <30>;
> +		reset-duration-ms = <30>;
> +	};
> -- 
> 2.1.4
> 
