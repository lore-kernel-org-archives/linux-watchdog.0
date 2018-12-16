Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41462 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbeLPKbK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 16 Dec 2018 05:31:10 -0500
Subject: Re: [PATCH] dt-bindings: watchdog: update bindings for MT7629 SoC
To: Ryder Lee <ryder.lee@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc: linux-watchdog@vger.kernel.org,
        Weijie Gao <weijie.gao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <4152fe87-0e72-f9aa-6874-9f40dc15f278@gmail.com>
Date: Sun, 16 Dec 2018 11:31:04 +0100
MIME-Version: 1.0
In-Reply-To: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 07/11/2018 08:10, Ryder Lee wrote:
> This updates dt-binding documentation for MT7629 SoC
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index 859dee1..8682d6a 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -8,6 +8,7 @@ Required properties:
>  	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
>  	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
>  	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
> +	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
>  
>  - reg : Specifies base physical address and size of the registers.
>  
> 
