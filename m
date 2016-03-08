Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from forward.webhostbox.net ([162.251.85.45]:33695 "EHLO
	forward.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068AbcCHApX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 7 Mar 2016 19:45:23 -0500
Date: Mon, 7 Mar 2016 16:39:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v8 0/10] watchdog: Add support for keepalives triggered
 by infrastructure
Message-ID: <20160308003904.GA3769@roeck-us.net>
References: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
 <20160306104956.GA2282@spo001.leaseweb.nl>
 <20160307173720.GA17320@roeck-us.net>
 <20160307185023.GA16667@spo001.leaseweb.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160307185023.GA16667@spo001.leaseweb.nl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 07, 2016 at 07:50:23PM +0100, Wim Van Sebroeck wrote:
> Hi Guenter,
> 
> > Hi Wim,
> > 
> > On Sun, Mar 06, 2016 at 11:49:56AM +0100, Wim Van Sebroeck wrote:
> > > Hi Guenter,
> > > 
> > > > The watchdog infrastructure is currently purely passive, meaning
> > > > it only passes information from user space to drivers and vice versa.
> > > > 
> > [ ... ]
> > > 
> > > Patches 1 till 7 of this series has been added to linux-watchdog-next.
> > > 
> > Thanks a lot!
> 
> Did you receive any feedback/test-results on patches 8 till 10 ?
> 
No, unfortunately not. I think I'll ping some of those involved in the driver
development, but I'll do it after the -rc is out. No need to rush with those
now.

Thanks,
Guenter
