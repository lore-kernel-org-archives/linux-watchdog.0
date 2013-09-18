Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:32835 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab3IRGuv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Sep 2013 02:50:51 -0400
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XQSLULsYanJCCFehxrs9LESZ=KO8XgyzZaacL4GNeXPA@mail.gmail.com>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
 <1379414623-26329-4-git-send-email-l.krishna@samsung.com> <3395282.rv7qzo3E3P@amdc1227>
 <CAD=FV=XQSLULsYanJCCFehxrs9LESZ=KO8XgyzZaacL4GNeXPA@mail.gmail.com>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Wed, 18 Sep 2013 12:20:31 +0530
Message-ID: <CAL1wa8eWKNL3kdfjqxqaLsAtc8nqgiPW34SBk4gozAR1jnRaSg@mail.gmail.com>
Subject: Re: [PATCH 3/4] watchdog: s3c2410_wdt: parse watchdog dt node to read
 PMU registers adresses
To: Doug Anderson <dianders@chromium.org>
Cc: Tomasz Figa <t.figa@samsung.com>,
	Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tomasz,

On Wed, Sep 18, 2013 at 10:04 AM, Doug Anderson <dianders@chromium.org> wrote:
> Tomasz,
>
> On Tue, Sep 17, 2013 at 6:30 AM, Tomasz Figa <t.figa@samsung.com> wrote:
>>> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>>> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>>> @@ -7,8 +7,20 @@ occurred.
>>>  Required properties:
>>>  - compatible : should be "samsung,s3c2410-wdt"
>>
>> Since the WDT block of Exynos 5420 needs some extra configuration in PMU
>> registers, it is no longer compatible with samsung.s3c2410-wdt. Please
>> introduce separate compatible ("samsung,exynos5420-wdt") and make the
>> driver handle the additional configuration only if running on a device with
>> this compatible value.
>>
>> I'd suggest introducing quirk system to the driver and adding a
>> NEEDS_PMU_CONFIG quirk selected by DT match entry with "samsung,exynos5420-
>> wdt" compatible.
>>
>>>  - reg : base physical address of the controller and length of memory
>>> mapped -      region.
>>> +     region and the optional (addresses and length of memory mapped regions
>>> +     of) PMU registers for masking/unmasking WDT.
>>>  - interrupts : interrupt number to the cpu.
>>>
>>>  Optional properties:
>>>  - timeout-sec : contains the watchdog timeout in seconds.
>>> +- reset-mask-bit: bit number in the PMU registers to program mask/unmask
>>> WDT. +
>>
>> I believe this is mandatory on Exynos 5420 and unused on previous SoCs. It
>> should be handled depending on compatible value.
>
> I think at least 5250 needs something similar.  I believe we got away
> with it in the past since other (non-WDT) code was tweaking with this
> bit, but that was a little bit gross.  Leela Krishna can correct me if
> I'm wrong.
>

Yes, 5250 also needs this reset-mask-bit, but not required by SoCs
other than Exynos5xxx.
Hence I kept it as optional parameter.

I took care of this code such that it won't break on older SoCs.

If you notice the code in probe function, I used the check condition

if (!IS_ERR(wdt->pmu_disable_reg) && !IS_ERR(wdt->pmu_mask_reset_reg)) {
}

i.e., if any of the PMU register address is not mentioned in the DT
node it simply skips reading reset-mask-bit
and continues execution (which may happen in older SoC DT node).

..also, in s3c2410wdt_mask_and_disable_reset() function, below
condition check is happening

if (IS_ERR(wdt->pmu_disable_reg) || IS_ERR(wdt->pmu_mask_reset_reg)
                                || (wdt->pmu_mask_bit < 0))
        return;

i.e., if any of the registers is not specified in DT node simply
return without programming
PMU registers(which is true in case of older SoCs).

If you think this doesn't sounds good way of handling older SoCs.
I'll add new compatible string for Exynos5xxx and do like what you said. :)

Best Wishes,
Leela Krishna Amudala

> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
