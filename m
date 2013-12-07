Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:40166 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab3LGA5e (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Dec 2013 19:57:34 -0500
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc@vger.kernel.org, wim@iguana.be,
	dianders@chromium.org, kgene.kim@samsung.com, t.figa@samsung.com,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, linux@roeck-us.net
Subject: Re: [PATCH V12 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and exynos5420 dtsi files
Date: Sat, 07 Dec 2013 01:57:27 +0100
Message-ID: <8302228.6iSJIFqj3A@flatron>
In-Reply-To: <52A207D8.3030206@gmail.com>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com> <1386308868-30264-2-git-send-email-l.krishna@samsung.com> <52A207D8.3030206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sylwester,

On Friday 06 of December 2013 18:22:32 Sylwester Nawrocki wrote:
> Hi,
> 
> Just a few minor comments...

I wouldn't really nitpick on such things, but if we end up needing another
respin, here's what I think.

> 
> On 12/06/2013 06:47 AM, Leela Krishna Amudala wrote:
> > This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
> 
> s/pmusysreg/PMU sysreg ? Similarly I would capitalize it in the subject
> line as well.

Well, since this is supposed to be a human readable description, I would
go even further and write "...device tree node of Power Management Unit
 to...".

> 
> > handle PMU register accesses in a centralized way using syscon driver
> >
> > Signed-off-by: Leela Krishna Amudala<l.krishna@samsung.com>
> > Reviewed-by: Tomasz Figa<t.figa@samsung.com>
> > Reviewed-by: Doug Anderson<dianders@chromium.org>
> > Tested-by: Doug Anderson<dianders@chromium.org>
> > ---
> >   Documentation/devicetree/bindings/arm/samsung/pmu.txt |   15 +++++++++++++++
> >   arch/arm/boot/dts/exynos5250.dtsi                     |    5 +++++
> >   arch/arm/boot/dts/exynos5420.dtsi                     |    5 +++++
> >   3 files changed, 25 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
> >
> > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> > new file mode 100644
> > index 0000000..f1f1552
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> 
> I might be easy to confuse this with ARM Performance Monitoring Unit.
> So perhaps we should rename this file to, e.g. power-management-unit.txt ?

Considering location of this file, which is arm/samsung, I think this
name is pretty much clear. ARM PMU is a generic thing, so it couldn't
be placed here.

> 
> > @@ -0,0 +1,15 @@
> > +SAMSUNG Exynos SoC series PMU Registers
> 
> s/PMU/Power Management Unit ?

s/PMU Registers/Power Management Unit/

> 
> > +
> > +Properties:
> > + - compatible : should contain two values. First value must be one from following list:
> > +		   - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
> > +		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
> 
> s/./; ?
> 
> > +		second value must be always "syscon".
> 
> It might be more safe to specify it as the last value, so something along
> the lines of:
> 
> 	The last value should be "syscon".
> 
> > +
> > + - reg : offset and length of the register set.
> > +
> > +Example :
> > +pmu_system_controller: system-controller@10040000 {
> 
> Might be more sensible to use 'power_management_unit' for the label.

That's quite a lot of text for a label. pmu_syscon as in previous version
of this patch would look more sensible to me.

> 
> > +	compatible = "samsung,exynos5250-pmu", "syscon";
> > +	reg =<0x10040000 0x5000>;
> > +};
> > diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> > index b98ffc3..62f9e36 100644
> > --- a/arch/arm/boot/dts/exynos5250.dtsi
> > +++ b/arch/arm/boot/dts/exynos5250.dtsi
> > @@ -163,6 +163,11 @@
> >   		interrupts =<0 47 0>;
> >   	};
> >
> > +	pmu_system_controller: system-controller@10040000 {
> 
> s/pmu_system_controller/power_management_unit ? So it describes the 
> subsystem
> better in terms used in the SoCs User Manual ?

See above.

> 
> > +		compatible = "samsung,exynos5250-pmu", "syscon";
> > +		reg =<0x10040000 0x5000>;
> > +	};
> > +
> >   	watchdog {
> >   		clocks =<&clock 336>;
> >   		clock-names = "watchdog";
> > diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> > index b1fa334..cd47db0 100644
> > --- a/arch/arm/boot/dts/exynos5420.dtsi
> > +++ b/arch/arm/boot/dts/exynos5420.dtsi
> > @@ -402,4 +402,9 @@
> >   		clock-names = "gscl";
> >   		samsung,power-domain =<&gsc_pd>;
> >   	};
> > +
> > +	pmu_system_controller: system-controller@10040000 {
> 
> s/pmu_system_controller/power_management_unit ?

See above.

Best regards,
Tomasz

