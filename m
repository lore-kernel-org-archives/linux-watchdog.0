Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58613 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755728AbcIKOXf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 11 Sep 2016 10:23:35 -0400
Subject: Re: [PATCH v2 0/2] MIPS: TXx9: Common Clock Framework Conversion
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1473584398-12942-1-git-send-email-geert@linux-m68k.org>
Cc: linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c00b671b-8824-b054-5ee1-fbd02e993e1e@roeck-us.net>
Date: Sun, 11 Sep 2016 07:22:58 -0700
MIME-Version: 1.0
In-Reply-To: <1473584398-12942-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/11/2016 01:59 AM, Geert Uytterhoeven wrote:
> 	Hi Ralf, Nemoto-san, Wim,
>
> This patch series converts the Toshiba TXx9 platforms from their own
> custom minimal clock implementation to the Common Clock Framework.
>
>   - Patch 1 adds missing clock (un)prepare calls to the TXx9 watchdog
>     driver,
>   - Patch 2 replaces the custom clock implementation by a CCF-based one,
>     providing a minimal set of clocks.
>
> This has been tested with the watchdog on RBTX4927.
>
> Changes since v1:
>   - Dropped "spi: spi-txx9: Add missing clock (un)prepare calls for
>     CCF", which has been accepted in spi/for-next,
>   - Protect the TX4938_REV_PCODE() check by #ifdef CONFIG_CPU_TX49XX,
>   - Use new clk_hw-centric clock registration API,
>   - Add Reviewed-by.
>
> Dependencies:
>   - Patch 1 can be applied independently,
>   - Patch 2 depends on patch 1 and on "spi: spi-txx9: Add missing clock
>     (un)prepare calls for CCF" in spi/for-next,
>   - The error path in patch 2 depends on "clkdev: Detect errors in
>     clk_hw_register_clkdev() for mass registration", but this is less
>     critical.
>
> Wim: Can you please appply patch 1 directly, so we can get at least the
> hard dependencies in v4.9?
>

It is in my watchdog-next branch, and it has my Reviewed-by:, which
normally means that Wim will apply it.

Thanks,
Guenter

