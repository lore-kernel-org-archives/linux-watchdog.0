Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Mon, 17 Jul 2017 11:51:52 -0500
From: Rob Herring <robh@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: wim@iguana.be, linux@roeck-us.net, carlo@caione.org,
	khilman@baylibre.com, linux-watchdog@vger.kernel.org,
	linux-amlogic@lists.infradead.org, mark.rutland@arm.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	narmstrong@baylibre.com
Subject: Re: [PATCH v2] watchdog: meson-wdt: add support for the watchdog on
 Meson8 and Meson8m2
Message-ID: <20170717165152.xv2kq2lqgi3jtobm@rob-hp-laptop>
References: <20170711221438.8958-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711221438.8958-1-martin.blumenstingl@googlemail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jul 12, 2017 at 12:14:38AM +0200, Martin Blumenstingl wrote:
> The watchdog IP block on Meson8 and Meson8m2 is already supported by the
> existing meson-wdt driver. Meson8 uses the same register bits as Meson6,
> while the newer Meson8m2 SoC uses the same register bits as Meson8b.
> 
> Currently watchdog support on Meson8 SoC already works because
> meson8.dtsi simply uses the "amlogic,meson6-wdt" compatible. Adding a
> separate compatible for Meson8 makes this more explicit though.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Changes since v1 at [0]:
> - updated the documentation to indicate that Meson8 should also specify
>   the Meson6 compatible and that Meson8m2 should also specify the
>   Meson8b compatible
> 
> [0] https://patchwork.kernel.org/patch/9780093/
> 
> 
>  Documentation/devicetree/bindings/watchdog/meson-wdt.txt | 6 +++++-
>  drivers/watchdog/meson_wdt.c                             | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
