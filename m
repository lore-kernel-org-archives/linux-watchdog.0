Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:42036 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934036AbeBLLis (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Feb 2018 06:38:48 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [RFC v4 13/26] watchdog: renesas_wdt: Add restart handler
Date: Mon, 12 Feb 2018 11:38:41 +0000
Message-ID: <TY1PR06MB08958A4A75A0F3BB2BF1D086C0F70@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-14-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180207230309.goxig2irkpxrw5el@katana>
 <TY1PR06MB089578618AA33335D90D16CEC0F70@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <20180212105456.3zejp3j7hfuzyc3c@ninjato>
In-Reply-To: <20180212105456.3zejp3j7hfuzyc3c@ninjato>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > > I used to have this simpler version (back then for the UP case):
> > >
> > > +rwdt_start(wdev);
> > > +rwdt_write(priv, 0xffff, RWTCNT);
> > > +return 0;
> > >
> > > It should still work probably...
> >
> > It should still work, but it would be slower, I would stick with the
> > version I have submitted if you don't mind.
>
> Actually, I do mind. Because of code duplication reasons. We have a fix
> in the works for rwdt_start() and it would be too easy to overlook the
> same fix will be needed for a restart.

The code is very similar indeed, but not exactly duplicated as it sets the =
registers in order to reset
the system as quickly as possible.
But since you have strong feelings about this I'll reuse this other version=
 for the next submission.

Thanks,
Fabrizio




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
