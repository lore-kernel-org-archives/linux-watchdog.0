Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33655 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdHNBZD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 13 Aug 2017 21:25:03 -0400
Received: by mail-lf0-f43.google.com with SMTP id d17so34076461lfe.0
        for <linux-watchdog@vger.kernel.org>; Sun, 13 Aug 2017 18:25:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170812184318.10144-1-linus.walleij@linaro.org>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 14 Aug 2017 10:54:41 +0930
Message-ID: <CACPK8XetQJ_=CD4TPOmyigQZv2pRankWYew31Yf_ep4fai6X-g@mail.gmail.com>
Subject: Re: [PATCH 00/11] watchdog: Consolidate FTWDT010 derivatives
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org,
        Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

On Sun, Aug 13, 2017 at 4:13 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> The MOXA ART and Aspeed watchdogs are clearly based on the
> Faraday Technology FTWDT010 IP block.

They have a similar register interface, but I'm told they are not the same IP.

We've got some patches on the list that add some extra registers to
the driver for the ast2500. If we decide to merge the drivers, that
support will need to be included.

Andrew was working on that, I'll let him follow up on the details.

> This series consolidates the drivers into one by extending
> the Gemini driver to be as generic as possible, renaming it
> to ftwdt010_wdt and merging the two other drivers into it.
>
> As similar approach was used for the FTTMR010 driver in the
> past.
>
> The series ends with two patches that will be applied to
> the ARM SoC tree to fix up the PCLK annotations, but these
> are not needed to make the consolidation, patches 1-9 can
> be applied directly to the watchdog tree to perform the
> consolidation.

The clock isn't called PCLK in the Aspeed documentation (similarly for
the timer, but I was too slow to speak up in that case).

I'm trying to find some time to write a proper clock driver so it's
clear how the clocks are set out in the Aspeed.

Cheers,

Joel
