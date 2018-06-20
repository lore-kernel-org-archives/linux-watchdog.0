Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35589 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754463AbeFTTOL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 20 Jun 2018 15:14:11 -0400
Date: Wed, 20 Jun 2018 13:14:09 -0600
From: Rob Herring <robh@kernel.org>
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 1/3] watchdog: stm32: add pclk feature for stm32mp1
Message-ID: <20180620191409.GA29934@rob-hp-laptop>
References: <1529502698-13263-1-git-send-email-ludovic.Barre@st.com>
 <1529502698-13263-2-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529502698-13263-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 20, 2018 at 03:51:36PM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds config data to manage specific properties by
> compatible. Adds stm32mp1 config which requires pclk clock.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  21 +++-

Please split bindings to separate patch.

>  drivers/watchdog/stm32_iwdg.c                      | 116 +++++++++++++--------
>  2 files changed, 91 insertions(+), 46 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> index cc13b10a..f07f6d89 100644
> --- a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> +++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> @@ -2,18 +2,31 @@ STM32 Independent WatchDoG (IWDG)
>  ---------------------------------
>  
>  Required properties:
> -- compatible: "st,stm32-iwdg"
> -- reg: physical base address and length of the registers set for the device
> -- clocks: must contain a single entry describing the clock input
> +- compatible: Should be either "st,stm32-iwdg" or "st,stm32mp1-iwdg"

Please format one per line.

> +- reg: Physical base address and length of the registers set for the device
> +- clocks: Reference to the clock entry lsi. Additional pclk clock entry
> +  is required only for st,stm32mp1-iwdg.
> +- clock-names: Name of the clocks used.
> +  "lsi" for st,stm32-iwdg
> +  "pclk", "lsi" for st,stm32mp1-iwdg

Put lsi 1st so it is always index 0.

>  
>  Optional Properties:
>  - timeout-sec: Watchdog timeout value in seconds.
>  
> -Example:
> +Examples:
>  
>  iwdg: watchdog@40003000 {
>  	compatible = "st,stm32-iwdg";
>  	reg = <0x40003000 0x400>;
>  	clocks = <&clk_lsi>;
> +	clock-names = "lsi";
> +	timeout-sec = <32>;
> +};
> +
> +iwdg: iwdg@5a002000 {

watchdog@...

Do we really need 2 example just to show 2 clocks?

> +	compatible = "st,stm32mp1-iwdg";
> +	reg = <0x5a002000 0x400>;
> +	clocks = <&rcc IWDG2>, <&clk_lsi>;
> +	clock-names = "pclk", "lsi";
>  	timeout-sec = <32>;
>  };
