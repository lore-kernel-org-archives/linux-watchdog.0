Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34204 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752106AbeF0HEb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 27 Jun 2018 03:04:31 -0400
Subject: Re: [PATCH V5 0/5] add iwdg2 support for stm32mp157c
To: Ludovic Barre <ludovic.Barre@st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c6996e7f-2b30-6eaf-afa3-5a98b6dcaa78@st.com>
Date: Wed, 27 Jun 2018 09:03:31 +0200
MIME-Version: 1.0
In-Reply-To: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter

On 06/25/2018 05:42 PM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series updates stm32_iwdg driver to manage pclk
> clock by compatible. stm32mp1 requires a pclk clock.
> 
> v5:
> -update stm32f429.dtsi
> 
> v4:
> -dt-bindings: split and review
> 
> v3:
> -remove stm32_iwdg_config structure, just assign the
>   boolean directly to .dat
> 
> Ludovic Barre (5):
>    dt-bindings: watchdog: add stm32mp1 support
>    watchdog: stm32: add pclk feature for stm32mp1
>    ARM: dts: stm32: add iwdg2 support for stm32mp157c
>    ARM: dts: stm32: add iwdg2 support for stm32mp157c-ed1
>    ARM: dts: stm32: update iwdg with lsi clock name for stm32f429

I will take DT patches in my tree.

Thanks
alex

> 
>   .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  13 ++-
>   arch/arm/boot/dts/stm32f429.dtsi                   |   1 +
>   arch/arm/boot/dts/stm32mp157c-ed1.dts              |   5 +
>   arch/arm/boot/dts/stm32mp157c.dtsi                 |   8 ++
>   drivers/watchdog/stm32_iwdg.c                      | 116 +++++++++++++--------
>   5 files changed, 98 insertions(+), 45 deletions(-)
> 
