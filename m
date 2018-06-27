Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46775 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753244AbeF0AlW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 26 Jun 2018 20:41:22 -0400
Subject: Re: [PATCH V5 1/5] dt-bindings: watchdog: add stm32mp1 support
To: Ludovic Barre <ludovic.Barre@st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-2-git-send-email-ludovic.Barre@st.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a3e9d3a1-eb7a-5752-6c87-fa1906889543@roeck-us.net>
Date: Tue, 26 Jun 2018 17:41:20 -0700
MIME-Version: 1.0
In-Reply-To: <1529941383-8653-2-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/25/2018 08:42 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds support of stm32mp1.
> stm32mp1 requires 2 clocks lsi and pclk.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Following Rob's lead here.

Reviewed-by: Guenter Roeck Linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/st,stm32-iwdg.txt          | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> index cc13b10a..d8f4430 100644
> --- a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> +++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> @@ -2,9 +2,15 @@ STM32 Independent WatchDoG (IWDG)
>   ---------------------------------
>   
>   Required properties:
> -- compatible: "st,stm32-iwdg"
> -- reg: physical base address and length of the registers set for the device
> -- clocks: must contain a single entry describing the clock input
> +- compatible: Should be either:
> +  - "st,stm32-iwdg"
> +  - "st,stm32mp1-iwdg"
> +- reg: Physical base address and length of the registers set for the device
> +- clocks: Reference to the clock entry lsi. Additional pclk clock entry
> +  is required only for st,stm32mp1-iwdg.
> +- clock-names: Name of the clocks used.
> +  "lsi" for st,stm32-iwdg
> +  "lsi", "pclk" for st,stm32mp1-iwdg
>   
>   Optional Properties:
>   - timeout-sec: Watchdog timeout value in seconds.
> @@ -15,5 +21,6 @@ iwdg: watchdog@40003000 {
>   	compatible = "st,stm32-iwdg";
>   	reg = <0x40003000 0x400>;
>   	clocks = <&clk_lsi>;
> +	clock-names = "lsi";
>   	timeout-sec = <32>;
>   };
> 

