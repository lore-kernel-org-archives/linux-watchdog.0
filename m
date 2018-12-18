Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbeLRQgu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 18 Dec 2018 11:36:50 -0500
MIME-Version: 1.0
References: <20181212220922.18759-1-paul@crapouillou.net> <20181212220922.18759-4-paul@crapouillou.net>
 <20181217210531.GA29770@bogus> <1545084222.1958.0@smtp.crapouillou.net>
In-Reply-To: <1545084222.1958.0@smtp.crapouillou.net>
From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Dec 2018 10:36:36 -0600
Message-ID: <CAL_JsqLhnitSM7-S1hq8M7S-7BHO5oYByXQ8QD2JkUY3jb63fQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/26] dt-bindings: Add doc for the Ingenic TCU drivers
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Dec 17, 2018 at 4:04 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Rob,
>
> Le lun. 17 d=C3=A9c. 2018 =C3=A0 22:05, Rob Herring <robh@kernel.org> a =
=C3=A9crit :
> > On Wed, Dec 12, 2018 at 11:08:58PM +0100, Paul Cercueil wrote:
> >>  Add documentation about how to properly use the Ingenic TCU
> >>  (Timer/Counter Unit) drivers from devicetree.
> >>
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>
> >>  Notes:
> >>       v4: New patch in this series. Corresponds to V2 patches 3-4-5
> >> with
> >>           added content.
> >>
> >>       v5: - Edited PWM/watchdog DT bindings documentation to point
> >> to the new
> >>             document.
> >>           - Moved main document to
> >>             Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> >>           - Updated documentation to reflect the new devicetree
> >> bindings.
> >>
> >>       v6: - Removed PWM/watchdog documentation files as asked by
> >> upstream
> >>           - Removed doc about properties that should be implicit
> >>           - Removed doc about ingenic,timer-channel /
> >>             ingenic,clocksource-channel as they are gone
> >>           - Fix WDT clock name in the binding doc
> >>           - Fix lengths of register areas in watchdog/pwm nodes
> >>
> >>       v7: No change
> >>
> >>       v8: - Fix address of the PWM node
> >>           - Added doc about system timer and clocksource children
> >> nodes
> >
> > I thought we'd sorted this out...
>
> Yeah, well I just can't please everybody. V6/V7 didn't have the
> system timer or clocksource in devicetree, which was good for
> you, but then the driver nearly doubled in size and complexity,
> and Thierry rightfully refused it. Now I'm at the point where

You mean Daniel?

> I'm trying alternative ways of encoding the information in
> devicetree, as suggested by various people, just so that you
> accept it. Because I don't see any other option.

Does the problem boil down to needing to reserve channel x to use PWMx
pin? If so, just do a mask property of reserved for PWM channels.

Sorry this is going in circles.

Rob
