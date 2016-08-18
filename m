Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from newton.telenet-ops.be ([195.130.132.45]:40648 "EHLO
        newton.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbcHSEOI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 19 Aug 2016 00:14:08 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by newton.telenet-ops.be (Postfix) with ESMTP id 3sFYBq6qHnzMsw6Z
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Aug 2016 19:34:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] MIPS: TXx9: Common Clock Framework Conversion
Date: Thu, 18 Aug 2016 19:34:24 +0200
Message-Id: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

	Hi Ralf, Nemoto-san, Mark, Wim, G=C3=BCnter,

This patch series converts the Toshiba TXx9 platforms from their own
custom minimal clock implementation to the Common Clock Framework.

  - Patches 1 and 2 add missing clock (un)prepare calls to TXx9-specifi=
c
    drivers,
  - Patch 3 replaces the custom clock implementation by a CCF-based one=
,
    providing a minimal set of clocks.

Patches 1 and 2 can be applied independently.
Patch 3 has a hard dependency on patches 1 and 2.
I don't know how you prefer to handle this?

This has been tested with the watchdog on RBTX4927.

Thanks!

Geert Uytterhoeven (3):
  spi: spi-txx9: Add missing clock (un)prepare calls for CCF
  watchdog: txx9wdt: Add missing clock (un)prepare calls for CCF
  MIPS: TXx9: Convert to Common Clock Framework

 arch/mips/txx9/Kconfig         |  2 +-
 arch/mips/txx9/generic/setup.c | 68 ++++++++++++++++++++--------------=
--------
 drivers/spi/spi-txx9.c         |  6 ++--
 drivers/watchdog/txx9wdt.c     |  6 ++--
 4 files changed, 40 insertions(+), 42 deletions(-)

--=20
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
