Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46195 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752513AbdCMRPM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 13 Mar 2017 13:15:12 -0400
Date: Mon, 13 Mar 2017 10:15:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Johan Hovold <johan@kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] watchdog: pcwd_usb: fix NULL-deref at probe
Message-ID: <20170313171504.GA16813@roeck-us.net>
References: <20170313124945.28923-1-johan@kernel.org>
 <a0515a2d-d219-d32d-b906-564bb789ce09@roeck-us.net>
 <20170313141739.GS4211@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313141739.GS4211@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 13, 2017 at 03:17:39PM +0100, Johan Hovold wrote:
> [ Adding linux-usb which I forgot to CC for this one ]
> 
> On Mon, Mar 13, 2017 at 06:42:45AM -0700, Guenter Roeck wrote:
> > On 03/13/2017 05:49 AM, Johan Hovold wrote:
> > > Make sure to check the number of endpoints to avoid dereferencing a
> > > NULL-pointer should a malicious device lack endpoints.
> > >
> > 
> > Is this theory or was it actually observed ?
> 
> This was found through inspection, but creating a USB device to crash a
> host with this driver enabled is easily done.
> 
Ok, makes sense. I see other drivers doing a similar check.

Guenter

> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Cc: stable <stable@vger.kernel.org>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > ---
> > >  drivers/watchdog/pcwd_usb.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> > > index 99ebf6ea3de6..5615f4013924 100644
> > > --- a/drivers/watchdog/pcwd_usb.c
> > > +++ b/drivers/watchdog/pcwd_usb.c
> > > @@ -630,6 +630,9 @@ static int usb_pcwd_probe(struct usb_interface *interface,
> > >  		return -ENODEV;
> > >  	}
> > >
> > > +	if (iface_desc->desc.bNumEndpoints < 1)
> > > +		return -ENODEV;
> > > +
> > >  	/* check out the endpoint: it has to be Interrupt & IN */
> > >  	endpoint = &iface_desc->endpoint[0].desc;
> > >
> > >
> 
> Johan
