Return-path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 13 Mar 2017 15:17:39 +0100
From: Johan Hovold <johan@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Johan Hovold <johan@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] watchdog: pcwd_usb: fix NULL-deref at probe
Message-ID: <20170313141739.GS4211@localhost>
References: <20170313124945.28923-1-johan@kernel.org>
 <a0515a2d-d219-d32d-b906-564bb789ce09@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0515a2d-d219-d32d-b906-564bb789ce09@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

[ Adding linux-usb which I forgot to CC for this one ]

On Mon, Mar 13, 2017 at 06:42:45AM -0700, Guenter Roeck wrote:
> On 03/13/2017 05:49 AM, Johan Hovold wrote:
> > Make sure to check the number of endpoints to avoid dereferencing a
> > NULL-pointer should a malicious device lack endpoints.
> >
> 
> Is this theory or was it actually observed ?

This was found through inspection, but creating a USB device to crash a
host with this driver enabled is easily done.

> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable <stable@vger.kernel.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/watchdog/pcwd_usb.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> > index 99ebf6ea3de6..5615f4013924 100644
> > --- a/drivers/watchdog/pcwd_usb.c
> > +++ b/drivers/watchdog/pcwd_usb.c
> > @@ -630,6 +630,9 @@ static int usb_pcwd_probe(struct usb_interface *interface,
> >  		return -ENODEV;
> >  	}
> >
> > +	if (iface_desc->desc.bNumEndpoints < 1)
> > +		return -ENODEV;
> > +
> >  	/* check out the endpoint: it has to be Interrupt & IN */
> >  	endpoint = &iface_desc->endpoint[0].desc;
> >
> >

Johan
