Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Thu, 17 Aug 2017 15:32:53 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/11] watchdog: gemini/ftwdt010: rename DT bindings
Message-ID: <20170817203253.y53qxyfiixas5a5q@rob-hp-laptop>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170812184318.10144-2-linus.walleij@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, Aug 12, 2017 at 08:43:08PM +0200, Linus Walleij wrote:
> The device tree bindings are in two copies and also should be
> consolidated into a single Faraday Technology FTWDT010
> binding since we uncovered that this IP part is a standard
> IP from Faraday.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/watchdog/cortina,gemini-watchdog.txt       | 17 -----------------
>  ...{cortina,gemin-watchdog.txt => faraday,ftwdt010.txt} | 11 ++++++++---
>  2 files changed, 8 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
>  rename Documentation/devicetree/bindings/watchdog/{cortina,gemin-watchdog.txt => faraday,ftwdt010.txt} (55%)

Acked-by: Rob Herring <robh@kernel.org>
