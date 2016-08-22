Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33183 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbcHVIq0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 22 Aug 2016 04:46:26 -0400
MIME-Version: 1.0
In-Reply-To: <20160819191750.GV361@codeaurora.org>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
 <1471541667-30689-4-git-send-email-geert@linux-m68k.org> <20160819191750.GV361@codeaurora.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Aug 2016 10:46:24 +0200
Message-ID: <CAMuHMdVjd5iJL8AJBb0aVOEkcgJ-m-K19pjD-tJL=GLhPVm_Pg@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: TXx9: Convert to Common Clock Framework
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Stephen,

On Fri, Aug 19, 2016 at 9:17 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 08/18, Geert Uytterhoeven wrote:
>> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
>> index ada92db92f87d91a..2fdbcf91b2cc472c 100644
>> --- a/arch/mips/txx9/generic/setup.c
>> +++ b/arch/mips/txx9/generic/setup.c
>> @@ -560,8 +527,39 @@ void __init plat_time_init(void)
>>       txx9_board_vec->time_init();
>>  }
>>
>> +static void txx9_clk_init(void)
>> +{
>> +     struct clk *clk;
>> +     int error;
>> +
>> +     clk = clk_register_fixed_rate(NULL, "gbus", NULL, 0, txx9_gbus_clock);
>
> Can we use the clk_hw_*() based variants instead please?

Yes we can.

BTW, is it intentional that clk_hw_register_clkdev() doesn't detect errors
from a previous registration call, like clk_register_clkdev() does?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
