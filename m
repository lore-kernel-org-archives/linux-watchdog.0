Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from imr3.ericy.com ([198.24.6.13]:40915 "EHLO imr3.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380Ab2CRVwZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 18 Mar 2012 17:52:25 -0400
Date: Sun, 18 Mar 2012 14:50:15 -0700
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] [PATCH] hwmon/sch56xx: Add support for the
 integrated watchdog (v2)
Message-ID: <20120318215015.GA28033@ericsson.com>
References: <1332072308-4404-1-git-send-email-hdegoede@redhat.com>
 <20120318121703.GB26167@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20120318121703.GB26167@ericsson.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Mar 18, 2012 at 08:17:03AM -0400, Guenter Roeck wrote:
> On Sun, Mar 18, 2012 at 08:05:08AM -0400, Hans de Goede wrote:
> > Add support for the watchdog integrated into the SMSC SCH5627 and
> > SCH5636 superio-s. Since the watchdog is part of the hwmon logical device
> > and thus shares ioports with it, the watchdog driver is integrated into the
> > existing hwmon drivers for these.
> > 
> > Note that this version of the watchdog support for sch56xx superio-s
> > implements the watchdog chardev interface itself, rather then relying on
> > the recently added watchdog core / watchdog_dev. This is done because
> > currently some needed functionality is missing from watchdog_dev, as soon
> > as this functionality is added (which is being discussed on the
> > linux-watchdog mailinglist), I'll convert this driver over to using
> > watchdog_dev.
> > 
> > Changes in v2:
> > -fix checkpatch complaints
> > -follow multi-line comment style guidelines
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> You are too fast ;-). Unfortunately, we'll need v3, with the slab.h include.
> 
Forget v3 - I added the include myself and applied the patch. Not worth missing
the commit window due to a missing include.

Guenter
