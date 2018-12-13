Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52753 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeLMUmf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 13 Dec 2018 15:42:35 -0500
Date: Thu, 13 Dec 2018 21:42:19 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
Message-ID: <20181213204219.onem3q6dcmakusl2@pengutronix.de>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-16-paul@crapouillou.net>
 <20181213092409.ml4wpnzow2nnszkd@pengutronix.de>
 <1544709795.18952.1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544709795.18952.1@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

[Adding Linus Walleij to Cc:]

Hello,

On Thu, Dec 13, 2018 at 03:03:15PM +0100, Paul Cercueil wrote:
> Le jeu. 13 déc. 2018 à 10:24, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Wed, Dec 12, 2018 at 11:09:10PM +0100, Paul Cercueil wrote:
> > >  The PWM in the JZ4725B works the same as in the JZ4740, except that
> > > it
> > >  only has 6 channels available instead of 8.
> > 
> > this driver is probed only from device tree? If yes, it might be
> > sensible to specify the number of PWMs there and get it from there.
> > There doesn't seem to be a generic binding for that, but there are
> > several drivers that could benefit from it. (This is a bigger project
> > though and shouldn't stop your patch. Still more as it already got
> > Thierry's ack.)
> 
> I think there needs to be a proper guideline, as there doesn't seem to be
> a consensus about this. I learned from emails with Rob and Linus (Walleij)
> that I should not have in devicetree what I can deduce from the compatible
> string.

I understood them a bit differently. It is ok to deduce things from the
compatible string. But if you define a generic property (say) "num-pwms"
that is used uniformly in most bindings this is ok, too. (And then the
two different devices could use the same compatible.)

An upside of the generic "num-pwms" property is that the pwm core could
sanity check pwm phandles before passing them to the hardware drivers.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
