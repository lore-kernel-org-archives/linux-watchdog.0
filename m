Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36457 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1759029AbdCVOfN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 22 Mar 2017 10:35:13 -0400
Subject: Re: [PATCH v1 3/5] ARM: dts: stm32ap: Add watchdog support for
 STM32F429 SoC
To: Yannick Fertre <yannick.fertre@st.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <1490189786-19232-1-git-send-email-yannick.fertre@st.com>
 <1490189786-19232-4-git-send-email-yannick.fertre@st.com>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <70b47d08-9628-f0c6-094f-c3712527bda8@st.com>
Date: Wed, 22 Mar 2017 14:50:20 +0100
MIME-Version: 1.0
In-Reply-To: <1490189786-19232-4-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi

On 03/22/2017 02:36 PM, Yannick Fertre wrote:
> Signed-off-by: Yannick FERTRE <yannick.fertre@st.com>
> ---

Please add a commit message, and change commit header as following:

ARM: dts: stm32: ...

>  arch/arm/boot/dts/stm32f429.dtsi | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index ee0da97..148273b 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -65,7 +65,7 @@
>  			clock-frequency = <32768>;
>  		};
>
> -		clk-lsi {
> +		clk_lsi: clk-lsi {
>  			#clock-cells = <0>;
>  			compatible = "fixed-clock";
>  			clock-frequency = <32000>;
> @@ -812,6 +812,13 @@
>  			clocks = <&rcc 0 STM32F4_AHB2_CLOCK(RNG)>;
>
>  		};
> +
> +		iwdg: iwdg@40003000 {
Please try to keep nodes ordered.

> +			compatible = "st,stm32-iwdg";
> +			reg = <0x40003000 0x400>;
> +			clocks = <&clk_lsi>;
> +			status = "disabled";
> +		};
>  	};
>  };
>
>
