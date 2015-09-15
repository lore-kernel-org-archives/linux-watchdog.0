Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36454 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbbIOKPv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 15 Sep 2015 06:15:51 -0400
Received: by oibi136 with SMTP id i136so92524530oib.3
        for <linux-watchdog@vger.kernel.org>; Tue, 15 Sep 2015 03:15:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150915084332.GC5767@localhost.localdomain>
References: <=fu.wei@linaro.org>
	<1440435683-7343-1-git-send-email-fu.wei@linaro.org>
	<1440435683-7343-3-git-send-email-fu.wei@linaro.org>
	<20150915084332.GC5767@localhost.localdomain>
Date: Tue, 15 Sep 2015 18:15:50 +0800
Message-ID: <CADyBb7vB9Mv1YApY0H3+wkapn6agQJTs46ap4BHaOyYmLh+pLg@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
From: Fu Wei <fu.wei@linaro.org>
To: Dave Young <dyoung@redhat.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Pratyush Anand <panand@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Dave,

On 15 September 2015 at 16:43, Dave Young <dyoung@redhat.com> wrote:
> On 08/25/15 at 01:01am, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This can be a example of adding SBSA Generic Watchdog device node
>> into some dts files for the Soc which contains SBSA Generic Watchdog.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  arch/arm64/boot/dts/arm/foundation-v8.dts | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
>> index 4eac8dc..824431f 100644
>> --- a/arch/arm64/boot/dts/arm/foundation-v8.dts
>> +++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
>> @@ -237,4 +237,11 @@
>>                       };
>>               };
>>       };
>> +     watchdog@2a440000 {
>> +             compatible = "arm,sbsa-gwdt";
>> +             reg = <0x0 0x2a440000 0 0x1000>,
>> +                     <0x0 0x2a450000 0 0x1000>;
>> +             interrupts = <0 27 4>;
>> +             timeout-sec = <10 5>;
>
> I assume 10 is timeout, 5 is pre timeout, but in the driver code the default
> value is 30/10, I think the example dts[i] should use same default values as in code.

yes, that is good idea, will make them to be the same.  :-)

>
> BTW, for kdump kernel Pratyush is working on kdump on wdt enabled system.
> Basiclly we expect one configure longer timeout, and kick it in shorter
> period so we can get a chance to save vmcore. 10s sounds too short for the case..

Thanks for your info.

So that means: we may need that long timeout support in the second stage.
WOR is not enough for  the second stage in most of kdump case.

>
>> +     };
>>  };
>> --
>> 2.4.3
>>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
