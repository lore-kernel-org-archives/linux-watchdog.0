Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:21192
	"EHLO AM1EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752746Ab0JGGTm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Oct 2010 02:19:42 -0400
Subject: Re: [PATCH 2/2] [v2] powerpc/watchdog: allow the e500 watchdog driver to be compiled as a module
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1284999822-24753-2-git-send-email-timur@freescale.com>
Date: Thu, 7 Oct 2010 01:00:21 -0500
CC: <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>,
	<linux-watchdog@vger.kernel.org>, <jwboyer@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-ID: <895E8A3E-55AB-4F08-91B7-4C83F838D6E7@freescale.com>
References: <1284999822-24753-1-git-send-email-timur@freescale.com> <1284999822-24753-2-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On Sep 20, 2010, at 11:23 AM, Timur Tabi wrote:

> Register the __init and __exit functions in the PowerPC e500 watchdog driver
> as module entry/exit functions, and modify the Kconfig entry.
> 
> Add a .release method for the PowerPC e500 watchdog driver, so that the
> watchdog is disabled when the driver is closed.
> 
> Loosely based on original code from Jiang Yutang <b14898@freescale.com>.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> This patch requires:
> 
> 	powerpc: export ppc_proc_freq and ppc_tb_freq as GPL symbols
> 
> drivers/watchdog/Kconfig     |    5 ++++-
> drivers/watchdog/booke_wdt.c |   39 +++++++++++++++++++++++++++++++++++++--
> 2 files changed, 41 insertions(+), 3 deletions(-)


applied to next [fixed comment message to say Book-E instead of e500]

- k
