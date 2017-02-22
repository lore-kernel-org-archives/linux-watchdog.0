Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:58339 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754514AbdBVQET (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 22 Feb 2017 11:04:19 -0500
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] power: reset: Add Renesas reset driver
Date: Wed, 22 Feb 2017 16:04:06 +0000
Message-ID: <SG2PR06MB1165F6C78BC5F4ACA32057718A500@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
 <20170216172320.10897-2-chris.brandt@renesas.com>
 <20170216182644.GA17814@roeck-us.net>
 <PS1PR06MB1162A4C12D144C321379E3028A5A0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <20170216222014.GA29672@roeck-us.net>
 <PS1PR06MB11622077DE4673C1879C05278A5D0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <55cf087f-aa70-3660-1186-af9b9b20376d@roeck-us.net>
 <SG2PR06MB11650D5EE485C0F44A77E0EA8A500@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20170222152815.GA23780@roeck-us.net>
In-Reply-To: <20170222152815.GA23780@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Guenter,

On Wednesday, February 22, 2017, Guenter Roeck wrote:
> > Looking through the drivers in the watchdog directly, I see default
> > timeouts of 20, 30, 60, and 120 seconds.
> >
> 30 and 60 are pretty common for default timeouts, though I personally
> think they are a bit long. If you want direct HW support, a maximum of 12=
0
> seconds should be sufficient though not really necessary anymore since th=
e
> core supports virtual timeouts. A maximum of at least 30 seconds would be
> needed if the watchdog is supposed to run at boot time (ie if it is
> enabled by ROMMON/BIOS and kept running by the kernel).


Thank you!
Good point about the boot time.

Chris

