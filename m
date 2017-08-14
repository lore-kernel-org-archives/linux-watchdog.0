Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45672 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdHNRZQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 13:25:16 -0400
Date: Mon, 14 Aug 2017 10:25:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 0/3] watchdog: renesas_wdt: use standard clock
 handling
Message-ID: <20170814172513.GA7764@roeck-us.net>
References: <20170726215439.9623-1-wsa+renesas@sang-engineering.com>
 <20170814153230.GA7025@roeck-us.net>
 <20170814154728.j5h3u4vs43six4z7@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170814154728.j5h3u4vs43six4z7@ninjato>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Aug 14, 2017 at 05:47:28PM +0200, Wolfram Sang wrote:
> On Mon, Aug 14, 2017 at 08:32:30AM -0700, Guenter Roeck wrote:
> > On Wed, Jul 26, 2017 at 11:54:36PM +0200, Wolfram Sang wrote:
> > > As mentioned in a response to a previous patch, clock handling for Renesas
> > > R-Car is done via RuntimePM. Patch 1 implements that consequently. Patch 2
> > > is a cleanup then possible and patch 3 is a trivial copyright update.
> > > 
> > > This is RFC because I'd like Geert's comments on these patches first which
> > > might take a few days...
> > > 
> > Was there any feedback from Geert ? I don't recall seeing any.
> 
> He just got back from holidays and is bravely working through his mail
> queue :)
> 

Good to hear that I am not the only one with that problem :-).

Guenter
