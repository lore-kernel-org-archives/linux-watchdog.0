Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Olof Johansson <olof@lixom.net>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Doug Anderson <dianders@chromium.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, cpgs@samsung.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V11 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and exynos5420 dtsi files
Date: Mon, 02 Dec 2013 20:49:39 +0100
Message-ID: <1468334.WxyIceyAAx@flatron>
In-Reply-To: <CAOesGMjbWRwEvuYh2DRvUfKm=fMmLOzpKCOO9p-gNvSXuf5hQg@mail.gmail.com>
References: <1385613243-3559-1-git-send-email-l.krishna@samsung.com> <1385613243-3559-2-git-send-email-l.krishna@samsung.com> <CAOesGMjbWRwEvuYh2DRvUfKm=fMmLOzpKCOO9p-gNvSXuf5hQg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Monday 02 of December 2013 10:50:14 Olof Johansson wrote:
> Hi,
> 
> On Wed, Nov 27, 2013 at 8:34 PM, Leela Krishna Amudala
> <l.krishna@samsung.com> wrote:
> > This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
> > handle PMU register accesses in a centralized way using syscon driver
> >
> > Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> > Reviewed-by: Doug Anderson <dianders@chromium.org>
> > Tested-by: Doug Anderson <dianders@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/arm/samsung/pmu.txt |   16 ++++++++++++++++
> >  arch/arm/boot/dts/exynos5250.dtsi                     |    5 +++++
> >  arch/arm/boot/dts/exynos5420.dtsi                     |    5 +++++
> >  3 files changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
> >
> > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> > new file mode 100644
> > index 0000000..307e727
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> > @@ -0,0 +1,16 @@
> > +SAMSUNG Exynos SoC series PMU Registers
> > +
> > +Properties:
> > + - name : should be 'syscon';
> 
> It's common to use a non-abbreviated name, such as 'system-controller'
> here. Or, given that it's referring to "pmusysreg" then maybe
> something like "pmu-system-registers".

Hmm, it's two syscons vs two system-controllers in existing device trees.
I agree that system-controller sounds much better as a name for this class
of devices. I don't remember why I initially suggested syscon, though.
Possibly based on those two existing device trees using this name.

Best regards,
Tomasz
