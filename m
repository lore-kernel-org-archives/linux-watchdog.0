Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37438 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbdC2DPx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Mar 2017 23:15:53 -0400
Subject: Re: [PATCH v3 1/5] dt-bindings: Document STM32 IWDG bindings
To: Yannick Fertre <yannick.fertre@st.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
 <1490195083-25117-2-git-send-email-yannick.fertre@st.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philippe Cornu <philippe.cornu@st.com>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <425a174f-91ca-75eb-cf3b-af8a1d06c705@roeck-us.net>
Date: Tue, 28 Mar 2017 20:15:40 -0700
MIME-Version: 1.0
In-Reply-To: <1490195083-25117-2-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/22/2017 08:04 AM, Yannick Fertre wrote:
> From: Yannick Fertre <yfertre.stm32@gmail.com>
>
> This adds documentation of device tree bindings for the STM32 IWDG
> (Independent WatchDoG).
>
> Change-Id: Idadacc806d00205fe9af2e8606af229b4b760558

Please drop.

> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> new file mode 100644
> index 0000000..036b040
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> @@ -0,0 +1,15 @@
> +STM32 Independent WatchDoG (IWDG)
> +---------------------------------
> +
> +Required properties:
> +- compatible: "st,stm32-iwdg"
> +- reg: physical base address and length of the registers set for the device
> +- clocks: must contain a single entry describing the clock input
> +
> +Example:
> +
> +iwdg@40003000 {
> +	compatible = "st,stm32-iwdg";
> +	reg = <0x40003000 0x400>;
> +	clocks = <&clk_lsi>;
> +};
>

