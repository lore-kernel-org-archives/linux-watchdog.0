Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43425 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754641AbdBVQdo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 22 Feb 2017 11:33:44 -0500
Date: Wed, 22 Feb 2017 07:28:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
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
Subject: Re: [PATCH v2 1/3] power: reset: Add Renesas reset driver
Message-ID: <20170222152815.GA23780@roeck-us.net>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
 <20170216172320.10897-2-chris.brandt@renesas.com>
 <20170216182644.GA17814@roeck-us.net>
 <PS1PR06MB1162A4C12D144C321379E3028A5A0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <20170216222014.GA29672@roeck-us.net>
 <PS1PR06MB11622077DE4673C1879C05278A5D0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <55cf087f-aa70-3660-1186-af9b9b20376d@roeck-us.net>
 <SG2PR06MB11650D5EE485C0F44A77E0EA8A500@SG2PR06MB1165.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR06MB11650D5EE485C0F44A77E0EA8A500@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 22, 2017 at 01:35:12PM +0000, Chris Brandt wrote:
> Hello Geert and Guenter,
> 
> On Thursday, February 16, 2017, Guenter Roeck wrote:
> > FWIW, the watchdog subsystem should support that easily, even with 125 ms
> > hardware timeout. We added that capability for that very purpose. That
> > would only fail if the system is stuck with interrupts disabled for more
> > than 125 ms, which seems unlikely. I think the gpio watchdog on some
> > systems has a similar low hardware timeout.
> 
> 
> While I'm going to try that for the RZ/A1, I have a question for you guys
> (or anyone else that has an opinion about end applications)
> 
> 
> If I were going to make a request to the chip designers to make the timeout longer
> for the next RZ/A chip, what would be a good max timeout for common Linux applications?
> 
> Looking through the drivers in the watchdog directly, I see default timeouts of 20,
> 30, 60, and 120 seconds.
> 
30 and 60 are pretty common for default timeouts, though I personally think
they are a bit long. If you want direct HW support, a maximum of 120 seconds
should be sufficient though not really necessary anymore since the core
supports virtual timeouts. A maximum of at least 30 seconds would be needed
if the watchdog is supposed to run at boot time (ie if it is enabled by
ROMMON/BIOS and kept running by the kernel).

Hope this helps,
Guenter
