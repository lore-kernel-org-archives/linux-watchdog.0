Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55476 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbaLMPp4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 13 Dec 2014 10:45:56 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XzotI-000eH3-FJ
	for linux-watchdog@vger.kernel.org; Sat, 13 Dec 2014 15:45:56 +0000
Message-ID: <548C5F1F.8070804@roeck-us.net>
Date: Sat, 13 Dec 2014 07:45:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Matthias Brugger <matthias.bgg@gmail.com>, wim@iguana.be,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	grant.likely@linaro.org
CC: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, heiko@sntech.de,
	yingjoe.chen@gmail.com, ibanezchen@gmail.com,
	greta.zhang@mediatek.com, eddie.huang@mediatek.com
Subject: Re: [PATCH v2 2/2] ARM: mediatek: dts: Add bindings for watchdog
References: <1418395859-32209-1-git-send-email-matthias.bgg@gmail.com> <1418395859-32209-3-git-send-email-matthias.bgg@gmail.com>
In-Reply-To: <1418395859-32209-3-git-send-email-matthias.bgg@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/12/2014 06:50 AM, Matthias Brugger wrote:
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> new file mode 100644
> index 0000000..af9eb5b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -0,0 +1,13 @@
> +Mediatek SoCs Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be "mediatek,mt6589-wdt"

"mediatek" is undefined as vendor prefix in the current upstream code.
Is this vendor prefix coming in from another patch set ?

Guenter

> +- reg : Specifies base physical address and size of the registers.
> +
> +Example:
> +
> +wdt: watchdog@010000000 {
> +	compatible = "mediatek,mt6589-wdt";
> +	reg = <0x10000000 0x18>;
> +};
>

