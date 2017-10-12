Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45232 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753118AbdJLTyD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 12 Oct 2017 15:54:03 -0400
Date: Thu, 12 Oct 2017 12:54:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Lowering the log level in watchdog_dev_register when err==-EBUSY
Message-ID: <20171012195401.GA25996@roeck-us.net>
References: <1507743991.3486.5.camel@arista.com>
 <20171011184603.GB8756@roeck-us.net>
 <1507832159.4735.47.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507832159.4735.47.camel@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 12, 2017 at 07:15:59PM +0100, Radu Rendec wrote:
> On Wed, 2017-10-11 at 11:46 -0700, Guenter Roeck wrote:
> > On Wed, Oct 11, 2017 at 06:46:31PM +0100, Radu Rendec wrote:
> > > In a project I'm working on we have a valid use case where we activate
> > > both the i6300esb and softdog watchdogs. We always activate i6300esb
> > > first (which uses the "legacy" watchdog API) and then softdog. This
> > > gets us two "error" level messages (coming from watchdog_cdev_register)
> > > although softdog falls back to the "new" API and registers its char
> > > device just fine.
> > > 
> > > Since watchdog_cdev_register/watchdog_dev_register seem to be used only
> > > by watchdog_register_device and the latter always falls back to the
> > > "new" API, I'm thinking about lowering the log level of these messages
> > > when err is -EBUSY.
> >
> > I would suggest to convert the offending driver to use the watchdog subsystem
> > (and along the line remove the restriction of only supporting a single
> > instance). You have the hardware, so that should be a straightforward change.
> 
> Thanks for the suggestion! That makes sense. I will start working on
> converting i6300esb and submit a patch in a few days.
> 
> By the way, I don't have the hardware. I'm using it with KVM (Qemu),
> but I guess that's good enough since I'm not going to touch any of the
> code parts that deal with the hardware.
> 
Ah, interesting. Can you send me the qemu command line ?

Thanks,
Guenter
