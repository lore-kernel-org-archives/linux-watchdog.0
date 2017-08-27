Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45086 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdH0RMy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 27 Aug 2017 13:12:54 -0400
Date: Sun, 27 Aug 2017 10:12:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 04/11] watchdog: ftwdt010: Add clock support
Message-ID: <20170827171252.GG22819@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-5-linus.walleij@linaro.org>
 <20170814160536.GC7025@roeck-us.net>
 <CACRpkdYcEbWkHdgxA-3=6JiZTxecQcTYgqx4xDH23=NxF8zg_Q@mail.gmail.com>
 <20170825232846.GR21656@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825232846.GR21656@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Aug 25, 2017 at 04:28:46PM -0700, Stephen Boyd wrote:
> On 08/24, Linus Walleij wrote:
> > On Mon, Aug 14, 2017 at 6:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> > > Side note: Maybe we _should_ introduce devm_watchdog_clk_prepare_enable()
> > > since this problem affects several watchdog drivers.
> > 
> > Hmmmmmmmmm a special watchdog primitive may be apropriate.
> > Dunno what the clk maintainers think?
> > 
> > Stephen/Mike: do you like that or would you rather see a primitive
> > inside the clock subsystem for this?
> > 
> 
> devm_clk_prepare_enable() was already proposed and then the
> thread went quiet. Re-kickstart it?
> 

It was propsed several times, and each time it went nowhere.
I got the impression that it won't be accepted, presumably because
it can be misused. I have all but given up on it, and I have it on
my task list to replace pretty much each pair of clk_prepare_enable() /
clk_prepare_disable() calls in the watchdog subsystem with
devm_add_action(). Not that I like that "solution", but life
isn't perfect.

Guenter

> I'd still prefer we just disable clks on clk_put(), but Russell
> said we needed to fix all non-common clk implementations of the
> clk API to do that and then I forgot about the topic (so
> anti-climatic). I'm pretty much OK with us merging the temporary
> solution. We can churn again later and remove it all once we
> convert everything into one CCF.
> 
> I'd prefer we also change common clk framework to actually do the
> disable on put though so we flush out any issues early. If the
> two things are packaged together I would be ultra happy. It's not
> like people are going to convert to CCF just so they can get clk
> disable on clk_put() as a feature, but at least we can have it as
> a feature.
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
