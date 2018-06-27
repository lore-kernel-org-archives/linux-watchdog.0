Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35406 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbeF0Aq1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 26 Jun 2018 20:46:27 -0400
Subject: Re: [PATCH V5 3/5] ARM: dts: stm32: add iwdg2 support for stm32mp157c
To: Ludovic Barre <ludovic.Barre@st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-4-git-send-email-ludovic.Barre@st.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a9fb5eaf-f76b-2fc4-e027-12712b3af589@roeck-us.net>
Date: Tue, 26 Jun 2018 17:46:24 -0700
MIME-Version: 1.0
In-Reply-To: <1529941383-8653-4-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/25/2018 08:43 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds independent watchdog support for stm32mp157c.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Presumably this and the following patches will be pushed upstream
through an ARM tree.

Guenter

> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 7d17538..95cc166 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -784,6 +784,14 @@
>   			status = "disabled";
>   		};
>   
> +		iwdg2: watchdog@5a002000 {
> +			compatible = "st,stm32mp1-iwdg";
> +			reg = <0x5a002000 0x400>;
> +			clocks = <&rcc IWDG2>, <&rcc CK_LSI>;
> +			clock-names = "pclk", "lsi";
> +			status = "disabled";
> +		};
> +
>   		usbphyc: usbphyc@5a006000 {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> 

