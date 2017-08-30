Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:63278 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751302AbdH3NWh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 30 Aug 2017 09:22:37 -0400
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] ARM: dts: r7s72100: Add reset handler
Date: Wed, 30 Aug 2017 13:22:32 +0000
Message-ID: <SG2PR06MB1165B8B815327A6768AE681A8A9C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
 <20170216172320.10897-4-chris.brandt@renesas.com>
 <CAMuHMdVMBo9fNMTqz_XdU27FF5TX98r-OE5pJ5atJ1s4XLxcTw@mail.gmail.com>
 <20170830082940.GR10398@verge.net.au>
In-Reply-To: <20170830082940.GR10398@verge.net.au>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Simon,

On Wednesday, August 30, 2017, Simon Horman wrote:
> On Fri, Feb 17, 2017 at 11:29:25AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Feb 16, 2017 at 6:23 PM, Chris Brandt <chris.brandt@renesas.com=
>
> wrote:
> > > For the RZ/A1, the only way to do a reset is to overflow the WDT.
> > >
> > > Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Hi Chris,
>=20
> while going through old patches I noticed that I seem to have missed this
> one. It looks like it needs a rebase. If it is still applicable could you
> please consider doing so and reposting.


It's in -next already:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
arch/arm/boot/dts/r7s72100.dtsi?h=3Dnext-20170829&id=3D69ed50de582eff6307fd=
3fa050fdc505731f0a2d

Doesn't that mean it's queued up for 4.14?

Or, somehow it didn't make it into the pull request for Arnd's tree?


Chris
