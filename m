Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33996 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab3LKMXH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 Dec 2013 07:23:07 -0500
MIME-Version: 1.0
In-Reply-To: <52A39F3B.5070806@gmail.com>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com>
 <1386308868-30264-2-git-send-email-l.krishna@samsung.com> <52A207D8.3030206@gmail.com>
 <8302228.6iSJIFqj3A@flatron> <52A39F3B.5070806@gmail.com>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Wed, 11 Dec 2013 21:22:45 +0900
Message-ID: <CAL1wa8fTuOMk9=G3JhdpNOE8=FPTfMSJ_mB-7jo1pNF1cAavgg@mail.gmail.com>
Subject: Re: [PATCH V12 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>,
	Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Douglas Anderson <dianders@chromium.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"cpgs ." <cpgs@samsung.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

As I was in travel not accessed my mails.

I'll try to post next version of this series tomorrow addressing
Sylwester's comments.

Best Wishes,
Leela Krishna.

On Sun, Dec 8, 2013 at 7:20 AM, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:
> Hi Tomasz,
>
>
> On 12/07/2013 01:57 AM, Tomasz Figa wrote:
>>
>> On Friday 06 of December 2013 18:22:32 Sylwester Nawrocki wrote:
>
> [...]
>
>> I wouldn't really nitpick on such things, but if we end up needing another
>> respin, here's what I think.
>
>
> Yeah, I didn't really realize the iteration index for this series was
> already
> a 2 digit number and some people could have already gotten upset or
> seriously
> impatient. Started to regret I even bothered with posting any comments to
> that.
> :) Anyway, I didn't request any corrections, just pointed out what could be
> improved. People are free to accept it or ignore as they see fit. And having
> seen patch series that got merged after periods like 2.5 year V12 is not
> something unusual anyway. :)
>
>
>>> On 12/06/2013 06:47 AM, Leela Krishna Amudala wrote:
>>>>
>>>> This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files
>>>> to
>>>
>>>
>>> s/pmusysreg/PMU sysreg ? Similarly I would capitalize it in the subject
>>> line as well.
>>
>>
>> Well, since this is supposed to be a human readable description, I would
>> go even further and write "...device tree node of Power Management Unit
>>   to...".
>
>
> Agreed, it sounds better.
>
>
>>>> handle PMU register accesses in a centralized way using syscon driver
>>>>
>>>> Signed-off-by: Leela Krishna Amudala<l.krishna@samsung.com>
>>>> Reviewed-by: Tomasz Figa<t.figa@samsung.com>
>>>> Reviewed-by: Doug Anderson<dianders@chromium.org>
>>>> Tested-by: Doug Anderson<dianders@chromium.org>
>>>> ---
>>>>    Documentation/devicetree/bindings/arm/samsung/pmu.txt |   15
>>>> +++++++++++++++
>>>>    arch/arm/boot/dts/exynos5250.dtsi                     |    5 +++++
>>>>    arch/arm/boot/dts/exynos5420.dtsi                     |    5 +++++
>>>>    3 files changed, 25 insertions(+)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/arm/samsung/pmu.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
>>>> b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
>>>> new file mode 100644
>>>> index 0000000..f1f1552
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
>>>
>>>
>>> I might be easy to confuse this with ARM Performance Monitoring Unit.
>>> So perhaps we should rename this file to, e.g. power-management-unit.txt
>>> ?
>>
>>
>> Considering location of this file, which is arm/samsung, I think this
>> name is pretty much clear. ARM PMU is a generic thing, so it couldn't
>> be placed here.
>
>
> It's up to the patch author if they want to change it or not, I still think
> it's better to not use short acronyms like this, if we can easily make it
> unambiguous.
>
>
>>>> @@ -0,0 +1,15 @@
>>>> +SAMSUNG Exynos SoC series PMU Registers
>>>
>>>
>>> s/PMU/Power Management Unit ?
>>
>>
>> s/PMU Registers/Power Management Unit/
>
>
> Yeah, that's more accurate.
>
>
>>>> +Properties:
>>>> + - compatible : should contain two values. First value must be one from
>>>> following list:
>>>> +                  - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
>>>> +                  - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
>>>
>>>
>>> s/./; ?
>>>
>>>> +               second value must be always "syscon".
>>>
>>>
>>> It might be more safe to specify it as the last value, so something along
>>> the lines of:
>>>
>>>         The last value should be "syscon".
>>>
>>>> +
>>>> + - reg : offset and length of the register set.
>>>> +
>>>> +Example :
>>>> +pmu_system_controller: system-controller@10040000 {
>>>
>>>
>>> Might be more sensible to use 'power_management_unit' for the label.
>>
>>
>> That's quite a lot of text for a label. pmu_syscon as in previous version
>> of this patch would look more sensible to me.
>
>
> I don't think it hurts to have this long labels, what I proposed is exactly
> of same length as the original one. Anyway pmu_syscon sounds good to me too.
>
>
>>>> +       compatible = "samsung,exynos5250-pmu", "syscon";
>>>> +       reg =<0x10040000 0x5000>;
>>>> +};
>>>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
>>>> b/arch/arm/boot/dts/exynos5250.dtsi
>>>> index b98ffc3..62f9e36 100644
>>>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>>>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>>>> @@ -163,6 +163,11 @@
>>>>                 interrupts =<0 47 0>;
>>>>         };
>>>>
>>>> +       pmu_system_controller: system-controller@10040000 {
>>>
>>>
>>> s/pmu_system_controller/power_management_unit ? So it describes the
>>> subsystem better in terms used in the SoCs User Manual ?
>>
>>
>> See above.
>
>
> I can't see anything wrong in such long labels, but this discussion is
> really
> just a bike-shedding, so let's end it right now not to risk annoying even
> more
> people! :)
>
> --
> Regards,
> Sylwester
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
