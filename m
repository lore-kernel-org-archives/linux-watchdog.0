Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37563 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbdC2DBC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Mar 2017 23:01:02 -0400
Subject: Re: [PATCH v3 0/5] STM32 Independant watchdog
To: Yannick Fertre <yannick.fertre@st.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philippe Cornu <philippe.cornu@st.com>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1390e264-2b54-c07b-89d3-9f5dd7d7254e@roeck-us.net>
Date: Tue, 28 Mar 2017 20:00:57 -0700
MIME-Version: 1.0
In-Reply-To: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Subject: s/Independant/Independent/

On 03/22/2017 08:04 AM, Yannick Fertre wrote:
> Version 3:
> - Update typo into  bindings file
> - Reorder node in devicetree (ordering by address)
> - Remove unecessary lines in commits
>
> Version 2:
> - Add commit messages
>
> Version 1:
> - Initial commit
>
> The purpose of this set of patches is to add a new watchdog driver for
> stm32f429.
> This driver was developed and tested on evaluation board stm32429i.
>
> Yannick Fertre (5):
>   dt-bindings: Document STM32 IWDG bindings
>   drivers: watchdog: Add STM32 IWDG driver
>   ARM: dts: stm32: Add watchdog support for STM32F429 SoC
>   ARM: dts: stm32: Add watchdog support for STM32F429 eval board
>   ARM: configs: Add watchdog support in STM32 defconfig
>
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  15 ++
>  arch/arm/boot/dts/stm32429i-eval.dts               |   4 +
>  arch/arm/boot/dts/stm32f429.dtsi                   |   9 +-
>  arch/arm/configs/stm32_defconfig                   |   1 +
>  drivers/watchdog/Kconfig                           |  11 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/stm32_iwdg.c                      | 289 +++++++++++++++++++++
>  7 files changed, 329 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>  create mode 100644 drivers/watchdog/stm32_iwdg.c
>

