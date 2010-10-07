Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:35019 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab0JGF7x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Oct 2010 01:59:53 -0400
Subject: Re: [PATCH 1/2] [v2] powerpc: export ppc_proc_freq and ppc_tb_freq as GPL symbols
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1284999822-24753-1-git-send-email-timur@freescale.com>
Date: Thu, 7 Oct 2010 00:59:49 -0500
CC: <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>,
	<linux-watchdog@vger.kernel.org>, <jwboyer@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-ID: <5B523788-3623-402C-A3A2-990F59ED4348@freescale.com>
References: <1284999822-24753-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On Sep 20, 2010, at 11:23 AM, Timur Tabi wrote:

> Export the global variable 'ppc_tb_freq', so that modules (like the Book-E
> watchdog driver) can use it.  To maintain consistency, ppc_proc_freq is changed
> to a GPL-only export.  This is okay, because any module that needs this symbol
> should be an actual Linux driver, which must be GPL-licensed.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> This export is necessary for the Book-E watchdog driver to be compiled as a
> module.
> 
> arch/powerpc/kernel/time.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)

applied to next

- k
