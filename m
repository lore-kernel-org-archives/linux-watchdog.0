Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43025 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbeF0ArY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 26 Jun 2018 20:47:24 -0400
Subject: Re: [PATCH V5 5/5] ARM: dts: stm32: update iwdg with lsi clock name
 for stm32f429
To: Ludovic Barre <ludovic.Barre@st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-6-git-send-email-ludovic.Barre@st.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1f13d8f9-3459-c91c-6cb6-041504ac16e6@roeck-us.net>
Date: Tue, 26 Jun 2018 17:47:22 -0700
MIME-Version: 1.0
In-Reply-To: <1529941383-8653-6-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/25/2018 08:43 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch updates iwdg watchdog to use lsi clock name.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/boot/dts/stm32f429.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index ede77e0..39ea13a 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -310,6 +310,7 @@
>   			compatible = "st,stm32-iwdg";
>   			reg = <0x40003000 0x400>;
>   			clocks = <&clk_lsi>;
> +			clock-names = "lsi";
>   			status = "disabled";
>   		};
>   
> 

