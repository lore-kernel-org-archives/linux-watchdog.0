Return-Path: <wens213@gmail.com>
Return-path: <wens213@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180219000619.4pjftflhcew5zav6@rob-hp-laptop>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
 <20180211200847.25000-2-marcus.folkesson@gmail.com> <20180219000619.4pjftflhcew5zav6@rob-hp-laptop>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 19 Feb 2018 11:01:19 +0800
Message-ID: <CAGb2v67ei8atFKyiFXA=EZ_wPbjBt+-2e-aSRqSzS9zaxHaTKg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] watchdog: sunxi: allow setting timeout in devicetree
To: Rob Herring <robh@kernel.org>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, Mark Rutland <mark.rutland@arm.com>,
	Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, Barry Song <baohua@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>, Linus Walleij <linus.walleij@linaro.org>,
	Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-watchdog@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Feb 19, 2018 at 8:06 AM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Feb 11, 2018 at 09:08:42PM +0100, Marcus Folkesson wrote:
>> watchdog_init_timeout() will allways pick timeout_param since it
>> defaults to a valid timeout.
>>
>> By following best practice described in
>> Documentation/watchdog/watchdog-kernel-api.txt, it also
>> let us to set timout-sec property in devicetree.
>>
>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 4 ++++
>>  drivers/watchdog/sunxi_wdt.c                             | 2 +-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
