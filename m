Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skyrme.org ([193.175.80.135]:43030 "EHLO skyrme.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838Ab2I0Npi (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Sep 2012 09:45:38 -0400
Received: from p4ff1b7aa.dip.t-dialin.net ([79.241.183.170] helo=curry.scara.com)
	by skyrme.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <oskar@scara.com>)
	id 1THDpY-0007rU-Qc
	for linux-watchdog@vger.kernel.org; Thu, 27 Sep 2012 13:08:41 +0000
Date: 27 Sep 2012 13:08:37 +0000
Message-ID: <20120927130837.GA22448@curry>
From: "Oskar Schirmer" <oskar@scara.com>
To: "Wim Van Sebroeck" <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	" Wolfram Sang" <w.sang@pengutronix.de>,
	" Sascha Hauer" <kernel@pengutronix.de>,
	" Andrew Morton" <akpm@linux-foundation.org>,
	" Johannes Weiner" <hannes@cmpxchg.org>,
	" Oskar Schirmer" <oskar@scara.com>
Subject: Re: [PATCH v3] watchdog/imx2+: add support for pretimeout interrupt functionality
References: <1347357652-23601-1-git-send-email-oskar@scara.com> <1348155444-24321-1-git-send-email-oskar@scara.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1348155444-24321-1-git-send-email-oskar@scara.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

unless there is another issue with this patch,
could You give an ack now?

thanks,
  Oskar

On Thu, Sep 20, 2012 at 15:37:24 +0000, Oskar Schirmer wrote:
> This watchdog device provides pretimeout facilities:
> Set some timeout value and get informed about imminent
> watchdog activity thru interrupt.
> 
> Allow user to wait for this asynchronous event thru poll(2),
> and to clear it implicitely upon dog appeasement.
> 
> There is only one precedent in current kernel that implements
> watchdog pretimeout, ipmi_watchdog. It provides pretimeout
> event thru poll, and requires a read(2) call to clear it.
> 
> However, as write(2) does calm the dog and so wind up the
> timer anyway, it is obvious to let poll(2) state writability
> where pretimeout has passed.
[...]
