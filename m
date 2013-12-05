Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:41941 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab3LES0T (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Dec 2013 13:26:19 -0500
Received: by mail-qe0-f45.google.com with SMTP id 6so17757208qea.32
        for <linux-watchdog@vger.kernel.org>; Thu, 05 Dec 2013 10:26:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1468334.WxyIceyAAx@flatron>
References: <1385613243-3559-1-git-send-email-l.krishna@samsung.com>
	<1385613243-3559-2-git-send-email-l.krishna@samsung.com>
	<CAOesGMjbWRwEvuYh2DRvUfKm=fMmLOzpKCOO9p-gNvSXuf5hQg@mail.gmail.com>
	<1468334.WxyIceyAAx@flatron>
Date: Thu, 5 Dec 2013 10:26:18 -0800
Message-ID: <CAD=FV=VKT2mdwNMeZrimurtHeqNBJcpbmZzXV1-es2DxKcFXqw@mail.gmail.com>
Subject: Re: [PATCH V11 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
From: Doug Anderson <dianders@chromium.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Olof Johansson <olof@lixom.net>,
	Leela Krishna Amudala <l.krishna@samsung.com>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"cpgs ." <cpgs@samsung.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Leela Krishna,

On Mon, Dec 2, 2013 at 11:49 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Monday 02 of December 2013 10:50:14 Olof Johansson wrote:
>> Hi,
>>
>> On Wed, Nov 27, 2013 at 8:34 PM, Leela Krishna Amudala
>> <l.krishna@samsung.com> wrote:
>> > This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
>> > handle PMU register accesses in a centralized way using syscon driver
>> >
>> > Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>> > Reviewed-by: Doug Anderson <dianders@chromium.org>
>> > Tested-by: Doug Anderson <dianders@chromium.org>
>> > ---
>> >  Documentation/devicetree/bindings/arm/samsung/pmu.txt |   16 ++++++++++++++++
>> >  arch/arm/boot/dts/exynos5250.dtsi                     |    5 +++++
>> >  arch/arm/boot/dts/exynos5420.dtsi                     |    5 +++++
>> >  3 files changed, 26 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
>> > new file mode 100644
>> > index 0000000..307e727
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
>> > @@ -0,0 +1,16 @@
>> > +SAMSUNG Exynos SoC series PMU Registers
>> > +
>> > +Properties:
>> > + - name : should be 'syscon';
>>
>> It's common to use a non-abbreviated name, such as 'system-controller'
>> here. Or, given that it's referring to "pmusysreg" then maybe
>> something like "pmu-system-registers".
>
> Hmm, it's two syscons vs two system-controllers in existing device trees.
> I agree that system-controller sounds much better as a name for this class
> of devices. I don't remember why I initially suggested syscon, though.
> Possibly based on those two existing device trees using this name.

I'd vote for using "pmu-system-registers".  We end up using the
"syscon" subsystem but really we're describing pmu registers.

I'd even say that you don't need to formally specify the "name" in the
bindings (though I'm not up with all the latest device tree
requirements).  ...still you'd want to use "pmu-system-registers" in
the DTS changes.

Can you spin up a v12?

Thanks!

-Doug
