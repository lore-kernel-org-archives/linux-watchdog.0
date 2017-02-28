Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38436 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdCABF0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Feb 2017 20:05:26 -0500
Date: Tue, 28 Feb 2017 15:16:06 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] watchdog: wm831x watchdog really needs mfd
Message-ID: <20170228231606.GA9885@roeck-us.net>
References: <20170228210123.3404816-1-arnd@arndb.de>
 <20170228210123.3404816-4-arnd@arndb.de>
 <20170228213614.GB6651@roeck-us.net>
 <CAK8P3a30JxYh6XkfFg4QcNe_79SErsyuDyviFQf1b6=4G2_uxw@mail.gmail.com>
 <CAK8P3a3-JwLcQCgfBse0qzHtJcwmOZ9DqLs4B0DjFM45HEYcgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3-JwLcQCgfBse0qzHtJcwmOZ9DqLs4B0DjFM45HEYcgQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 28, 2017 at 10:48:27PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 28, 2017 at 10:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Feb 28, 2017 at 10:36 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> >>>  config WM831X_WATCHDOG
> >>>       tristate "WM831x watchdog"
> >>> -     depends on MFD_WM831X || COMPILE_TEST
> >>> +     depends on MFD_WM831X
> >>
> >> I prefer the fix proposed by Randy:
> >>
> >> -       depends on MFD_WM831X || COMPILE_TEST
> >> +       depends on MFD_WM831X || (MFD_WM831X=y && COMPILE_TEST)
> >>
> >
> > Agreed, that's better.
> 
> Actually I misread. They should be completely equivalent, the part after
> the || has no effect here.
> 
Yes, I figured that out later as well.

Guenter
