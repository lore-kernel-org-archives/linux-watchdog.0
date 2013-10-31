Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36772 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab3JaF3p (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Oct 2013 01:29:45 -0400
MIME-Version: 1.0
In-Reply-To: <1713455.GWPmumZDIq@amdc1227>
References: <1383126673-29033-1-git-send-email-l.krishna@samsung.com>
 <1383126673-29033-2-git-send-email-l.krishna@samsung.com> <1713455.GWPmumZDIq@amdc1227>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Thu, 31 Oct 2013 10:59:23 +0530
Message-ID: <CAL1wa8fDcewih3x9B-JoYnY6-1xtCUkDRYp6AO0TAQsrHqHiOg@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] ARM: dts: Add pmu sysreg node to Exynos5 dtsi file
To: Tomasz Figa <t.figa@samsung.com>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com,
	Sachin Kamat <sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tomasz,

On Wed, Oct 30, 2013 at 8:12 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Leela,
>
> On Wednesday 30 of October 2013 15:21:11 Leela Krishna Amudala wrote:
>> This patch adds pmusysreg node to Exynos5 dtsi file to handle PMU
>> register accesses in a centralized way using syscon driver
>>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5.dtsi |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
>> index e52b038..918e732 100644
>> --- a/arch/arm/boot/dts/exynos5.dtsi
>> +++ b/arch/arm/boot/dts/exynos5.dtsi
>> @@ -106,4 +106,9 @@
>>               #size-cells = <0>;
>>               status = "disabled";
>>       };
>> +
>> +     pmu_sys_reg: pmusysreg@1004000 {
>
> Please keep the node name generic, syscon should be fine. Also there is
> a typo in unit-address suffix. The label could also have a better name,
> like pmu_syscon.
>

Okay, will change it.
/Leela Krishna

> Best regards,
> Tomasz
>
>> +             compatible = "syscon";
>> +             reg = <0x10040000 0x5000>;
>> +     };
>>  };
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
