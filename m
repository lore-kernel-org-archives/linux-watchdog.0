Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:28529 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726755AbeIJXLQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Sep 2018 19:11:16 -0400
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: RE: [PATCH v3 1/2] watchdog: rza_wdt: Support longer timeouts
Date: Mon, 10 Sep 2018 18:15:47 +0000
Message-ID:
 <TY1PR01MB1562CB6FD37074013E7892FD8A050@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180907012243.86603-1-chris.brandt@renesas.com>
 <20180907012243.86603-2-chris.brandt@renesas.com>
 <314e2981-8fbd-43ed-2f2d-c080a2961055@roeck-us.net>
 <TY1PR01MB156229CF6EA73FD0B083B0A18A050@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <20180910161300.GA19858@roeck-us.net>
 <TY1PR01MB1562909374EEAA97DFAC173C8A050@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <20180910175934.GA16216@roeck-us.net>
In-Reply-To: <20180910175934.GA16216@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Message-ID: <20180910181547.727NggWgE41BygyzRsASUWkoRIiYvalM694zndoq5ME@z>

On Monday, September 10, 2018, Guenter Roeck wrote:
> > If you really don't like checking in .ping, I can add a set_timeout
> > function and remove the local priv->timeout.
> >
>=20
> No, I do not like checking and setting the timeout in the ping function
> at all. That is what the set_timeout function is for, and I don't see
> a point in bypassing the infrastructure.

OK. I will add a set_timeout and resubmit.

Chris
