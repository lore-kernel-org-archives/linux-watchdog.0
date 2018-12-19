Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([185.16.172.187]:52693 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbeLSJZc (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Dec 2018 04:25:32 -0500
Date: Wed, 19 Dec 2018 10:25:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: tqmx86: Add watchdog driver for the IO
 controller
Message-ID: <20181219092529.GD14923@lunn.ch>
References: <20181218234226.GA6713@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218234226.GA6713@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Dec 18, 2018 at 03:42:26PM -0800, Guenter Roeck wrote:
> On Tue, Dec 18, 2018 at 05:34:41PM +0100, Andrew Lunn wrote:
> > Some TQ-Systems ComExpress modules have an IO controller with a
> > watchdog timer.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Nitpicks:
> - SPDX license and MODULE_LICENSE mismatch
>   Maybe GPLv2 for both ?
> - Signed-off-by: and MODULE_AUTHOR mismatch
>   Given the changes you have made, it might make sense
>   to mention "Based on out-of-tree driver from ..."
>   in the header and make yourself the module author.
>   Just a thought.
> 
> Not sure if this warrants a resubmit. Your call.

Hi Guenter

I will probably respin, to fix the license at least. I've got a few
similar issues in the Ethernet PHY subsystem i'm wondering what to do
with, i don't really want to add another...

Thanks
	Andrew
