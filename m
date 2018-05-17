Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54085 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeEQJ2k (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 17 May 2018 05:28:40 -0400
Date: Thu, 17 May 2018 11:28:36 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, fzuuzf@googlemail.com,
        support.opensource@diasemi.com, kernel@pengutronix.de,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: da9063: Fix setting/changing timeout
Message-ID: <20180517092836.t5mj5f62ehzpea6p@pengutronix.de>
References: <20180517070354.5318-1-m.felsch@pengutronix.de>
 <1526546011.2971.1.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526546011.2971.1.camel@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 18-05-17 10:33, Philipp Zabel wrote:
> On Thu, 2018-05-17 at 09:03 +0200, Marco Felsch wrote:
> > If the timeout value is set more than once the DA9063 watchdog triggers
> > a reset signal which reset the system.
> > 
> > To update the timeout value we have to disable the watchdog, clear the
> > watchdog counter value and write the new timeout value to the watchdog.
> > Clearing the counter value is a feature to be on the safe side because the
> > data sheet doesn't describe the behaviour of the watchdog counter value
> > after a watchdog disabling-enable-sequence.
> > 
> > The patch is based on Philipp Zabel's previous patch but doesn't wait
> > 150us because the DA9063 doesn't need this delay.
> 
> Actually, the delay is back now.
> 

Yes, my mistake.
I make a v4 to finally fix this.

>
> Otherwise,
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> regards
> Philipp
> 
> 

Regards,
Marco
