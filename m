Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41805 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757938Ab1FVWpF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 18:45:05 -0400
Date: Wed, 22 Jun 2011 23:47:19 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Jesper Juhl <jj@chaosbits.net>,
	Donald Johnson <donald.k.johnson@intel.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] Intel SCU Watchdog: Fix build failure and duplicate
 include
Message-ID: <20110622234719.04c5291f@lxorguk.ukuu.org.uk>
In-Reply-To: <20110622203403.GI26745@infomag.iguana.be>
References: <20110607145407.GA12177@infomag.iguana.be>
	<20110607161712.46f18dff@lxorguk.ukuu.org.uk>
	<20110622203403.GI26745@infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> Can you look at attached patch and see what works best? Either we use
> the X86_MRST dependancy or either we need the INTEL_SCU_IPC && APB_TIMER one.

X86_MRST - its a property of the MID platform devices.

Alan
