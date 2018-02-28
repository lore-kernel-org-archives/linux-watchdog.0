Return-Path: <f.fainelli@gmail.com>
Return-path: <f.fainelli@gmail.com>
Subject: Re: [PATCH v4] watchdog: add SPDX identifiers for watchdog subsystem
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Baruch Siach <baruch@tkos.co.il>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Jimmy Vance <jimmy.vance@hpe.com>, Keguang Zhang <keguang.zhang@gmail.com>,
 Joachim Eastwood <manabian@gmail.com>,
 Tomas Winkler <tomas.winkler@intel.com>,
 Johannes Thumshirn <morbidrsa@gmail.com>,
 Andreas Werner <andreas.werner@men.de>, Carlo Caione <carlo@caione.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Wan ZongShun
 <mcuos.com@gmail.com>, Michal Simek <michal.simek@xilinx.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux
 <slemieux.tyco@gmail.com>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Zwane Mwaikambo <zwanem@gmail.com>,
 Jim Cromie <jim.cromie@gmail.com>, Barry Song <baohua@kernel.org>,
 Patrice Chotard <patrice.chotard@st.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, Mans Rullgard <mans@mansr.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
 linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, patches@opensource.cirrus.com
References: <20180228150209.2525-1-marcus.folkesson@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <786d740d-f29c-8f09-4648-95244c06e59b@gmail.com>
Date: Wed, 28 Feb 2018 15:45:43 -0800
MIME-Version: 1.0
In-Reply-To: <20180228150209.2525-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On 02/28/2018 07:01 AM, Marcus Folkesson wrote:
> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>   license
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Baruch Siach <baruch@tkos.co.il>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> Acked-by: Johannes Thumshirn <jth@kernel.org>
> Acked-by: Mans Rullgard <mans@mansr.com>
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Tomas Winkler <tomas.winkler@intel.com>
> Acked-by: Patrice Chotard <patrice.chotard@st.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> ---
> 
> Notes:
>     v4:
>     	- Drop coh901327_wdt since it allready is a pending patch
>     v3:
>     	- Keep license text for ebc-c384_wdt
>     v2:
>     	- Put back removed copyright texts for meson_gxbb_wdt and coh901327_wdt
>     	- Change to BSD-3-Clause for meson_gxbb_wdt
>     v1: Please have an extra look at meson_gxbb_wdt.c
> 

>  drivers/watchdog/ar7_wdt.c             | 14 +---------

>  drivers/watchdog/bcm2835_wdt.c         |  5 +---
>  drivers/watchdog/bcm47xx_wdt.c         |  5 +---
>  drivers/watchdog/bcm63xx_wdt.c         |  5 +---
>  drivers/watchdog/bcm7038_wdt.c         | 12 ++------
>  drivers/watchdog/bcm_kona_wdt.c        |  9 +-----

>  drivers/watchdog/mtx-1_wdt.c           | 11 +-------

For these drivers above:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

and it looks like you missed rdc321x_wdt.c, is there a specific reason?
-- 
Florian
