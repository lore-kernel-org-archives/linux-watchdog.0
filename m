Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:40085 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020AbaAHLzv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Jan 2014 06:55:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAL1wa8cRKHPLBCUe33zBiKB_iqotGp1ZgWtSsAAUxL2fzrcsdQ@mail.gmail.com>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com> <CAL1wa8cRKHPLBCUe33zBiKB_iqotGp1ZgWtSsAAUxL2fzrcsdQ@mail.gmail.com>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Wed, 8 Jan 2014 20:55:29 +0900
Message-ID: <CAL1wa8diMjUpC73Fg0Ysw7QTZnATm=amzZ_DM8H0O5HOOTvPgA@mail.gmail.com>
Subject: Re: [PATCH V12 0/3] Add watchdog DT nodes and use syscon regmap
 interface to configure pmu registers
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"cpgs ." <cpgs@samsung.com>, Guenter Roeck <linux@roeck-us.net>,
	Leela Krishna Amudala <l.krishna@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Wim Van Sebroeck,

I believe that I addressed all the comments given by reviewers.
So can you look into this series and take necessary action..?

Best Wishes,
Leela Krishna.

On Wed, Dec 18, 2013 at 9:01 PM, Leela Krishna Amudala
<l.krishna@samsung.com> wrote:
> Hello Wim Van Sebroeck,
>
> Can you kindly look into this series and take necessary action..?
>
> Best Wishes,
> Leela Krishna.
>
>
> On Fri, Dec 6, 2013 at 2:47 PM, Leela Krishna Amudala
> <l.krishna@samsung.com> wrote:
>> This patchset does the following things
>>         - Adds pmusysreg device node to exynos5.dtsi file
>>         - Adds watchdog DT nodes to Exynos5250 and 5420
>>         - Uses syscon regmap interface to configure pmu registers
>>           to mask/unmask enable/disable of watchdog.
>>
>> This patch set is rebased on Kgene's for-next branch and tested on SMDK5420
>>
>> changes since V11:
>>         - Added EXYNOS5 prefix to REG_OFFSET defines (suggested by Tomasz)
>>         - NEEDS_PMU_CONFIG => HAS_PMU_CONFIG (suggested by Olof, Guenter)
>>         - Move QUIRK_HAS_PMU_CONFIG check to s3c2410wdt_mask_and_disable_reset (suggested by Guenter)
>>
>> changes since V10:
>>         - followed coding style rules
>>         - removed duplicate error message suggested by Guenter Roeck <linux@roeck-us.net>
>>
>> changes since V9:
>>         - added descriptions to s3c2410_wdt_variant structure fields
>>         - moved calling s3c2410wdt_mask_and_disable_reset() function above s3c2410wdt_start() call in probe
>>         - put dev_err message back to s3c2410wdt_mask_and_disable_reset() function
>>           (suggested by Doug Anderson <dianders@chromium.org>)
>>
>> changes since V8:
>>         - modified the patch description for the below patch
>>           "watchdog: s3c2410_wdt: use syscon regmap interface to configure pmu register"
>>         - removed MODULE_ALIAS in watchdog driver
>>         - changed dev_warn to dev_err in one failure case handling (suggested by Guenter Roeck <linux@roeck-us.net>)
>>         - renamed variable name from pmu_config to drv_data
>>         - changed the compatible field description in documentation file
>>           (suggested by Tomasz Figa <t.figa@samsung.com>)
>>
>> changes since V7:
>>         - re-ordered the patches in the series
>>         - moved pmu_config_s3c2410 structure out of ifdef CONFIG_OF
>>           and limited only this structure to platform match table
>>         - renamed structure name from s3c_wdt_driver_ids to s3c2410_wdt_ids
>>         - removed exynos variants from platform match table
>>           (suggested by Tomasz Figa <t.figa@samsung.com>)
>>
>> changes since V6:
>>         - added SoC-specific compatible value to syscon node and documented it
>>         - given more patch description for below patch
>>           ARM: dts: update watchdog device nodes for Exynos5250 and Exynos5420
>>         - added platform_device_id array for watchdog devices
>>         - selected MFD_SYSCON in Kconfig entry for watchdog
>>
>> Changes since V5:
>>         - removed status property in DT nodes
>>         - changed the return type for the function s3c2410wdt_mask_and_disable_reset()
>>           and handled error cases
>>         - Handled to get driver data in non-DT cases
>>         - Addressed comments given by Tomasz Figa <t.figa@samsung.com>
>>
>> Changes since V4:
>>         - changed the node name from pmusysreg to syscon and node label from pmu_sys_reg to pmu_syscon
>>         - changed the property name from samsung,pmusysreg to samsung,syscon-phandle
>>         - used regmap_update_bits instead of remap_read/regmap_write
>>         - Addressed other comments given by Tomasz Figa <t.figa@samsung.com>
>>
>> Changes since V3:
>>         - changed the compatible strings for watchdog node
>>         - splitted up adding pmusysreg node and made it separate patch
>>         - Addressed comments given by Sachin Kamat <sachin.kamat@linaro.org>
>>
>> Changes since V2:
>>         - used syscon regmap interface to configure pmu registers in WDT driver
>>           (suggested by Tomasz Figa <t.figa@samsung.com>)
>>
>> Changes since V1:
>>         - Added new compatible string for Exynos5 SoCs
>>         - Introduced quirk mechanism to program PMU registers
>>         - Addressed comments given by Tomasz Figa <t.figa@samsung.com>
>>
>> Leela Krishna Amudala (3):
>>   ARM: dts: Add pmu sysreg node to exynos5250 and exynos5420 dtsi files
>>   watchdog: s3c2410_wdt: use syscon regmap interface to configure pmu
>>     register
>>   ARM: dts: update watchdog device nodes for Exynos5250 and Exynos5420
>>
>>  .../devicetree/bindings/arm/samsung/pmu.txt        |   15 ++
>>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 ++-
>>  arch/arm/boot/dts/exynos5.dtsi                     |    7 -
>>  arch/arm/boot/dts/exynos5250.dtsi                  |   11 +-
>>  arch/arm/boot/dts/exynos5420.dtsi                  |   14 ++
>>  drivers/watchdog/Kconfig                           |    1 +
>>  drivers/watchdog/s3c2410_wdt.c                     |  154 ++++++++++++++++++--
>>  7 files changed, 205 insertions(+), 18 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
>>
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
