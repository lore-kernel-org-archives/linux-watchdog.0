Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46691 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758053Ab1COPmz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 15 Mar 2011 11:42:55 -0400
Subject: Re: [PATCH] [v2] watchdog: booke_wdt: clean up status messages
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1297208386-15010-1-git-send-email-timur@freescale.com>
Date: Tue, 15 Mar 2011 10:42:42 -0500
Cc: <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>,
	<wim@iguana.be>, <linux-watchdog@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C8B1E427-5A9D-4ED2-9C39-C1D8201E636E@kernel.crashing.org>
References: <1297208386-15010-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On Feb 8, 2011, at 5:39 PM, Timur Tabi wrote:

> Improve the status messages that are displayed during some operations of the
> PowerPC watchdog timer driver.  When the watchdog is enabled, the timeout is
> displayed as a number of seconds, instead of an obscure "period".  The "period"
> is the position of a bit in a 64-bit timer register.  The higher the value,
> the quicker the watchdog timeout occurs.  Some people chose a high "period"
> value for the timer and get confused as to why the board resets within a
> few seconds.
> 
> Messages displayed during open and close are now debug messages, so that they
> don't clutter the console by default.  Finally, printk() is replaced with the
> pr_xxx() equivalent.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> drivers/watchdog/booke_wdt.c |   19 +++++++++----------
> 1 files changed, 9 insertions(+), 10 deletions(-)

applied

- k