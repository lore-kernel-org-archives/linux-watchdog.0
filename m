Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20150915094443.GA3296@dhcppc13.redhat.com>
References: <=fu.wei@linaro.org>
	<1440435683-7343-1-git-send-email-fu.wei@linaro.org>
	<1440435683-7343-3-git-send-email-fu.wei@linaro.org>
	<20150915084332.GC5767@localhost.localdomain>
	<20150915094443.GA3296@dhcppc13.redhat.com>
Date: Tue, 15 Sep 2015 18:23:10 +0800
Message-ID: <CADyBb7uzeWrh88jtvDY1gDHye2zoko-zZ-0X_qBuYAigE3yipw@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
From: Fu Wei <fu.wei@linaro.org>
To: Pratyush Anand <panand@redhat.com>
Cc: Dave Young <dyoung@redhat.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>, Wim Van Sebroeck <wim@iguana.be>, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>, Geoff Levand <geoff@infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Pratyush,



On 15 September 2015 at 17:44, Pratyush Anand <panand@redhat.com> wrote:
> On 15/09/2015:04:43:32 PM, Dave Young wrote:
>> On 08/25/15 at 01:01am, fu.wei@linaro.org wrote:
>> > From: Fu Wei <fu.wei@linaro.org>
>> >
>> > This can be a example of adding SBSA Generic Watchdog device node
>> > into some dts files for the Soc which contains SBSA Generic Watchdog.
>> >
>> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>> > Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> > ---
>> >  arch/arm64/boot/dts/arm/foundation-v8.dts | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
>> > index 4eac8dc..824431f 100644
>> > --- a/arch/arm64/boot/dts/arm/foundation-v8.dts
>> > +++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
>> > @@ -237,4 +237,11 @@
>> >                     };
>> >             };
>> >     };
>> > +   watchdog@2a440000 {
>> > +           compatible = "arm,sbsa-gwdt";
>> > +           reg = <0x0 0x2a440000 0 0x1000>,
>> > +                   <0x0 0x2a450000 0 0x1000>;
>> > +           interrupts = <0 27 4>;
>> > +           timeout-sec = <10 5>;
>>
>> I assume 10 is timeout, 5 is pre timeout, but in the driver code the default
>> value is 30/10, I think the example dts[i] should use same default values as in code.
>>
>> BTW, for kdump kernel Pratyush is working on kdump on wdt enabled system.
>> Basiclly we expect one configure longer timeout, and kick it in shorter
>> period so we can get a chance to save vmcore. 10s sounds too short for the case..
>
> Specially if D-cache is not enabled in ARM64 kexec-tool/purgatory then its more
> than 2 min. Geoff has yet not agreed [1] to take D-cache support in purgatory.
>
> [1] https://www.mail-archive.com/kexec@lists.infradead.org/msg12881.html

Great thanks for your info.
I thinks I may need to make the default pretimeout longer in example,
may be at least 30s(for kdump kernel  with  D-cache)

any thought?

>
> ~Pratyush



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
