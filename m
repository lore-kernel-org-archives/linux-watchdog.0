Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Sun, 18 Feb 2018 18:06:19 -0600
From: Rob Herring <robh@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Carlo Caione <carlo@caione.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Barry Song <baohua@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 2/7] watchdog: sunxi: allow setting timeout in
 devicetree
Message-ID: <20180219000619.4pjftflhcew5zav6@rob-hp-laptop>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
 <20180211200847.25000-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211200847.25000-2-marcus.folkesson@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Feb 11, 2018 at 09:08:42PM +0100, Marcus Folkesson wrote:
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
>  Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 4 ++++
>  drivers/watchdog/sunxi_wdt.c                             | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
