Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60229 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755774AbbKRVTa (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Nov 2015 16:19:30 -0500
Date: Wed, 18 Nov 2015 15:19:25 -0600
From: Rob Herring <robh@kernel.org>
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] Add binding documentation for Zodiac Watchdog Timer
Message-ID: <20151118211925.GA30242@rob-hp-laptop>
References: <1447864731-24673-1-git-send-email-martyn.welch@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1447864731-24673-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 18, 2015 at 04:38:50PM +0000, Martyn Welch wrote:
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

You could document this under trivial-devices.txt, but this is fine too.

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt b/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt
> new file mode 100644
> index 0000000..2f34157
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt
> @@ -0,0 +1,12 @@
> +Zodiac RAVE Watchdog Timer
> +
> +Required properties:
> +- compatible: must be "zii,rave-wdt"
> +- reg: i2c slave address of device, usually 0x38
> +
> +Example:
> +
> +	watchdog@38 {
> +		compatible = "zii,rave-wdt";
> +		reg = <0x38>;
> +	};
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
