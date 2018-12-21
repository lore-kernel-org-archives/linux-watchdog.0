Return-Path: <linus.walleij@linaro.org>
Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
References: <20181211120412.27773-1-linus.walleij@linaro.org> <20181215163125.GA14086@roeck-us.net>
In-Reply-To: <20181215163125.GA14086@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Dec 2018 11:22:08 +0100
Message-ID: <CACRpkdY5W-ZOX7X-KmVNcxVBJp1en4j=wrO8x0hGcDkwOOHQ2A@mail.gmail.com>
Subject: Re: [v3] watchdog: mtx-1: Convert to use GPIO descriptor
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, Dec 15, 2018 at 5:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Dec 11, 2018 at 01:04:12PM +0100, Linus Walleij wrote:

> > This converts the MTX-1 driver to grab a GPIO descriptor
> > associated with the device instead of using a resource with
> > a global GPIO number.
> >
> > The board using this driver appears to be out-of-tree
> > (OpenWRT), but the users can be easily augmented by adding a
> > machine descriptor table before registering the device.
> >
> Is that still accurate, given the discussion and mips specific changes ?
>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> We'll need an Acked-by: from a mips maintainer to land this.

Florian is a MIPS (subarch) maintainer, tell me if you want
to resend this with the collected reviewed-by and also
include the toplevel MIPS maintainers.

Yours,
Linus Walleij
