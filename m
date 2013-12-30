Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:49236 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755514Ab3L3LDh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Dec 2013 06:03:37 -0500
Date: Mon, 30 Dec 2013 12:03:36 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Baruch Siach <baruch@tkos.co.il>
Cc: linux-watchdog@vger.kernel.org, Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] watchdog: dw_wdt: remove build dependencies
Message-ID: <20131230110336.GN10136@spo001.leaseweb.com>
References: <230543f28a66b7bf4c4ebb63e4ac2a3000299ce4.1388387430.git.baruch@tkos.co.il> <20131230083755.GM10136@spo001.leaseweb.com> <20131230090115.GA3930@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131230090115.GA3930@tarshish>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Baruch,

> > If this is ARM hardware, then this should have the dependency "depends on 
> > ARM".
> > Only if other architectures start using this watchdog device, then the 
> > "depends on ARM" can go.
> 
> Well, we intend to use this driver on Xtensa platform, does this count?

Xtensa is indeed another Platform, but then I expect the patch to:
1) make this clear in the Kconfig file
2) have a commit-message that also explains this.

> As a general rule wouldn't it be better to have the widest possible build 
> coverage, and encourage arch neutral driver coding?

We try to have as much arch neutral driver encoding (see the Kconfig & Makefile in the drivers/watchdog directory and you will see that we have drivers that are not depending on a specific hardware architecture), but we should not forget that certain hardware is only available in a certain architecture and that it thus does not make any sense to compile kernels with drivers that never will be used. So the general rule still is: use common sense and look at the broader picture.

Kind regards,
Wim.

