Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:64240 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeCVXXR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Mar 2018 19:23:17 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
Cc: Len Brown <lenb@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-acpi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] ACPI / watchdog: Fix off-by-one error at resource assignment
Date: Fri, 23 Mar 2018 00:23:41 +0100
Message-ID: <1554658.JfhxrWsH3s@aspire.rjw.lan>
In-Reply-To: <20180319151641.GX2703@lahna.fi.intel.com>
References: <20180319135149.25215-1-tiwai@suse.de> <20180319151641.GX2703@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday, March 19, 2018 4:16:41 PM CET Mika Westerberg wrote:
> On Mon, Mar 19, 2018 at 02:51:49PM +0100, Takashi Iwai wrote:
> > The resource allocation in WDAT watchdog has off-one-by error, it sets
> > one byte more than the actual end address.  This may eventually lead
> > to unexpected resource conflicts.
> > 
> > Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> --

Applied, thanks!
