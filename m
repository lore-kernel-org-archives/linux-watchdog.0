Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43141 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbcEZWhW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 May 2016 18:37:22 -0400
Date: Thu, 26 May 2016 15:37:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Robin Gong <b38343@freescale.com>
Subject: Re: [PATCH 1/7] watchdog: add watchdog pretimeout framework
Message-ID: <20160526223717.GA6659@roeck-us.net>
References: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
 <1464183151-4912-2-git-send-email-wsa@the-dreams.de>
 <5747041B.2050707@mentor.com>
 <20160526164136.GB1631@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160526164136.GB1631@katana>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 26, 2016 at 06:41:36PM +0200, Wolfram Sang wrote:
[ ... ]
> 
> No doubt about that. I had some ideas and thought it is easier to talk
> over code. If you want to rebase it, too, I'd be happy to check what you
> came up with to solve the problems. I might still argue that I prefer
> the less-code approach, but it will be Guenter's / Wim's decision, of
> course.
> 
I have a large back-log of patches to review. Simple patches with less code
will get preferential treating. The more complex, the higher the likelyhood
that the patches get pushed to the end of the queue.

Giving a quick glance, I liked Wolfram's patches because they seemed to
be simple and straightforward. I hope the next version won't add too much
additional complexity.

Guenter
