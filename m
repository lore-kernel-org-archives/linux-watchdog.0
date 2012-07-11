Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53183 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901Ab2GKM5i (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 Jul 2012 08:57:38 -0400
Subject: Re: [PATCH][v2] powerpc/watchdog: move booke watchdog param related code to setup-common.c
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342000568-5605-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Wed, 11 Jul 2012 07:57:30 -0500
Cc: <linux-watchdog@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Content-Transfer-Encoding: 7bit
Message-Id: <60904FE9-978C-494A-8C9F-B4318B4FB46D@kernel.crashing.org>
References: <1342000568-5605-1-git-send-email-Shaohui.Xie@freescale.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On Jul 11, 2012, at 4:56 AM, Shaohui Xie wrote:

> Currently, BOOKE watchdog code for checking "wdt" and "wdt_period" is
> in setup_32.c, it cannot be used in 64-bit, so move it to a common place
> setup-common.c, which will be shared by 32-bit and 64-bit.
> 
> Also, replace the simple_strtoul with kstrtol.
> 
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> changes for v2:
> use setup-common.c instead of prom.c
> 
> arch/powerpc/kernel/setup-common.c |   27 +++++++++++++++++++++++++++
> arch/powerpc/kernel/setup_32.c     |   24 ------------------------
> 2 files changed, 27 insertions(+), 24 deletions(-)

applied to next

- k
