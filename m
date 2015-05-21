Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <10436688.ghBfa0dkUg@wuerfel>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-4-git-send-email-fu.wei@linaro.org>
	<10436688.ghBfa0dkUg@wuerfel>
Date: Thu, 21 May 2015 16:49:35 +0800
Message-ID: <CADyBb7v4XHV3Wig1J-WVXPpDcwV61-YReBUe5xXxQ=DQ7gbARQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
From: Fu Wei <fu.wei@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>, Guenter Roeck <linux@roeck-us.net>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>, "mark.rutland" <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Arnd,

yes, you are right , will delete it :-)

On 21 May 2015 at 16:45, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 21 May 2015 16:32:32 fu.wei@linaro.org wrote:
>> +       watchdog0: watchdog@2a450000 {
>> +               compatible = "arm,sbsa-gwdt";
>> +               reg = <0x0 0x2a450000 0 0x10000>,
>> +                       <0x0 0x2a440000 0 0x10000>;
>> +               reg-names = "refresh",
>> +                       "control";
>> +               interrupts = <0 27 4>;
>> +               interrupt-names = "ws0";
>> +               timeout-sec = <10 5>;
>> +       };
>>  };
>>
>
> just one tiny comment: you can drop the 'watchdog0:' label here, there
> is normally no reason to assign a label to a watchdog device, especially
> if it's in a .dts file rather than a .dtsi.
>
> The same is true for the example in the binding documentation.
>
>         Arnd



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
