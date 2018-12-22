Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36901 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeLVQxL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 22 Dec 2018 11:53:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so5975471lfj.4
        for <linux-watchdog@vger.kernel.org>; Sat, 22 Dec 2018 08:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20181211120412.27773-1-linus.walleij@linaro.org>
 <20181215163125.GA14086@roeck-us.net> <CACRpkdY5W-ZOX7X-KmVNcxVBJp1en4j=wrO8x0hGcDkwOOHQ2A@mail.gmail.com>
 <e0da671e-a312-5ad4-c60a-05629762cce6@roeck-us.net>
In-Reply-To: <e0da671e-a312-5ad4-c60a-05629762cce6@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 22 Dec 2018 11:09:49 +0100
Message-ID: <CACRpkdYxoH3GZedt-7cmx-Kp4MKXf9qhpAVn116oTDi_Sfm9fA@mail.gmail.com>
Subject: Re: [v3] watchdog: mtx-1: Convert to use GPIO descriptor
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Dec 22, 2018 at 12:24 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 12/21/18 2:22 AM, Linus Walleij wrote:
> > On Sat, Dec 15, 2018 at 5:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >> On Tue, Dec 11, 2018 at 01:04:12PM +0100, Linus Walleij wrote:
> >
> >>> This converts the MTX-1 driver to grab a GPIO descriptor
> >>> associated with the device instead of using a resource with
> >>> a global GPIO number.
> >>>
> >>> The board using this driver appears to be out-of-tree
> >>> (OpenWRT), but the users can be easily augmented by adding a
> >>> machine descriptor table before registering the device.
> >>>
> >> Is that still accurate, given the discussion and mips specific changes ?
> >>
> >>> Cc: Florian Fainelli <f.fainelli@gmail.com>
> >>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >>
> >> We'll need an Acked-by: from a mips maintainer to land this.
> >
> > Florian is a MIPS (subarch) maintainer, tell me if you want
> > to resend this with the collected reviewed-by and also
> > include the toplevel MIPS maintainers.
> >
> Should be ok on that side then. What about my question above ?

Ah right, I will fix it up and resend with the ACKs.

Yours,
Linus Walleij
