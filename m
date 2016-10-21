Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46240 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932869AbcJUM6v (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 21 Oct 2016 08:58:51 -0400
Date: Fri, 21 Oct 2016 15:52:12 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] watchdog: wdat_wdt: Ping the watchdog on resume
Message-ID: <20161021125212.GW24289@lahna.fi.intel.com>
References: <20161020150336.97791-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0ipdO2psmdesoQuw_5uuOSqDh22DK04bEJTi1pW0fL53g@mail.gmail.com>
 <20161020151738.GP24289@lahna.fi.intel.com>
 <CAJZ5v0g8dx=Mivf8=4kUdW9JHh9hru5dob73UOFMQeLb6zaSiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g8dx=Mivf8=4kUdW9JHh9hru5dob73UOFMQeLb6zaSiQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 20, 2016 at 05:48:32PM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 20, 2016 at 5:17 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Thu, Oct 20, 2016 at 05:05:22PM +0200, Rafael J. Wysocki wrote:
> >> On Thu, Oct 20, 2016 at 5:03 PM, Mika Westerberg
> >> <mika.westerberg@linux.intel.com> wrote:
> >> > It turns out we need to ping the watchdog hardware on resume when we
> >> > re-program it. Otherwise this results inadvertent reset to trigger right
> >> > after the resume is completed.
> >> >
> >> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>
> >> Is there a Fixes: tag missing here?
> >
> > Oops, right. Sorry about that.
> >
> > It should be:
> >
> > Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
> >
> > (I can resend the patch as well, if needed with the Fixes tag).
> 
> No worries, I can pick this up from here.

Thanks :-)
