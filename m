Return-path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 3 Apr 2017 10:36:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Johan Hovold <johan@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: pcwd_usb: fix NULL-deref at probe
Message-ID: <20170403083635.GD25742@localhost>
References: <20170313124945.28923-1-johan@kernel.org>
 <20170313171633.GB16813@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313171633.GB16813@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Mar 13, 2017 at 10:16:33AM -0700, Guenter Roeck wrote:
> On Mon, Mar 13, 2017 at 01:49:45PM +0100, Johan Hovold wrote:
> > Make sure to check the number of endpoints to avoid dereferencing a
> > NULL-pointer should a malicious device lack endpoints.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable <stable@vger.kernel.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Any progress on this one? I noticed you merged it to both the fixes and
next branches in your staging tree, Guenter (but it does not show up in
linux-next). Will you be sending it on to Linus?

Thanks,
Johan
