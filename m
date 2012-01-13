Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:55284 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759250Ab2AMVp6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Jan 2012 16:45:58 -0500
Date: Fri, 13 Jan 2012 22:45:55 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-watchdog@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>,
	myungjoo.ham@gmail.com, Wim Van Sebroeck <wim@iguana.be>,
	kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: fix error in probe() of s3c2410_wdt (reset
	at booting)
Message-ID: <20120113214555.GA19495@infomag.iguana.be>
References: <1326431663-4638-1-git-send-email-myungjoo.ham@samsung.com> <20120113111117.GT1068@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120113111117.GT1068@n2100.arm.linux.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Fri, Jan 13, 2012 at 11:11:17AM +0000, Russell King - ARM Linux wrote:

> On Fri, Jan 13, 2012 at 02:14:23PM +0900, MyungJoo Ham wrote:
> > Probe function of s3c2410 watchdog calls request_irq before initializing
> > required value (wdt_count). This incurs resetting watchdog counter value
> > and watchdog-reboot during booting up.
> > 
> > This patch addresses such an issue by calling request_irq later.
> > 
> > Error handling in probe function and calling oder in remove function are
> > also revised accordingly.
> 
> On the other hand, this patch violates the general principle that you set
> the device up _before_ you publish it to userspace.
> 
> In the case where you add the watchdog device, but then the subsequent
> request_irq() fails, there is a window where the watchdog device could
> be opened and started.  You then fall out through the error paths, and
> the module could be removed.
> 
> Don't do this.  Always setup the device first.  Then publish it.  Never
> the other way around.

Russell was faster in replying, but I would have given the same NAK:
the registering of the watchdog means that userspace get access/control over
the watchdog device. So the request_irq should be done before that.

In your trouble description you wrote: "Probe function of s3c2410 watchdog
calls request_irq before initializing required value (wdt_count)."
Should we not fix the initialization of the wdt_count value instead of the
request_irq? i will have a look at the code somewhere this weekend.

Mvg,
Wim.

