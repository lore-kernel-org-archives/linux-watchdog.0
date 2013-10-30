Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:39351 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab3J3IOy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 04:14:54 -0400
MIME-Version: 1.0
In-Reply-To: <CAK9yfHzcDcL7EUVd2_EWoG1Qd=aqXXOh+Zb8MAB0kN1b1_cArA@mail.gmail.com>
References: <1383116025-5638-1-git-send-email-l.krishna@samsung.com>
 <1383116025-5638-2-git-send-email-l.krishna@samsung.com> <CAK9yfHzcDcL7EUVd2_EWoG1Qd=aqXXOh+Zb8MAB0kN1b1_cArA@mail.gmail.com>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Wed, 30 Oct 2013 13:44:32 +0530
Message-ID: <CAL1wa8fpiJ5QYefLzUUDsoyLm9vDMOQ4tkJMJPfOvbkGT0Jcww@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: add watchdog device nodes for Exynos5250
 and Exynos5420
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Wed, Oct 30, 2013 at 12:20 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Hi Leela,
>
> On 30 October 2013 12:23, Leela Krishna Amudala <l.krishna@samsung.com> wrote:
>> Adds watchdog device nodes to the DT device list for Exynos5250 and Exynos5420
>>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5.dtsi    |   12 +++++-------
>>  arch/arm/boot/dts/exynos5250.dtsi |    7 ++++++-
>>  arch/arm/boot/dts/exynos5420.dtsi |   10 ++++++++++
>>  3 files changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
>> index e52b038..e7b6dbd 100644
>> --- a/arch/arm/boot/dts/exynos5.dtsi
>> +++ b/arch/arm/boot/dts/exynos5.dtsi
>> @@ -81,13 +81,6 @@
>>                 status = "disabled";
>>         };
>>
>> -       watchdog {
>> -               compatible = "samsung,s3c2410-wdt";
>> -               reg = <0x101D0000 0x100>;
>> -               interrupts = <0 42 0>;
>> -               status = "disabled";
>> -       };
>> -
>>         fimd@14400000 {
>>                 compatible = "samsung,exynos5250-fimd";
>>                 interrupt-parent = <&combiner>;
>> @@ -106,4 +99,9 @@
>>                 #size-cells = <0>;
>>                 status = "disabled";
>>         };
>> +
>> +       pmu_sys_reg: pmusysreg {
>
> Make this pmusysreg@10040000.
>

Okay, will do it

>> +               compatible = "samsung,exynos5-pmureg", "syscon";
>
> I do not see any reference to "samsung,exynos5-pmureg" in the tree.
>

Okay, will take care of it

>> +               reg = <0x10040000 0x5000>;
>> +       };
>
> Since this is a separate node, IMO it could be added in a separate patch.
>

Okay, will do it

>>  };
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index c4a8662..3ccd150 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -158,9 +158,14 @@
>>                 interrupts = <0 47 0>;
>>         };
>>
>> -       watchdog {
>> +       watchdog@101D0000 {
>> +               compatible = "samsung,s3c5250-wdt";
>
> Exynos5 does not belong to S3C series. Please change this to
> exynos5250-wdt instead.
>

My mistake, will change it

>> +               reg = <0x101D0000 0x100>;
>> +               interrupts = <0 42 0>;
>>                 clocks = <&clock 336>;
>>                 clock-names = "watchdog";
>> +               samsung,sysreg = <&pmu_sys_reg>;
>> +               status = "okay";
>>         };
>>
>>         g2d@10850000 {
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index 6ffefd1..5fb7ae2 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -369,4 +369,14 @@
>>                 clock-names = "gscl";
>>                 samsung,power-domain = <&gsc_pd>;
>>         };
>> +
>> +        watchdog@101D0000 {
>> +               compatible = "samsung,s3c5420-wdt";
>
> ditto
>
>> +               reg = <0x101D0000 0x100>;
>> +               interrupts = <0 42 0>;
>> +               clocks = <&clock 316>;
>> +               clock-names = "watchdog";
>> +               samsung,sysreg = <&pmu_sys_reg>;
>> +               status = "okay";
>> +        };
>>  };
>> --
>> 1.7.10.4
>>
>
>
>
> --
> With warm regards,
> Sachin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
