Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20150522150145.GA2930@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555F4236.7040206@linaro.org>
	<4095167.UOriXdSu53@wuerfel>
	<20150522150145.GA2930@roeck-us.net>
Date: Sat, 23 May 2015 22:47:50 +0800
Message-ID: <CADyBb7v3=-rnSCTYYQvKCn5r=4JmrZgV8i0wivbpBD6BsbNAnA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	vgandhi@codeaurora.org, wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,


On 22 May 2015 at 23:01, Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, May 22, 2015 at 04:55:04PM +0200, Arnd Bergmann wrote:
>> On Friday 22 May 2015 22:50:30 Hanjun Guo wrote:
>> > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> > > index e5e7c55..25a0df1 100644
>> > > --- a/drivers/watchdog/Kconfig
>> > > +++ b/drivers/watchdog/Kconfig
>> > > @@ -152,6 +152,18 @@ config ARM_SP805_WATCHDOG
>> > >         ARM Primecell SP805 Watchdog timer. This will reboot your system when
>> > >         the timeout is reached.
>> > >
>> > > +config ARM_SBSA_WATCHDOG
>> > > +     tristate "ARM SBSA Generic Watchdog"
>> > > +     depends on ARM || ARM64 || COMPILE_TEST
>> >
>> > SBSA is for ARMv8-A based (64-bit) servers, no need to depends on ARM,
>> > and why we depends on COMPILE_TEST?
>> >
>>
>> I think it's a reasonable assumption that someone will sooner or later
>> put that hardware into an ARM32 machine, or run a 32-bit kernel on
>> a chip that has it.
>>
>> While SBSA requires this watchdog device, nothing prevents SoC
>> manufacturers from using the same design in something that is not
>> a server.
>>
> Tricky, though. Since teh driver uses arm specific clock functions,
> I don't think this can compile on a non-arm machine.

yes, According to SBSA spec, the clock source of SBSAwatchdog is
system counter which is a part of arm arch timer.
So I think SBSA watchdog always goes with  ARM.

ARM arch timer has been used on ARM32 and ARM64, so SBSA also can be
used on ARM32.
Just  there is not a ARM32 hardware has that IP core right now.

>
> Guenter



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
