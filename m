Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39108 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbeLNNue (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Dec 2018 08:50:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so4300148lfh.6
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Dec 2018 05:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20181212220922.18759-1-paul@crapouillou.net> <20181212220922.18759-16-paul@crapouillou.net>
 <20181213092409.ml4wpnzow2nnszkd@pengutronix.de> <1544709795.18952.1@crapouillou.net>
 <20181213204219.onem3q6dcmakusl2@pengutronix.de>
In-Reply-To: <20181213204219.onem3q6dcmakusl2@pengutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Dec 2018 14:50:20 +0100
Message-ID: <CACRpkdbABtDgwKai=8Pfji7qVb-XHsX8pDsuDdS5hhg7qEN0Bw@mail.gmail.com>
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Paul Cercueil <paul@crapouillou.net>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>, ezequiel@collabora.co.uk,
        prasannatsmkumar@gmail.com, linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>, od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Dec 13, 2018 at 9:42 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> [Adding Linus Walleij to Cc:]
>
> Hello,
>
> On Thu, Dec 13, 2018 at 03:03:15PM +0100, Paul Cercueil wrote:
> > Le jeu. 13 d=C3=A9c. 2018 =C3=A0 10:24, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > > On Wed, Dec 12, 2018 at 11:09:10PM +0100, Paul Cercueil wrote:
> > > >  The PWM in the JZ4725B works the same as in the JZ4740, except tha=
t
> > > > it
> > > >  only has 6 channels available instead of 8.
> > >
> > > this driver is probed only from device tree? If yes, it might be
> > > sensible to specify the number of PWMs there and get it from there.
> > > There doesn't seem to be a generic binding for that, but there are
> > > several drivers that could benefit from it. (This is a bigger project
> > > though and shouldn't stop your patch. Still more as it already got
> > > Thierry's ack.)
> >
> > I think there needs to be a proper guideline, as there doesn't seem to =
be
> > a consensus about this. I learned from emails with Rob and Linus (Walle=
ij)
> > that I should not have in devicetree what I can deduce from the compati=
ble
> > string.
>
> I understood them a bit differently. It is ok to deduce things from the
> compatible string. But if you define a generic property (say) "num-pwms"
> that is used uniformly in most bindings this is ok, too. (And then the
> two different devices could use the same compatible.)
>
> An upside of the generic "num-pwms" property is that the pwm core could
> sanity check pwm phandles before passing them to the hardware drivers.

I don't know if this helps, but in GPIO we have "ngpios" which is
used to augment an existing block as to the number of lines actually
used with it.

The typical case is that an ASIC engineer synthesize a block for
32 GPIOs but only 12 of them are routed to external pads. So
we augment the behaviour of that driver to only use 12 of the
32 lines.

I guess using the remaining 20 lines "works" in a sense but they
have no practical use and will just bias electrons in the silicon
for no use.

So if the PWM case is something similar, then by all means add
num-pwms.

Yours,
Linus Walleij
