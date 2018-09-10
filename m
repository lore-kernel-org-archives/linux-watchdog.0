Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:35866 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726603AbeIJWby (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Sep 2018 18:31:54 -0400
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
Date: Mon, 10 Sep 2018 17:36:39 +0000
Message-ID:
 <TY1PR01MB1562909374EEAA97DFAC173C8A050@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180907012243.86603-1-chris.brandt@renesas.com>
 <20180907012243.86603-2-chris.brandt@renesas.com>
 <314e2981-8fbd-43ed-2f2d-c080a2961055@roeck-us.net>
 <TY1PR01MB156229CF6EA73FD0B083B0A18A050@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <20180910161300.GA19858@roeck-us.net>
In-Reply-To: <20180910161300.GA19858@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Message-ID: <20180910173639.OtYWc66OJg2VVhZwzxRYlpw73UmR1guTRWmw589J5vk@z>

On Monday, September 10, 2018 1, Guenter Roeck wrote:
> > #2. If the CKS is only 4-bits, the max HW timeout is 32 seconds. (so
> > 'timeout' can never be more that a u8).
> >
> That is not the point. The point is that there is no need to keep two
> 'timeout' variables.

But there was a reason.

The reason was that the upper layer would call the .ping() function=20
without calling .start() again.

Meaning it would change 'timeout' in the structure, but not explicitly=20
tell the driver.

That why I had to keep track of my own timeout (what the HW was actually
set to).

Every time the upper layer calls .ping(), I have to see if the timeout=20
field still matches.


> > The number "4194304" is exactly how it is documented in the hardware
> > manual, that is why I'm using it that way. Yes, 0x400000 makes more
> > sense, but I like matching the device documenting as much as possible t=
o
> > help the next person that comes along and has to debug this code.
> >
> Use at least a define.

OK.


> > Because when I was doing all my testing, I found cases where '.ping' wa=
s
> > called from the upper layer without '.start' being called first. So, I
> > changed the code as you see it now. This guaranteed I would also get th=
e
> > timeout the user was requesting.
> >
> That would only happen if the watchdog is considered to be running.
> Also, we are talking about the set_timeout function which is the one whic=
h
> should set the timeout and update the HW if needed, ie if the watchdog is
> already running.

This driver doesn't have .set_timeout

static const struct watchdog_ops rza_wdt_ops =3D {
	.owner =3D THIS_MODULE,
	.start =3D rza_wdt_start,
	.stop =3D rza_wdt_stop,
	.ping =3D rza_wdt_ping,
	.restart =3D rza_wdt_restart,
};


If you really don't like checking in .ping, I can add a set_timeout=20
function and remove the local priv->timeout.

Chris
