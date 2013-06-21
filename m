Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
To: Boris BREZILLON <b.brezillon@overkiz.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        "Ferre, Nicolas" <Nicolas.FERRE@atmel.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC PATCH 0/4] watchdog: at91sam9_wdt: handle already
 configured wdt
Date: Fri, 21 Jun 2013 01:47:40 +0000
Message-ID: <B256D81BAE5131468A838E5D7A243641687DE078@penmbx01>
References: <1370947890-954-1-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1370947890-954-1-git-send-email-b.brezillon@overkiz.com>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>



> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of Boris BREZILLON
> Sent: 2013Äê6ÔÂ11ÈÕ 18:51
> To: Wim Van Sebroeck; Jean-Christophe Plagniol-Villard; Ferre, Nicolas;
> linux-watchdog@vger.kernel.org
> Cc: devicetree-discuss@lists.ozlabs.org; linux-doc@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Boris
> BREZILLON
> Subject: [RFC PATCH 0/4] watchdog: at91sam9_wdt: handle already configured
> wdt
> 
> Hello,
> 
> This patch series is a porposal to enhance the sam9 watchdog timer support.
> 
> The at91sam9 watchdog timer cannot configured twice, and the current
> implementation only tries to configure in a static way:
> - 2 seconds timeout
> - wdt restart every 500ms
> 
> If the timer has already been configured with different values, it returns an
> error and do not create any watchdog device.
> 
> This is not critical if the watchdog is disabled, but if it has been enabled with
> different timeout values it will lead to a SoC reset.
> 
> This patch series tries to address this issue by adapting the heartbeat value
> according the WDT timer config:
> - it first tries to configure the timer as requested.
> - if it fails it fallbacks to the current config, adapting its heartbeat timer
> to the needs
> 
> This patch series also move to a dynamically allocated at91wdt device instead
> of the static instance. I'm not sure this is the best solution, so please tell
> me if you prefer to keep static instance of watchdog.
> 
> It adds a new at91 wdt type: software. This new type make use of the at91 wdt
> interrupt to trigger a software watchdog.
> 
> Finally it adds several properties to the device tree bindings.
> 
> Best Regards,
> Boris
> 
> Boris BREZILLON (4):
>   watchdog: at91sam9_wdt: better watchdog support
>   watchdog: at91sam9_wdt: update device tree doc
>   ARM: at91/dt: add sam9 watchdog default options to SoCs
>   ARM: at91/dt: add watchdog properties to kizbox board
> 
>  .../devicetree/bindings/watchdog/atmel-wdt.txt     |   30 +-
>  arch/arm/boot/dts/at91sam9260.dtsi                 |    5 +
>  arch/arm/boot/dts/at91sam9263.dtsi                 |    5 +
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |    5 +
>  arch/arm/boot/dts/at91sam9n12.dtsi                 |    5 +
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |    5 +
>  arch/arm/boot/dts/kizbox.dts                       |    6 +
>  arch/arm/boot/dts/sama5d3.dtsi                     |    5 +
>  drivers/watchdog/at91sam9_wdt.c                    |  319
> +++++++++++++++-----
>  9 files changed, 300 insertions(+), 85 deletions(-)
> 
> --
> 1.7.9.5
> 
> 
Tested on sama5d34ek, at91sam9g25ek, linux-next_20130620

Tested by Wenyou Yang <Wenyou.yang@atmel.com>


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
ÿôèº{.nÇ+‰·Ÿ®‰­†+%ŠËÿ±éİ¶¥Šwÿº{.nÇ+‰·¥Š{±şG«éÿŠ{ayº
Ê‡Ú™ë,j­¢f£¢·hšïêÿ‘êçz_è®(­éšŠİ¢j"ú¶m§ÿÿ¾«şG«éÿ¢¸?™¨è­Ú&£ø§~á¶iO•æ¬z·švØ^¶m§ÿÿÃ
ÿ¶ìÿ¢¸?–I¥
