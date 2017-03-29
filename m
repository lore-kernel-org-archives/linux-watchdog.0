Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34743 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbdC2Bk3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Mar 2017 21:40:29 -0400
Date: Tue, 28 Mar 2017 20:40:26 -0500
From: Rob Herring <robh@kernel.org>
To: Yannick Fertre <yannick.fertre@st.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philippe Cornu <philippe.cornu@st.com>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/5] dt-bindings: Document STM32 IWDG bindings
Message-ID: <20170329014026.fxrv7hwoueh6tplm@rob-hp-laptop>
References: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
 <1490195083-25117-2-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490195083-25117-2-git-send-email-yannick.fertre@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 22, 2017 at 04:04:39PM +0100, Yannick Fertre wrote:
> From: Yannick Fertre <yfertre.stm32@gmail.com>

"dt-bindings: watchdog: ..." for subject.
> 
> This adds documentation of device tree bindings for the STM32 IWDG
> (Independent WatchDoG).
> 
> Change-Id: Idadacc806d00205fe9af2e8606af229b4b760558
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

watchdog@...

> +	compatible = "st,stm32-iwdg";
> +	reg = <0x40003000 0x400>;
> +	clocks = <&clk_lsi>;
> +};
> -- 
> 1.9.1
> 
