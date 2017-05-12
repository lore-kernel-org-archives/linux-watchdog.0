Return-path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
Date: Fri, 12 May 2017 12:36:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: Johan Hovold <johan@kernel.org>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: pcwd_usb: fix NULL-deref at probe
Message-ID: <20170512103627.GP30445@localhost>
References: <20170313124945.28923-1-johan@kernel.org>
 <20170313171633.GB16813@roeck-us.net>
 <20170403083635.GD25742@localhost>
 <b48feef4-dac7-13a4-a70b-33d7c4614cba@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b48feef4-dac7-13a4-a70b-33d7c4614cba@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter and Wim,

On Mon, Apr 03, 2017 at 07:05:46AM -0700, Guenter Roeck wrote:
> On 04/03/2017 01:36 AM, Johan Hovold wrote:
> > On Mon, Mar 13, 2017 at 10:16:33AM -0700, Guenter Roeck wrote:
> >> On Mon, Mar 13, 2017 at 01:49:45PM +0100, Johan Hovold wrote:
> >>> Make sure to check the number of endpoints to avoid dereferencing a
> >>> NULL-pointer should a malicious device lack endpoints.
> >>>
> >>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >>> Cc: stable <stable@vger.kernel.org>
> >>> Signed-off-by: Johan Hovold <johan@kernel.org>
> >>
> >> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >
> > Any progress on this one? I noticed you merged it to both the fixes and
> > next branches in your staging tree, Guenter (but it does not show up in
> > linux-next). Will you be sending it on to Linus?

> my watchdog staging trees are inofficial and not in linux-next.
> Wim is working on setting up a new server which will provide the
> official staging tree.
> 
> I asked Wim to push the pending patches. I'll do it if he asks me.

I noticed Guenter's watchdog branch is now in next, but the patches for
4.12 are still not in mainline. Have you guys decided who will be
sending them on to Linus this cycle?

Thanks,
Johan
