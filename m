Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49694 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbbIARxX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Sep 2015 13:53:23 -0400
Date: Tue, 1 Sep 2015 10:53:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Justin Chen <justinpopo6@gmail.com>
Cc: linux-kernel@vger.kernel.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] watchdog_dev: Use device tree alias for naming watchdogs
Message-ID: <20150901175319.GA30006@roeck-us.net>
References: <1440799086-14683-1-git-send-email-justinpopo6@gmail.com>
 <55E1811A.9000709@roeck-us.net>
 <CAJx26kVz2Sem6PSBgKnQoa+1zo1frsmhx8a7eJBC8v+WY=gpvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJx26kVz2Sem6PSBgKnQoa+1zo1frsmhx8a7eJBC8v+WY=gpvA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Sep 01, 2015 at 10:20:36AM -0700, Justin Chen wrote:
> On Sat, Aug 29, 2015 at 2:53 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 08/28/2015 02:58 PM, Justin Chen wrote:
> >>
> >> Currently there is no way to easily differentiate multiple
> >> watchdog devices. The watchdogs are named by the order they
> >> are probed.
> >> 1st probed watchdog: /dev/watchdog0
> >> 2nd probed watchdog: /dev/watchdog1
> >> ...
> >>
> >> This change uses the alias of the watchdog device node for
> >> the name of the watchdog.
> >> aliases {
> >>         watchdog0 = "/...../...."
> >>         watchdog3 = "/..../....."
> >>         watchdog2 = "/..../....."
> >>         ...
> >> }
> >>
> >> This will translate to...
> >> /dev/watchdog0
> >> /dev/watchdog3
> >> /dev/watchdog2
> >>
> >> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> >
> >
> > Interesting idea. Checking through other subsystems, many others do the
> > same,
> > so it makes sense to use that mechanism.
> >
> > However, the id assignment should be in the calling code, in
> > __watchdog_register_device,
> > to avoid that another id, possibly conflicting, is assigned through the
> ida
> > mechanism.
> >
> > This is a bit more complicated than it looks like to ensure correct id
> > assignment.
> > Have a look into the i2c code to see how it is handled. Essentially we
> must
> > pass
> > the requested number to ida_simple_get().
> >
> > Thanks,
> > Guenter
> 
> Ok that makes sense. I will put a wrapper function around ida_simple_get()
> that will request a specific number, if that fails then do a normal request.
> Something like this...
> 
> ret = of_alias_get_id(....)
> 
> id = ida_simple_get(&watchdog_ida, ret, ret, GFP_KERNEL);
> 
				ret, ret + 1

but something like
	ret =  of_alias_get_id(...);
	if (ret >= 0)
		id = ida_simple_get(&watchdog_ida, ret, ret + 1, GFP_KERNEL);
	else
		id = ida_simple_get(&watchdog_ida, 0, MAX_DOGS, GFP_KERNEL);
	if (id < 0)
		return id;

would be better. Passing 'ret' directly would not work, because
ida_simple_get() expects an unsigned range as parameters, and
of_alias_get_id() can return a negative error code.

Thanks,
Guenter
