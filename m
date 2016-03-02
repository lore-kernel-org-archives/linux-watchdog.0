Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34643 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986AbcCBTjw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Mar 2016 14:39:52 -0500
Date: Wed, 2 Mar 2016 11:39:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Doug Anderson <dianders@chromium.org>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v8 06/10] watchdog: dw_wdt: Convert to use watchdog
 infrastructure
Message-ID: <20160302193948.GA3006@roeck-us.net>
References: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
 <1456693943-6876-7-git-send-email-linux@roeck-us.net>
 <CAD=FV=U=FC7jA5=0nP+=wWOxiiDLsCop0+8=o=+j7FvPa2ZvgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=U=FC7jA5=0nP+=wWOxiiDLsCop0+8=o=+j7FvPa2ZvgA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Mar 01, 2016 at 02:59:06PM -0800, Doug Anderson wrote:
> Guenter,
> 
> On Sun, Feb 28, 2016 at 1:12 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > Convert driver to use watchdog infrastructure. This includes
> > infrastructure support to handle watchdog keepalive if the watchdog
> > is running while the watchdog device is closed.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >
> > ---
> > v8: max_hw_timeout_ms -> max_hw_heartbeat_ms
> >     Rebased to v4.5-rc5
> > v7: Set max_hw_timeout_ms
> >     Rebased to v4.5-rc1
> > v6: Added patch
> > ---
> >  drivers/watchdog/Kconfig  |   1 +
> >  drivers/watchdog/dw_wdt.c | 323 +++++++++++++++++-----------------------------
> >  2 files changed, 117 insertions(+), 207 deletions(-)
> 
> I re-ran the same set of tests I ran against v7.  They all still pass.
> 
> Tested-by: Douglas Anderson <dianders@chromium.org>

Thanks a lot!

Guenter
