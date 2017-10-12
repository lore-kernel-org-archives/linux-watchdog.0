Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:53624 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdJLHfo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 12 Oct 2017 03:35:44 -0400
Received: by mail-it0-f49.google.com with SMTP id n195so5818298itg.2
        for <linux-watchdog@vger.kernel.org>; Thu, 12 Oct 2017 00:35:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACPK8XeQDdisecoHo7+_7LQNxYWh7yDj99O=NxWSoHyuk7LRxg@mail.gmail.com>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-12-linus.walleij@linaro.org> <CACRpkdbJhTmSZDudJCb_8nOfk6802Z8Op2+gjY9vdDT9Cg+6eQ@mail.gmail.com>
 <CACPK8XeQDdisecoHo7+_7LQNxYWh7yDj99O=NxWSoHyuk7LRxg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Oct 2017 09:35:42 +0200
Message-ID: <CACRpkdazjg3C7Dt2KbTuYbMnmkeUXT7KyE=AZWSko4=ZWSb2_A@mail.gmail.com>
Subject: Re: [PATCH 11/11] ARM: dts: Add PCLK to the Aspeed watchdogs
To: Joel Stanley <joel@jms.id.au>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 12, 2017 at 5:37 AM, Joel Stanley <joel@jms.id.au> wrote:
> On Wed, Oct 11, 2017 at 4:09 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> Joel could you merge this through the Aspeed tree? I think
>> the compatible string is completely uncontroversial
>> (binding ACKed) to add and all should just work fine so we
>> can slap in "EXTCLK" later as well.
>
> How do the clock-names work? I have been writing the aspeed clk driver
> and updating the bindings without clock names, and instead using a
> identifier in phandle to reference which clock the device wants.
>
> eg:
>
>  clocks = <&syscon 10>;

This works fine as long as there is just one clock.

clocks = <&syscon 10>, <&syscon 11>, <&syscon 12>;

becomes a problem, right?

clk_get() has this signature:
struct clk *clk_get(struct device *dev, const char *id);

So clk_get(dev, NULL); will return <&syscon 10>;

How to get the rest?

clocks = <&syscon 10>, <&syscon 11>, <&syscon 12>;
clock-names = "FOO", "BAR", "BAZ";

clk_get(dev, "BAR");

gets the second clock.

Yours,
Linus Walleij
