Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42044 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbeLSRSV (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Dec 2018 12:18:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so9739536plp.9
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Dec 2018 09:18:20 -0800 (PST)
Date: Wed, 19 Dec 2018 09:18:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4] watchdog: tqmx86: Add watchdog driver for the IO
 controller
Message-ID: <20181219171818.GA26154@roeck-us.net>
References: <1545232700-24462-1-git-send-email-andrew@lunn.ch>
 <20181219155718.GA28002@roeck-us.net>
 <20181219160525.GC24518@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219160525.GC24518@lunn.ch>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Dec 19, 2018 at 05:05:25PM +0100, Andrew Lunn wrote:
> On Wed, Dec 19, 2018 at 07:57:18AM -0800, Guenter Roeck wrote:
> > On Wed, Dec 19, 2018 at 04:18:20PM +0100, Andrew Lunn wrote:
> > > Some TQ-Systems ComExpress modules have an IO controller with a
> > > watchdog timer.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Hi Guenter
> 
> Sorry, i forgot to add your Reviewed-by.
> 
> Who actually takes this patch? Is it too late for the merge window
> which will open soon?
> 

I add it to my watchdog-next tree (hopefully tonight), and Wim either
picks it up from there or picks it directly. Timing is Wim's call.

Guenter
