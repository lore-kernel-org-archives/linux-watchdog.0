Return-path: <b.galvani@gmail.com>
Date: Wed, 17 Sep 2014 22:58:27 +0200
From: Beniamino Galvani <b.galvani@gmail.com>
To: Carlo Caione <carlo@caione.org>
Cc: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, linux@arm.linux.org.uk
Subject: Re: [PATCH v2 1/4] ARM: docs: add documentation binding for meson
 watchdog
Message-ID: <20140917205827.GA5269@gmail.com>
References: <1410984726-18944-1-git-send-email-carlo@caione.org>
 <1410984726-18944-2-git-send-email-carlo@caione.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1410984726-18944-2-git-send-email-carlo@caione.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Sep 17, 2014 at 10:12:03PM +0200, Carlo Caione wrote:
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  Documentation/devicetree/bindings/watchdog/meson-wdt.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> new file mode 100644
> index 0000000..e66c0c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> @@ -0,0 +1,13 @@
> +Meson SoCs Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be "amlogic,meson-wdt"

Hi Carlo,

the compatible property should describe a specific version of the
device, so maybe "amlogic,meson6-wdt" would be more appropriate.

Beniamino

> +- reg : Specifies base physical address and size of the registers.
> +
> +Example:
> +
> +wdt: watchdog@c1109900 {
> +	compatible = "amlogic,meson-wdt";
> +	reg = <0xc1109900 0x8>;
> +};
> -- 
> 1.9.1
> 
