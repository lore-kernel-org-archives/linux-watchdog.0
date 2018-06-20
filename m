Return-Path: <alexandre.torgue@st.com>
Return-path: <alexandre.torgue@st.com>
Subject: Re: [PATCH V2 0/3] add iwdg2 support for stm32mp157c
To: Ludovic Barre <ludovic.Barre@st.com>,
        Wim Van Sebroeck
	<wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring
	<robh+dt@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1529481238-15277-1-git-send-email-ludovic.Barre@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <18d48b13-2ff8-b27f-9b08-c414477976da@st.com>
Date: Wed, 20 Jun 2018 12:03:18 +0200
MIME-Version: 1.0
In-Reply-To: <1529481238-15277-1-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Ludovic

On 06/20/2018 09:53 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series updates stm32_iwdg driver to manage config
> by compatible. stm32mp1 config requires a pclk clock.
> 
> Ludovic Barre (3):
>    watchdog: stm32: add pclk feature for stm32mp1
>    ARM: dts: stm32: add iwdg2 support for stm32mp157c
>    ARM: dts: stm32: add iwdg2 support for stm32mp157c-ed1
> 
>   .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  21 +++-
>   arch/arm/boot/dts/stm32mp157c-ed1.dts              |   5 +
>   arch/arm/boot/dts/stm32mp157c.dtsi                 |   8 ++
>   drivers/watchdog/stm32_iwdg.c                      | 132 ++++++++++++++-------
>   4 files changed, 117 insertions(+), 49 deletions(-)
> 

STM32 DT patches looks good to me. I will take them as soon as driver 
part is acked.

Regards
Alex
