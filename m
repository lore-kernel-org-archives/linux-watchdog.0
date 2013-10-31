Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:51162 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab3JaG5Y (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Oct 2013 02:57:24 -0400
Received: by mail-ob0-f173.google.com with SMTP id gq1so2610644obb.18
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Oct 2013 23:57:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1383199250-15405-1-git-send-email-l.krishna@samsung.com>
References: <1383199250-15405-1-git-send-email-l.krishna@samsung.com>
Date: Thu, 31 Oct 2013 12:27:23 +0530
Message-ID: <CAK9yfHzyzVzQ7DWCAB+HabQLWTi1KeKae5YK9JK5D9LT6az3ag@mail.gmail.com>
Subject: Re: [PATCH V5 0/3] Add watchdog DT nodes and use syscon regmap
 interfac to configure pmu registers
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Tomasz Figa <t.figa@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela,

On 31 October 2013 11:30, Leela Krishna Amudala <l.krishna@samsung.com> wrote:
> This patchset does the following things
>         - Adds pmusysreg device node to exynos5.dtsi file
>         - Adds watchdog DT nodes to Exynos5250 and 5420
>         - Uses syscon regmap interface to configure pmu registers
>           to mask/unmask enable/disable of watchdog.
>
> This patch set is rebased on Kgene's for-next branch and tested on SMDK5420
>
> Changes since V4:
>         - changed the node name from pmusysreg to syscon and node label from pmu_sys_reg to pmu_syscon
>         - changed the property name from samsung,pmusysreg to samsung,syscon-phandle
>         - used regmap_update_bits instead of remap_read/regmap_write
>         - Addressed other comments given by Tomasz Figa <t.figa@samsung.com>
>
> Changes since V3:
>         - changed the compatible strings for watchdog node
>         - splitted up adding pmusysreg node and made it separate patch
>         - Addressed comments given by Sachin Kamat <sachin.kamat@linaro.org>
>
> Changes since V2:
>         - used syscon regmap interface to configure pmu registers in WDT driver
>           (suggested by Tomasz Figa <t.figa@samsung.com>)
>
> Changes since V1:
>         - Added new compatible string for Exynos5 SoCs
>         - Introduced quirk mechanism to program PMU registers
>         - Addressed comments given by Tomasz Figa <t.figa@samsung.com>
>
> Leela Krishna Amudala (3):
>   ARM: dts: Add pmu sysreg node to Exynos5 dtsi file
>   ARM: dts: add watchdog device nodes for Exynos5250 and Exynos5420
>   watchdog: s3c2410_wdt: use syscon regmap interface to configure pmu
>     register
>
>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |   22 ++-
>  arch/arm/boot/dts/exynos5.dtsi                     |   12 +-
>  arch/arm/boot/dts/exynos5250.dtsi                  |    7 +-
>  arch/arm/boot/dts/exynos5420.dtsi                  |   10 ++
>  drivers/watchdog/s3c2410_wdt.c                     |  150 +++++++++++++++++---
>  5 files changed, 175 insertions(+), 26 deletions(-)
>
> --
> 1.7.10.4
>

Series looks good. However, you would need to add select MFD_SYSCON option to
watchdog Kconfig for ARCH_EXYNOS5.

Tested this series on Origen (4210), Arndale (5250) and SMDK5420 boards.

Tested-by: Sachin Kamat <sachin.kamat@linaro.org>
Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>

-- 
With warm regards,
Sachin
