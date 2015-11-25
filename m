Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:34636 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbbKYWnz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 17:43:55 -0500
Date: Wed, 25 Nov 2015 17:43:51 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 1/2] watchdog: core: call device_destroy before
 watchdog_dev_unregister
Message-ID: <20151125224351.GC3627@localhost>
References: <1448408745-26719-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <56551ADB.3000107@roeck-us.net>
 <20151125170910.GA6095@localhost>
 <5655F680.5020408@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5655F680.5020408@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 25, 2015 at 09:57:20AM -0800, Guenter Roeck wrote:
> Hi Damien,
> 
> On 11/25/2015 09:09 AM, Damien Riegel wrote:
> >On Tue, Nov 24, 2015 at 06:20:11PM -0800, Guenter Roeck wrote:
> >>On 11/24/2015 03:45 PM, Damien Riegel wrote:
> >>>device_create is called after watchdog_dev_register, so it makes more
> >>>sense to call the cleanup functions in reverse order, ie. device_destroy
> >>>before watchdog_dev_unregister.
> >>>
> >>>Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> >>
> >>Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >>
> >
> >On second thought, I am wondering if the proper fix would not be to call
> >device_create before watchdog_dev_register. Consider the following
> >scenario:
> >
> >   watchdog_register_device
> >     __watchdog_register_device
> >	  watchdog_dev_register returns successfully, char dev is live
> >       device_create fails, setting wdd->dev to an ERR_PTR
> >	  ...
> >	  meanwhile, a user opens the watchdog, hence ops->start is called.
> >	  If ops->start uses wdd->dev (to print a debug message for
> >	  instance), it will dereference an invalid pointer.
> >
> >Admittedly, it should be quite rare, but there is still a chance for a
> >race condition here.
> >
> Only we should not have race conditions, and this might actually happen
> if user space listens for a udev event on the character device, and device
> creation is delayed for some reasons.
> 
> I think you are right, that is a problem. Back to the drawing board.
> 
> Ok, next question: Does it hurt to call device_create() first ?
> That creates the sysfs entries for the driver.

I can't think of a case where it would be an issue to call
device_create() first. After all, watchdog_dev_register just creates
entries in /dev, so it makes sense to create them only when the watchdog
is fully ready. I will send patches tomorrow.

> 
> If that doesn't work either, the only other idea I have would be to reject
> an attempt to open the character device with -EAGAIN or similar if the
> device node is not yet (or not anymore) available. Or maybe that would
> be the correct approach anyway ? Or can we use some lock to synchronize
> the two operations ?
> 
> Thanks,
> Guenter
> 
