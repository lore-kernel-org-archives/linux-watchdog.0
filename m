Return-Path: <ryder.lee@mediatek.com>
Return-path: <ryder.lee@mediatek.com>
Message-ID: <1545020142.9822.2.camel@mtkswgap22>
Subject: Re: [PATCH] dt-bindings: watchdog: update bindings for MT7629 SoC
From: Ryder Lee <ryder.lee@mediatek.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, <linux-watchdog@vger.kernel.org>, Weijie Gao
	<weijie.gao@mediatek.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Date: Mon, 17 Dec 2018 12:15:42 +0800
In-Reply-To: <9fb38853-6202-c124-d254-f8d20b4d469b@roeck-us.net>
References: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
	 <4152fe87-0e72-f9aa-6874-9f40dc15f278@gmail.com>
	 <1545017947.7782.1.camel@mtkswgap22>
	 <9fb38853-6202-c124-d254-f8d20b4d469b@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, 2018-12-16 at 19:53 -0800, Guenter Roeck wrote:
> On 12/16/18 7:39 PM, Ryder Lee wrote:
> > Hi Matthias,
> > 
> > On Sun, 2018-12-16 at 11:31 +0100, Matthias Brugger wrote:
> >>
> >> On 07/11/2018 08:10, Ryder Lee wrote:
> >>> This updates dt-binding documentation for MT7629 SoC
> >>>
> >>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> >>
> >> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> >>
> >>> ---
> >>>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >>> index 859dee1..8682d6a 100644
> >>> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >>> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >>> @@ -8,6 +8,7 @@ Required properties:
> >>>   	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
> >>>   	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
> >>>   	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
> >>> +	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
> >>>   
> >>>   - reg : Specifies base physical address and size of the registers.
> >>>   
> >>>
> > 
> > Could you take this through your tree?
> > 
> 
> Why ? We usually take watchdog binding updates through the watchdog tree.
> 
> Guenter

Oh, okay :)

Ryder
