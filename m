Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44071 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbcCPJKm (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 16 Mar 2016 05:10:42 -0400
Message-ID: <1458119273.6570.4.camel@suse.com>
Subject: Re: [PATCH] watchdog: add driver for StreamLabs USB watchdog device
From: Oliver Neukum <oneukum@suse.com>
To: Alexey Klimov <klimov.linux@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, wim@iguana.be,
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	linux-watchdog@vger.kernel.org
Date: Wed, 16 Mar 2016 10:07:53 +0100
In-Reply-To: <CALW4P++Leg_TA6FkMY=RuhWJ4524KZN_gRzHEk+rUNc-TV7ctA@mail.gmail.com>
References: <1457576946-9313-1-git-send-email-klimov.linux@gmail.com>
	 <1457601829.2411.6.camel@suse.com>
	 <CALW4P++Leg_TA6FkMY=RuhWJ4524KZN_gRzHEk+rUNc-TV7ctA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 2016-03-16 at 00:57 +0000, Alexey Klimov wrote:
> Hi Oliver,
> 
> On Thu, Mar 10, 2016 at 9:23 AM, Oliver Neukum <oneukum@suse.com> wrote:
> > On Thu, 2016-03-10 at 02:29 +0000, Alexey Klimov wrote:

> >> +     streamlabs_wdt->buffer[3] = 0x80;
> >> +
> >> +     streamlabs_wdt->buffer[6] = (timeout_msec & 0xff) << 8;
> >> +     streamlabs_wdt->buffer[7] = (timeout_msec & 0xff00) >> 8;
> >
> > We have macros for such conversions. Please use them.
> 
> I screwed here. It should be:
>     buffer[6] = timeout_msec & 0xff;
>     buffer[7] = (timeout_msec >> 8) & 0xff;
> 
> However, are you talking about using swab16() function? Or migrating
> to cpu_to_le() and friends functions?
> 
> If it's acceptable way to make buffer with u16 type?
> It slightly decreases lines of code and no conversion is needed here
> that way. I can do just without swapping bytes:
>  buffer[3] = timeout_msec;
> and that's it.

NO!

You cannot make assumptions about the byte order of the host. This goes
over the wire. It must be in a defined order. You need to use the
cpu_to_* family of macros which will do the right thing. You just
open coded them.

Sorry to be very blunt here, but we absolutely must not make assumptions
about which hosts USB drivers can run on.

	HTH
		Oliver


