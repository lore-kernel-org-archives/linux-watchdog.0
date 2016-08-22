Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60696 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755829AbcHVRhZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 22 Aug 2016 13:37:25 -0400
Date: Mon, 22 Aug 2016 10:37:02 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 3/3] MIPS: TXx9: Convert to Common Clock Framework
Message-ID: <20160822173702.GM6502@codeaurora.org>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
 <1471541667-30689-4-git-send-email-geert@linux-m68k.org>
 <20160819191750.GV361@codeaurora.org>
 <CAMuHMdVjd5iJL8AJBb0aVOEkcgJ-m-K19pjD-tJL=GLhPVm_Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVjd5iJL8AJBb0aVOEkcgJ-m-K19pjD-tJL=GLhPVm_Pg@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/22, Geert Uytterhoeven wrote:
> Hi Stephen,
> 
> On Fri, Aug 19, 2016 at 9:17 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 08/18, Geert Uytterhoeven wrote:
> >> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
> >> index ada92db92f87d91a..2fdbcf91b2cc472c 100644
> >> --- a/arch/mips/txx9/generic/setup.c
> >> +++ b/arch/mips/txx9/generic/setup.c
> >> @@ -560,8 +527,39 @@ void __init plat_time_init(void)
> >>       txx9_board_vec->time_init();
> >>  }
> >>
> >> +static void txx9_clk_init(void)
> >> +{
> >> +     struct clk *clk;
> >> +     int error;
> >> +
> >> +     clk = clk_register_fixed_rate(NULL, "gbus", NULL, 0, txx9_gbus_clock);
> >
> > Can we use the clk_hw_*() based variants instead please?
> 
> Yes we can.
> 
> BTW, is it intentional that clk_hw_register_clkdev() doesn't detect errors
> from a previous registration call, like clk_register_clkdev() does?
> 

Slightly intentional, because the assumption is providers already
have a clk_hw structure that they've created themselves when they
register a clkdev, whereas a struct clk is more likely to be an
error pointer because of clk_get(), etc. But I suppose we can add
the error check to ease registration in cases where providers are
using the basic types.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
