Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Thu, 17 Aug 2017 15:34:09 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 06/11] watchdog: ftwdt010: Extend DT bindings to
 derivatives
Message-ID: <20170817203409.an37wtlbyudmk5io@rob-hp-laptop>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-7-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170812184318.10144-7-linus.walleij@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, Aug 12, 2017 at 08:43:13PM +0200, Linus Walleij wrote:
> This extends the device tree bindings for the Faraday FTWDT010
> block to cover:
> - The "moxa,moxart-watchdog" compatible version
> - The "aspeed,ast2400-wdt" and "aspeed,ast2500-wdt" versions
> - clocks (PCLK non-optional, the Gemini also have this now)
> - reset line (optional, exist on the Gemini)
> - configuration to use the external clock (faraday,use-extclk)
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/watchdog/faraday,ftwdt010.txt    | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
