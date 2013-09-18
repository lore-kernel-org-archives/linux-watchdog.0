Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:59643 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab3IREed (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Sep 2013 00:34:33 -0400
Received: by mail-ob0-f178.google.com with SMTP id uy5so6733359obc.37
        for <linux-watchdog@vger.kernel.org>; Tue, 17 Sep 2013 21:34:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3395282.rv7qzo3E3P@amdc1227>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
	<1379414623-26329-4-git-send-email-l.krishna@samsung.com>
	<3395282.rv7qzo3E3P@amdc1227>
Date: Tue, 17 Sep 2013 21:34:31 -0700
Message-ID: <CAD=FV=XQSLULsYanJCCFehxrs9LESZ=KO8XgyzZaacL4GNeXPA@mail.gmail.com>
Subject: Re: [PATCH 3/4] watchdog: s3c2410_wdt: parse watchdog dt node to read
 PMU registers adresses
From: Doug Anderson <dianders@chromium.org>
To: Tomasz Figa <t.figa@samsung.com>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tomasz,

On Tue, Sep 17, 2013 at 6:30 AM, Tomasz Figa <t.figa@samsung.com> wrote:
>> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> @@ -7,8 +7,20 @@ occurred.
>>  Required properties:
>>  - compatible : should be "samsung,s3c2410-wdt"
>
> Since the WDT block of Exynos 5420 needs some extra configuration in PMU
> registers, it is no longer compatible with samsung.s3c2410-wdt. Please
> introduce separate compatible ("samsung,exynos5420-wdt") and make the
> driver handle the additional configuration only if running on a device with
> this compatible value.
>
> I'd suggest introducing quirk system to the driver and adding a
> NEEDS_PMU_CONFIG quirk selected by DT match entry with "samsung,exynos5420-
> wdt" compatible.
>
>>  - reg : base physical address of the controller and length of memory
>> mapped -      region.
>> +     region and the optional (addresses and length of memory mapped regions
>> +     of) PMU registers for masking/unmasking WDT.
>>  - interrupts : interrupt number to the cpu.
>>
>>  Optional properties:
>>  - timeout-sec : contains the watchdog timeout in seconds.
>> +- reset-mask-bit: bit number in the PMU registers to program mask/unmask
>> WDT. +
>
> I believe this is mandatory on Exynos 5420 and unused on previous SoCs. It
> should be handled depending on compatible value.

I think at least 5250 needs something similar.  I believe we got away
with it in the past since other (non-WDT) code was tweaking with this
bit, but that was a little bit gross.  Leela Krishna can correct me if
I'm wrong.

-Doug
