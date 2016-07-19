Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33966 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbcGSWxe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jul 2016 18:53:34 -0400
Date: Tue, 19 Jul 2016 18:53:27 -0400
From: Mahesh Khanwalkar <maheshkhanwalkar@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
	tglx@linutronix.de, clemens@ladisch.de, wim@iguana.be,
	linux@roeck-us.net, gregkh@linuxfoundation.org,
	dasaratharaman.chandramouli@intel.com, timur@codeaurora.org,
	arnd@arndb.de, nab@linux-iscsi.org, hans.verkuil@cisco.com,
	mchehab@osg.samsung.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4] Documentation: Move samples from doc to samples/
Message-ID: <20160719225327.GA3779@gmail.com>
References: <1468871700-12889-1-git-send-email-maheshkhanwalkar@gmail.com>
 <20160719163525.05af24af@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160719163525.05af24af@lwn.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jul 19, 2016 at 04:35:25PM -0600, Jonathan Corbet wrote:
> So, while I'm generally in favor of moving this code over to samples/,
> I'm a bit nervous about a single, do-it-all patch.  I'd rather see each
> subsystem's stuff moved separately, with (1) review from the appropriate
> maintainer, and (2) some sense that somebody has looked at this code and
> ensured that it still makes sense to keep around.

I agree. I'll break up the patch into smaller, independent pieces based
on the subsystem and email the appropriate maintainers. There were a few
other stuff referenced in Documentation/Makefile that may be samples
(I'll have to look again) that I didn't add to the patch, as it was
getting a quite large already.

Thanks, 
Mahesh Khanwalkar
