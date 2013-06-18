Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43411 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419Ab3FRQDS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 12:03:18 -0400
Date: Tue, 18 Jun 2013 17:03:04 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: wim@iguana.be, marc.zyngier@arm.com,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 00/14] watchdog: ARM mpcore Improvements
Message-ID: <20130618160304.GB2718@n2100.arm.linux.org.uk>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 18, 2013 at 08:50:24PM +0530, Viresh Kumar wrote:
> ARM mpcore watchdog isn't workable and so is marked broken in the first patch of
> the series. Reasons are mentioned in 01/14 and important links are shared too.

The only way this is usable is if a watchdog user binds to a particular
CPU before opening this device, and remains bound to that user.  The
irq-requesting thing is something that has changed since the driver
was originally added.

I suspect there are no users of this driver, and it should simply be
deleted.  It doesn't really fit our watchdog API.  If anyone wants to
resurect it, it's in git, your patches are in the list archives...
