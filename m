Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56830 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdH0Qos (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 27 Aug 2017 12:44:48 -0400
Date: Sun, 27 Aug 2017 09:44:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 3/3] mfd: twl: move header file out of I2C realm
Message-ID: <20170827164444.GB22819@roeck-us.net>
References: <20170814163424.2197-1-wsa@the-dreams.de>
 <20170814163424.2197-4-wsa@the-dreams.de>
 <CACRpkdZd1TecLVQA2uPiPM_fWDw1mS2-kpmN06xp=dP4Wh-vYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZd1TecLVQA2uPiPM_fWDw1mS2-kpmN06xp=dP4Wh-vYQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Aug 22, 2017 at 03:06:31PM +0200, Linus Walleij wrote:
> On Mon, Aug 14, 2017 at 6:34 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> 
> > include/linux/i2c is not for client devices. Move the header file to a
> > more appropriate location.
> >
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Acked-by: Mark Brown <broonie@kernel.org>
> > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Acked-by: Thierry Reding <thierry.reding@gmail.com>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > ---
> >
> > Change since V1:
> >
> > * rebased to v4.13-rc5, one change needed (twl4030-adc.h gone, too)
> > * acks added. I think gpio and hwmon acks are missing.
> >   Linus, Guenter, pretty please? :)
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> For anything hitting GPIO.
> 
For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>

Sorry, I am a bit behind ...

Guenter
