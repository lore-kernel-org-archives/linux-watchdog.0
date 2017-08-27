Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33957 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdH0ROj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 27 Aug 2017 13:14:39 -0400
Date: Sun, 27 Aug 2017 10:14:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 02/11] watchdog: gemini/ftwdt010: rename driver and
 symbols
Message-ID: <20170827171437.GI22819@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-3-linus.walleij@linaro.org>
 <20170814150105.GG14491@roeck-us.net>
 <CACRpkdb_UkQdg0H-WA+9tbW5_9UX2-3Ezoyww=HXuUGi=8aH8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb_UkQdg0H-WA+9tbW5_9UX2-3Ezoyww=HXuUGi=8aH8A@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 24, 2017 at 10:45:27PM +0200, Linus Walleij wrote:
> On Mon, Aug 14, 2017 at 5:01 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Sat, Aug 12, 2017 at 08:43:09PM +0200, Linus Walleij wrote:
> 
> >> -config GEMINI_WATCHDOG
> >> -     tristate "Gemini watchdog"
> >> -     depends on ARCH_GEMINI
> >> +config FTWDT010_WATCHDOG
> >> +     tristate "Faraday Technology FTWDT010 watchdog"
> >> +     depends on ARM || COMPILE_TEST
> >
> > Did you test this ? I am kind of wary about COMPILE_TEST in watchdog drivers.
> > I tried to enable that a while ago, and we had to spend a couple of releases
> > fixing the fallout (even though I had tried to make sure that everything
> > builds).
> 
> Incidentally, yes!
> 
Ok. Note that I though that too, only 0day didn't pick up all corner cases.

Guenter

> I push my tree to kernelorg where the zeroday autobuilders pick it up
> and compile all kind of archs.
> 
> I'm pushing the updated patches too.
> 
> The big culprit used to be um linux, since it doesn't do MMIO.
> But I think that has been solved recently because I don't see
> complaints about it anymore.
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
