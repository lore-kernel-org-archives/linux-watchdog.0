Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34201 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934368AbdCVOLA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 22 Mar 2017 10:11:00 -0400
Subject: Re: [PATCH v1 4/5] ARM: dts: stm32ap: Add watchdog support for
 STM32F429 eval board
To: Yannick Fertre <yannick.fertre@st.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <1490189786-19232-1-git-send-email-yannick.fertre@st.com>
 <1490189786-19232-5-git-send-email-yannick.fertre@st.com>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <877e3dbb-780c-1ece-04e1-594e8f783a5e@st.com>
Date: Wed, 22 Mar 2017 14:51:12 +0100
MIME-Version: 1.0
In-Reply-To: <1490189786-19232-5-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi

On 03/22/2017 02:36 PM, Yannick Fertre wrote:
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---

Please add a commit message and change commit header as following:

ARM: dts: stm32: .....


>  arch/arm/boot/dts/stm32429i-eval.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
> index 3c99466..aab81ed 100644
> --- a/arch/arm/boot/dts/stm32429i-eval.dts
> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
> @@ -181,3 +181,7 @@
>  	pinctrl-names = "default";
>  	status = "okay";
>  };
> +
> +&iwdg {
> +	status = "okay";
> +};
>
