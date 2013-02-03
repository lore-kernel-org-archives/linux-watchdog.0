Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36620 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008Ab3BCRHV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 3 Feb 2013 12:07:21 -0500
Date: Sun, 3 Feb 2013 18:07:18 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee.jones@linaro.org>,
	Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Subject: Re: [PATCH 0/4] add ux500_wdt support
Message-ID: <20130203170718.GR8476@sortiz-mobl>
References: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabio,

On Fri, Jan 18, 2013 at 12:40:10PM +0100, Fabio Baltieri wrote:
> Hi all,
> 
> this set adds support for the ux500_wdt timer, implemented in the PRCMU
> unit of ST-Ericsson ux500 architecture.
> 
> The first two patches add the necessary definitions and function export
> to the PRCMU driver currently in mainline, while the third an fourth
> patches add the actual watchdog driver and mfd_cell definition to make
> it probe when PRCMU is compiled in.
> 
> As the patches touches files in both mfd and watchdog subsystems, what do
> you think is the best way to handle this set?
> 
> Thanks,
> Fabio
> 
> 
> Fabio Baltieri (4):
>   mfd: dbx500-prcmu: add watchdog ID definitions
>   mfd: dbx500-prcmu: export a9wdog functions
>   watchdog: add support for ux500_wdt watchdog
>   mfd: db8500-prcmu: add ux500_wdt mfd_cell
All 4 patches (v2 for #3) applied, many thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
