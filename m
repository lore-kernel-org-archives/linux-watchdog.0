Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:57981 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751574AbdDAOkk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Apr 2017 10:40:40 -0400
Date: Sat, 1 Apr 2017 10:40:39 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg KH <greg@kroah.com>
cc: Zoltan Boszormenyi <zboszor@pr.hu>, <linux-usb@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] usb: pci-quirks: Add a header for SB800 I/O ports
 and mutex for locking
In-Reply-To: <20170401135957.GA9493@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1704011039140.6983-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, 1 Apr 2017, Greg KH wrote:

> On Sat, Apr 01, 2017 at 01:02:21PM +0200, Zoltan Boszormenyi wrote:
> > From: Böszörményi Zoltán <zboszor@pr.hu>
> > 
> > This patch adds:
> > * a mutex in the USB PCI quirks code for synchronizing access to
> >   the I/O ports on SB800
> > * a new header that contains symbols for the index and data I/O ports
> >   and wrappers for locking and unlocking the mutex.
> > * locking around the I/O port access for SB800
> > 
> > Signed-off-by: Zoltan Boszormenyi <zboszor@pr.hu>
> > ---

> > diff --git a/include/linux/sb800.h b/include/linux/sb800.h
> > new file mode 100644
> > index 0000000..5650b7d
> > --- /dev/null
> > +++ b/include/linux/sb800.h
> > @@ -0,0 +1,15 @@
> > +
> > +#ifndef SB800_H
> > +#define SB800_H
> > +
> > +#include <linux/mutex.h>
> > +
> > +#define SB800_PIIX4_SMB_IDX		0xcd6
> > +#define SB800_PIIX4_SMB_DATA	0xcd7
> > +
> > +extern struct mutex sb800_mutex;
> > +
> > +#define enter_sb800()	mutex_lock(&sb800_mutex)
> > +#define leave_sb800()	mutex_unlock(&sb800_mutex)

Is include/linux/ the best place for this new header file?  Aren't 
there other locations more suitable for something that's 
board-specific?

Alan Stern

> Don't hide the mutex, just spell it out in the code itself.  No need for
> these defines at all.
> 
> thanks,
> 
> greg k-h

