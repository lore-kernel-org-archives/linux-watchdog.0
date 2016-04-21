Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35061 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbcDUXaf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Apr 2016 19:30:35 -0400
Date: Thu, 21 Apr 2016 16:30:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: core: Fix circular locking dependency
Message-ID: <20160421233032.GA30063@roeck-us.net>
References: <1461249494-24924-1-git-send-email-linux@roeck-us.net>
 <20160421155055.503e6d23@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160421155055.503e6d23@lxorguk.ukuu.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Apr 21, 2016 at 03:50:55PM +0100, One Thousand Gnomes wrote:
> > Turns out the call to cancel_delayed_work_sync() in watchdog_release()
> > is not necessary and can be dropped. If the worker is no longer necessary,
> > the subsequent call to watchdog_update_worker() will cancel it. If it is
> > already running, it won't do anything, since the worker function checks
> > if it needs to ping the watchdog or not.
> 
> Is this actually true. Consider the pathalogical case of the device being
> closed and the modue unloaded. In that case the close completes, we drop
> the module count but could still do work on it.
> 
Module unload is handled separately and also calls cancel_delayed_work_sync().

Guenter
