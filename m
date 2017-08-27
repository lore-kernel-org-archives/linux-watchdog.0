Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34338 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdH0RNa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 27 Aug 2017 13:13:30 -0400
Date: Sun, 27 Aug 2017 10:13:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 09/11] watchdog: ftwdt010/aspeed: Merge Aspeed into
 FTWDT010
Message-ID: <20170827171328.GH22819@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-10-linus.walleij@linaro.org>
 <20170814150434.GH14491@roeck-us.net>
 <CACRpkdYVHXqX-f6hvP4Qhi4+vawyiqdzqRamH_JbbHec2cEf9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYVHXqX-f6hvP4Qhi4+vawyiqdzqRamH_JbbHec2cEf9Q@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 24, 2017 at 10:41:56PM +0200, Linus Walleij wrote:
> On Mon, Aug 14, 2017 at 5:04 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Sat, Aug 12, 2017 at 08:43:16PM +0200, Linus Walleij wrote:
> >> These two drivers is for the almost the same hardware,
> >> the only differences are:
> >> - The Aspeed IP block has been hacked to use a different
> >>   magic value.
> >> - The Aspeed has hard-wired 1MHz to the EXTCLK and
> >>   apparently even disabled the use of PCLK for clocking
> >>   the block on AST2500.
> >>
> > Confused. I thought the ast2500 is an EC. Am I missing something ?
> 
> Sorry I'm confused too now... What is EC?
> Can you spell out that acronym, I never heard
> it, or forgot it.

Embedded Controller

> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
