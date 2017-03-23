Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33655 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755929AbdCWR3l (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 23 Mar 2017 13:29:41 -0400
Subject: Re: [PATCH v3 5/5] ARM: configs: Add watchdog support in STM32
 defconfig
To: Yannick Fertre <yannick.fertre@st.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
 <1490195083-25117-6-git-send-email-yannick.fertre@st.com>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <59b86243-9454-1570-9d3d-28c258b7da01@st.com>
Date: Thu, 23 Mar 2017 18:28:27 +0100
MIME-Version: 1.0
In-Reply-To: <1490195083-25117-6-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 03/22/2017 04:04 PM, Yannick Fertre wrote:
> This patch adds STM32 watchdog support in stm32_defconfig file
>
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---

Update commit header please (ARM: configs: stm32: Add watchdog support)

>  arch/arm/configs/stm32_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index a9d8e3c..83afa73 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -48,6 +48,7 @@ CONFIG_SERIAL_STM32=y
>  CONFIG_SERIAL_STM32_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
>  # CONFIG_HWMON is not set
> +CONFIG_WATCHDOG=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  # CONFIG_USB_SUPPORT is not set
>
