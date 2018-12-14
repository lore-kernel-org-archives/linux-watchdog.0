Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34517 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbeLNO4y (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Dec 2018 09:56:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so4478614lfc.1
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Dec 2018 06:56:52 -0800 (PST)
MIME-Version: 1.0
References: <20181212220922.18759-1-paul@crapouillou.net> <20181212220922.18759-16-paul@crapouillou.net>
 <20181213092409.ml4wpnzow2nnszkd@pengutronix.de> <1544709795.18952.1@crapouillou.net>
 <20181213204219.onem3q6dcmakusl2@pengutronix.de> <CACRpkdbABtDgwKai=8Pfji7qVb-XHsX8pDsuDdS5hhg7qEN0Bw@mail.gmail.com>
 <20181214142628.zwi4hadrju53z6f3@pengutronix.de>
In-Reply-To: <20181214142628.zwi4hadrju53z6f3@pengutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Dec 2018 15:56:39 +0100
Message-ID: <CACRpkdYo0RrQTnjQhxG=CRa1AWoRrVjL9naYC_ZCz2_dzAz-Jg@mail.gmail.com>
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
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

On Fri, Dec 14, 2018 at 3:26 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Dec 14, 2018 at 02:50:20PM +0100, Linus Walleij wrote:

> > So if the PWM case is something similar, then by all means add
> > num-pwms.
>
> .. or "npwms" to use the same nomenclature as the gpio binding?

Either works for me, I don't have a very high need of consistency
but there are others that have so your suggestion seems wise.

Yours,
Linus Walleij
