Return-path: <clemens.gruber@pqgruber.com>
Date: Thu, 21 Apr 2016 15:44:45 +0200
From: Clemens Gruber <clemens.gruber@pqgruber.com>
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org
Subject: Re: watchdog: deadlock warning with imx2_wdt driver and systemd
Message-ID: <20160421134444.GA1515@archie.localdomain>
References: <20160417154107.GA6762@archie.localdomain>
 <5718574F.5090809@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5718574F.5090809@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Apr 20, 2016 at 09:30:07PM -0700, Guenter Roeck wrote:
> 
> Hi Clemens,
> 
> fix is to drop the call to cancel_delayed_work_sync() from watchdog_release().
> Turns out the call is not necessary.
> 
> I'll send a proper patch in the next couple of days.
> 
> Guenter
> 

Hi Guenter,

thank you for finding the cause of the problem! Removing the
cancel_delayed_work_sync call from watchdog_release in watchdog_dev.c
did fix the lockdep warning on all my boards [without having to revert
commit 11d7aba9ce (watchdog: imx2: Convert to use infrastructure
triggered keepalives) first].

Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Cheers,
Clemens
