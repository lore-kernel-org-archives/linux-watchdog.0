Return-Path: <dianders@google.com>
MIME-Version: 1.0
Sender: dianders@google.com
In-Reply-To: <1676404.arUWsvfauz@flatron>
References: <1385613243-3559-1-git-send-email-l.krishna@samsung.com>
	<1979723.ga7TBeh7CQ@flatron>
	<CAD=FV=UcqaG9Dw_rd-bdTAmDwdW-_yCO6HpaEr1G07AW4TWm0w@mail.gmail.com>
	<1676404.arUWsvfauz@flatron>
Date: Thu, 5 Dec 2013 11:02:50 -0800
Message-ID: <CAD=FV=XHLfJr=5d9Ush4BSYYtx3jrby+N=e503YUFVUsnn+fGA@mail.gmail.com>
Subject: Re: [PATCH V11 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
From: Doug Anderson <dianders@chromium.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, Leela Krishna Amudala <l.krishna@samsung.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "cpgs ." <cpgs@samsung.com>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-watchdog@vger.kernel.org>

Tomasz,

On Thu, Dec 5, 2013 at 10:59 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Thursday 05 of December 2013 10:35:20 Doug Anderson wrote:
>> Tomasz,
>>
>> On Thu, Dec 5, 2013 at 10:30 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> >> I'd vote for using "pmu-system-registers".  We end up using the
>> >> "syscon" subsystem but really we're describing pmu registers.
>> >>
>> >> I'd even say that you don't need to formally specify the "name" in the
>> >> bindings (though I'm not up with all the latest device tree
>> >> requirements).  ...still you'd want to use "pmu-system-registers" in
>> >> the DTS changes.
>> >
>> > Well, since the name should specify the class of device, I would say that
>> > pmu-system-registers is too specific. If we want to change this, I'd say
>> > we should go with system-controller.
>>
>> ...but the "compatible" is "samsung,exynos5250-pmu", "syscon", right?
>> That means that the class of the device is "exynos5250-pmu", right?
>
> Nope. "samsung,exynos5250-pmu" is the specific device (or hardware
> programming interface) this device is compatible with.
>
> With class I mean the generic kind of device, such as system-controller,
> i2c, pinctrl, display, etc., as specified by sections 2.2.1 and 2.2.2 of
> ePAPR.
>
> Anyway, node names are just a matter of coding style, as they don't have
> any semantical meaning in most cases (such as this one).
>
>> It is also compatible with the generic "syscon" class of devices.
>
> It is also compatible with the generic "syscon" programming interface,
> which represents a set of loosely related registers that control various
> aspects of other IP blocks.

OK.  I will certainly cede to your superior knowledge of device tree
conventions.

Leela Krishna: unless someone else comes up with a convincing
argument, it sounds like the dts files should have the name
"system-controller" and the bindings change should remove all
references to the name.

-Doug
