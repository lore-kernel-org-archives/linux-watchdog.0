Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47673 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbbETBQh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 21:16:37 -0400
Message-ID: <555BE072.5090603@roeck-us.net>
Date: Tue, 19 May 2015 18:16:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
CC: Wenyou.Yang@atmel.com
Subject: Re: [PATCHv8 04/10] watchdog: core: Allow extending early timeout
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi> <1432023969-20736-5-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1432023969-20736-5-git-send-email-timo.kokkonen@offcode.fi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/19/2015 01:26 AM, Timo Kokkonen wrote:
> It is possible that the specified watchdog timeout value is shorter
> than the time it takes for the watchdog daemon to start up and take
> over the watchdog device. This is problem if WATCHDOG_BOOT_RUNNING is
> the desired watchdog policy.
>
> Add a new timeout value that specifies how long kernel should extend
> the timeout by pinging the watchdog hardware. This option still
> ensures a watchdog reset takes place in case watchdog daemon fails to
> open the device, but gives more freedom in case user space is slow
> starting up and watchdog might trigger prematurely.
>

Same as my other comment. This should not be a configuration option
(just like the default timeout isn't one).

I really think we are going into the wrong direction. I can understand
the point why it makes sense to have a devicetree parameter for this,
and we should focus (have focused) on getting it accepted. Now we have
to deal with kernel configuration options, and we get more and more
distracted from the real goal.

Guenter

