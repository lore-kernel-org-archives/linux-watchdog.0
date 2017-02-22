Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:38256 "EHLO
        relmlie4.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932278AbdBVNfj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 22 Feb 2017 08:35:39 -0500
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC: Wim Van Sebroeck <wim@iguana.be>,
        Sebastian Reichel <sre@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Simon Horman" <horms@verge.net.au>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] power: reset: Add Renesas reset driver
Date: Wed, 22 Feb 2017 13:35:12 +0000
Message-ID: <SG2PR06MB11650D5EE485C0F44A77E0EA8A500@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
 <20170216172320.10897-2-chris.brandt@renesas.com>
 <20170216182644.GA17814@roeck-us.net>
 <PS1PR06MB1162A4C12D144C321379E3028A5A0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <20170216222014.GA29672@roeck-us.net>
 <PS1PR06MB11622077DE4673C1879C05278A5D0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <55cf087f-aa70-3660-1186-af9b9b20376d@roeck-us.net>
In-Reply-To: <55cf087f-aa70-3660-1186-af9b9b20376d@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Geert and Guenter,

On Thursday, February 16, 2017, Guenter Roeck wrote:
> FWIW, the watchdog subsystem should support that easily, even with 125 ms
> hardware timeout. We added that capability for that very purpose. That
> would only fail if the system is stuck with interrupts disabled for more
> than 125 ms, which seems unlikely. I think the gpio watchdog on some
> systems has a similar low hardware timeout.


While I'm going to try that for the RZ/A1, I have a question for you guys
(or anyone else that has an opinion about end applications)


If I were going to make a request to the chip designers to make the timeout=
 longer
for the next RZ/A chip, what would be a good max timeout for common Linux a=
pplications?

Looking through the drivers in the watchdog directly, I see default timeout=
s of 20,
30, 60, and 120 seconds.

Thank you,
Chris

