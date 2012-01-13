Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37022 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab2AMLL3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Jan 2012 06:11:29 -0500
Date: Fri, 13 Jan 2012 11:11:17 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-watchdog@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>,
	myungjoo.ham@gmail.com, Wim Van Sebroeck <wim@iguana.be>,
	kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: fix error in probe() of s3c2410_wdt (reset
	at booting)
Message-ID: <20120113111117.GT1068@n2100.arm.linux.org.uk>
References: <1326431663-4638-1-git-send-email-myungjoo.ham@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1326431663-4638-1-git-send-email-myungjoo.ham@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jan 13, 2012 at 02:14:23PM +0900, MyungJoo Ham wrote:
> Probe function of s3c2410 watchdog calls request_irq before initializing
> required value (wdt_count). This incurs resetting watchdog counter value
> and watchdog-reboot during booting up.
> 
> This patch addresses such an issue by calling request_irq later.
> 
> Error handling in probe function and calling oder in remove function are
> also revised accordingly.

On the other hand, this patch violates the general principle that you set
the device up _before_ you publish it to userspace.

In the case where you add the watchdog device, but then the subsequent
request_irq() fails, there is a window where the watchdog device could
be opened and started.  You then fall out through the error paths, and
the module could be removed.

Don't do this.  Always setup the device first.  Then publish it.  Never
the other way around.
