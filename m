Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48913 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbcH2UaH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 Aug 2016 16:30:07 -0400
Date: Mon, 29 Aug 2016 13:30:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Robin Gong <b38343@freescale.com>
Subject: Re: [PATCH v4 1/7] watchdog: add pretimeout support to the core
Message-ID: <20160829203002.GA15280@roeck-us.net>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1472227681-1405-2-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160829185005.GD1610@katana>
 <e9c4fb76-5b26-ab1e-09a3-d1af57451203@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c4fb76-5b26-ab1e-09a3-d1af57451203@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Aug 29, 2016 at 10:58:57PM +0300, Vladimir Zapolskiy wrote:
> On 08/29/2016 09:50 PM, Wolfram Sang wrote:
> >>+	} else {
> >> 		wdd->timeout = timeout;
> >>+		/* Disable pretimeout if it doesn't fit the new timeout */
> >>+		if (wdd->pretimeout >= wdd->timeout)
> >>+			wdd->pretimeout = 0;
> >
> >I wonder if we should add a warning here? What do you think?
> >
> 
> IMHO it is not vitally needed, but some message on KERN_INFO level may
> be considered as user-friendly, watchdog subsystem and drivers are
> historically verbose. Guenter, do you have an opinion on the topic?
> 
Yes, I dislike noise, I think the kernel is already way too noisy, and I dislike
statements like "watchdog subsystem and drivers are historically verbose" as
argument for adding more noise.

If this is an error, the function should return an error to user space.
If it isn't an error, I don't see a need for a message.

Guenter
