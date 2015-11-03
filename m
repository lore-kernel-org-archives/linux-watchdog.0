Return-path: <vivien.didelot@savoirfairelinux.com>
Date: Mon, 2 Nov 2015 21:51:45 -0500
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	kernel@savoirfairelinux.com
Subject: Re: [RFC PATCH 01/13] watchdog: core: add restart handler support
Message-ID: <20151103025145.GA29120@ketchup.lan>
References: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446514586-31455-2-git-send-email-damien.riegel@savoirfairelinux.com>
 <56381B03.6030201@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56381B03.6030201@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On Nov. Monday 02 (45) 06:25 PM, Guenter Roeck wrote:
> On 11/02/2015 05:36 PM, Damien Riegel wrote:
> >Many watchdog drivers implement the same code to register a restart
> >handler. This patch provides a generic way to set such a function.
> >
> >The patch adds a new restart watchdog operation. If a restart priority
> >greater than 0 is needed, the driver can call
> >watchdog_set_restart_priority to set it.
> >
> >Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> >Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> 
> Makes sense, and good idea. Unless the patch was written by Vivien,
> the second tag should probably be a Reviewed-by: or Acked-by:, though.

We wrote that together, but Damien did most of the work. So I think
Reviewed-by: for me will indeed be most appropriate here.

Also is it OK to include your Reviewed-by: tag in the v1 (given we add
your comments) or not?

Thanks!
-v
