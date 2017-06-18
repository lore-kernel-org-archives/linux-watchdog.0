Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Sun, 18 Jun 2017 09:04:39 -0500
From: Rob Herring <robh@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, wim@iguana.be, carlo@caione.org,
	khilman@baylibre.com, linux-watchdog@vger.kernel.org,
	linux-amlogic@lists.infradead.org, mark.rutland@arm.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: meson-wdt: add support for the watchdog on
 Meson8 and Meson8m2
Message-ID: <20170616180009.h66dwnnhfwrjpui6@rob-hp-laptop>
References: <20170611095219.22095-1-martin.blumenstingl@googlemail.com>
 <20170615172510.GA7549@roeck-us.net>
 <CAFBinCCyqX=TGwTyhxXZPP2noUvJ1v=xNs+Vs17Gg4z2uDgjEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCCyqX=TGwTyhxXZPP2noUvJ1v=xNs+Vs17Gg4z2uDgjEA@mail.gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Jun 15, 2017 at 11:13:07PM +0200, Martin Blumenstingl wrote:
> On Thu, Jun 15, 2017 at 7:25 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Sun, Jun 11, 2017 at 11:52:19AM +0200, Martin Blumenstingl wrote:
> >> The watchdog IP block on Meson8 and Meson8m2 is already supported by the
> >> existing meson-wdt driver. Meson8 uses the same register bits as Meson6,
> >> while the newer Meson8m2 SoC uses the same register bits as Meson8b.
> >>
> >> Currently watchdog support on Meson8 SoC already works because
> >> meson8.dtsi simply uses the "amlogic,meson6-wdt" compatible. Adding a
> >> separate compatible for Meson8 makes this more explicit though.
> >>
> >> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> thank you!
> is there anything holding you up from taking this patch (for example:
> are you still missing any specific Signed-off-by / Acked-by)?
> 
> > In general, changes like this are not necessary, though. The dts file
> > is supposed to reference both generic and specific compatible strings.
> I thought about skipping this patch, but I find that it looks strange without.
> 
> the hierarchy and the corresponding compatible strings would be:
> meson.dtsi / compatible = "amlogic,meson6-wdt";
> |- meson8.dtsi / compatible = "amlogic,meson8-wdt", "amlogic,meson6-wdt";
>    |- meson8m2.dtsi (upcoming) / compatible = "amlogic,meson8m2-wdt",
> "amlogic,meson8b-wdt";
> |- meson8b.dtsi / compatible = "amlogic,meson8b-wdt";
> 
> instead of this seemingly random mixup of compatible strings I decided
> to introduce separate ones for each SoC.

But if the block is backwards compatible, you should also provide a 
fallback compatible string.

Rob
