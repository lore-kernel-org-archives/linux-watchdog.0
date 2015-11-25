Return-path: <robherring2@gmail.com>
Date: Wed, 25 Nov 2015 15:59:24 -0600
From: Rob Herring <robh@kernel.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <linux@arm.linux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, kernel@savoirfairelinux.com
Subject: Re: [PATCH v6 5/6] of: documentation: add bindings documentation for
 TS-4800
Message-ID: <20151125215924.GA14649@rob-hp-laptop>
References: <1448479507-1951-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448479507-1951-6-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448479507-1951-6-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Nov 25, 2015 at 02:25:06PM -0500, Damien Riegel wrote:
> This adds the documentation for the TS-4800 by Technologic Systems.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/arm/technologic.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/technologic.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/technologic.txt b/Documentation/devicetree/bindings/arm/technologic.txt
> new file mode 100644
> index 0000000..8422988
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/technologic.txt
> @@ -0,0 +1,6 @@
> +Technologic Systems Platforms Device Tree Bindings
> +--------------------------------------------------
> +
> +TS-4800 board
> +Required root node properties:
> +	- compatible = "technologic,imx51-ts4800", "fsl,imx51";
> -- 
> 2.5.0
> 
