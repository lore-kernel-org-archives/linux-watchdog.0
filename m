Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:34004 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbeLMODY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 13 Dec 2018 09:03:24 -0500
Date: Thu, 13 Dec 2018 15:03:15 +0100
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
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
        linux-clk@vger.kernel.org, od@zcrc.me
Message-Id: <1544709795.18952.1@crapouillou.net>
In-Reply-To: <20181213092409.ml4wpnzow2nnszkd@pengutronix.de>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-16-paul@crapouillou.net>
        <20181213092409.ml4wpnzow2nnszkd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

Le jeu. 13 d=E9c. 2018 =E0 10:24, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello,
>=20
> On Wed, Dec 12, 2018 at 11:09:10PM +0100, Paul Cercueil wrote:
>>  The PWM in the JZ4725B works the same as in the JZ4740, except that=20
>> it
>>  only has 6 channels available instead of 8.
>=20
> this driver is probed only from device tree? If yes, it might be
> sensible to specify the number of PWMs there and get it from there.
> There doesn't seem to be a generic binding for that, but there are
> several drivers that could benefit from it. (This is a bigger project
> though and shouldn't stop your patch. Still more as it already got
> Thierry's ack.)

I think there needs to be a proper guideline, as there doesn't seem to=20
be
a consensus about this. I learned from emails with Rob and Linus=20
(Walleij)
that I should not have in devicetree what I can deduce from the=20
compatible
string.

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |
=
