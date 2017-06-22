Return-Path: <robh@kernel.org>
Return-path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFBinCAZZMT-YDHg4SYF3da+00KLYE-dZaEDPaEMRz_2paXNQw@mail.gmail.com>
References: <20170611095219.22095-1-martin.blumenstingl@googlemail.com>
 <20170615172510.GA7549@roeck-us.net> <CAFBinCCyqX=TGwTyhxXZPP2noUvJ1v=xNs+Vs17Gg4z2uDgjEA@mail.gmail.com>
 <20170616180009.h66dwnnhfwrjpui6@rob-hp-laptop> <CAFBinCAZZMT-YDHg4SYF3da+00KLYE-dZaEDPaEMRz_2paXNQw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 21 Jun 2017 22:22:56 -0500
Message-ID: <CAL_JsqJutEYt0eG96RG+jMosCEkqK=145Kquj2qJdQCV=wh2zg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: meson-wdt: add support for the watchdog on
 Meson8 and Meson8m2
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>, Carlo Caione <carlo@caione.org>,
	Kevin Hilman <khilman@baylibre.com>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
	linux-amlogic@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Jun 19, 2017 at 1:50 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> Hi Rob,
>
> On Sun, Jun 18, 2017 at 4:04 PM, Rob Herring <robh@kernel.org> wrote:
>> On Thu, Jun 15, 2017 at 11:13:07PM +0200, Martin Blumenstingl wrote:
>>> On Thu, Jun 15, 2017 at 7:25 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>> > On Sun, Jun 11, 2017 at 11:52:19AM +0200, Martin Blumenstingl wrote:
>>> >> The watchdog IP block on Meson8 and Meson8m2 is already supported by the
>>> >> existing meson-wdt driver. Meson8 uses the same register bits as Meson6,
>>> >> while the newer Meson8m2 SoC uses the same register bits as Meson8b.
>>> >>
>>> >> Currently watchdog support on Meson8 SoC already works because
>>> >> meson8.dtsi simply uses the "amlogic,meson6-wdt" compatible. Adding a
>>> >> separate compatible for Meson8 makes this more explicit though.
>>> >>
>>> >> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> >
>>> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>> thank you!
>>> is there anything holding you up from taking this patch (for example:
>>> are you still missing any specific Signed-off-by / Acked-by)?
>>>
>>> > In general, changes like this are not necessary, though. The dts file
>>> > is supposed to reference both generic and specific compatible strings.
>>> I thought about skipping this patch, but I find that it looks strange without.
>>>
>>> the hierarchy and the corresponding compatible strings would be:
>>> meson.dtsi / compatible = "amlogic,meson6-wdt";
>>> |- meson8.dtsi / compatible = "amlogic,meson8-wdt", "amlogic,meson6-wdt";
>>>    |- meson8m2.dtsi (upcoming) / compatible = "amlogic,meson8m2-wdt",
>>> "amlogic,meson8b-wdt";
>>> |- meson8b.dtsi / compatible = "amlogic,meson8b-wdt";
>>>
>>> instead of this seemingly random mixup of compatible strings I decided
>>> to introduce separate ones for each SoC.
>>
>> But if the block is backwards compatible, you should also provide a
>> fallback compatible string.
> OK, fine with me - do you want me to update the documentation to
> reflect this (or is it enough if I take care of it in the .dts files)?
> the resulting documentation could look like this:
>        "amlogic,meson6-wdt" on Meson6 SoCs
>        "amlogic,meson8-wdt" along with "amlogic,meson6-wdt" on Meson8 SoCs
>        "amlogic,meson8b-wdt" on Meson8b SoCs
>        "amlogic,meson8m2-wdt" along with "amlogic,meson8b-wdt" on Meson8m2 SoCs

Yes, like this.

Rob
