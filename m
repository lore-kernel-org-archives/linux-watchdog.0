Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55268 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679Ab2GJMYL (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 10 Jul 2012 08:24:11 -0400
Subject: Re: [PATCH 2/2][v2] powerpc/watchdog: replace CONFIG_FSL_BOOKE with CONFIG_PPC_FSL_BOOK3E
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1336714420-2394-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Tue, 10 Jul 2012 07:24:01 -0500
Cc: <linux-watchdog@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Content-Transfer-Encoding: 7bit
Message-Id: <811A0EE0-6D65-4903-83E6-3F13E35889A3@kernel.crashing.org>
References: <1336714420-2394-1-git-send-email-Shaohui.Xie@freescale.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On May 11, 2012, at 12:33 AM, Shaohui Xie wrote:

> CONFIG_FSL_BOOKE is only defined in 32-bit, CONFIG_PPC_FSL_BOOK3E is
> defined in both 32-bit and 64-bit, so use CONFIG_PPC_FSL_BOOK3E to make
> driver work in 32-bit & 64-bit.
> 
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> changes for v2:
> use PPC_FSL_BOOK3E instead of FSL_SOC_BOOKE.
> 
> drivers/watchdog/Kconfig     |    8 ++++----
> drivers/watchdog/booke_wdt.c |    4 ++--
> 2 files changed, 6 insertions(+), 6 deletions(-)

applied to next

- k
