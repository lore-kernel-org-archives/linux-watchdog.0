Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:49812 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588Ab0JNGIW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Oct 2010 02:08:22 -0400
Subject: Re: [PATCH] powerpc: change the Book-E watchdog driver default timeout into a Kconfig option
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1286997576-4988-1-git-send-email-timur@freescale.com>
Date: Thu, 14 Oct 2010 01:08:16 -0500
CC: <linuxppc-dev@ozlabs.org>, <linux-watchdog@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-ID: <6354FDA6-BAEC-48DB-BAA8-D5ED2506B17D@freescale.com>
References: <1286997576-4988-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On Oct 13, 2010, at 2:19 PM, Timur Tabi wrote:

> The PowerPC Book-E watchdog driver (booke_wdt.c) defines a default timeout
> value in the code based on whether it's a Freescale Book-E part of not.
> Instead of having hard-coded values in the driver, make it a Kconfig option.
> 
> As newer chips gets faster, the current default values become less appropriate,
> since the timeout sometimes occurs before the kernel finishes booting.  Making
> the value a Kconfig option allows BSPs to configure a new value with requiring
> the wdt_period command-line parameter to be set.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> drivers/watchdog/Kconfig     |   17 +++++++++++++++++
> drivers/watchdog/booke_wdt.c |    8 +-------
> 2 files changed, 18 insertions(+), 7 deletions(-)

applied to next, fixed commit message.

Also, in general I believe commit messages should be about 75 columns so they dont wrap if you do a git log in an 80 column terminal.

- k
