Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52371 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753215Ab1KBVOK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Nov 2011 17:14:10 -0400
Date: Wed, 2 Nov 2011 14:10:41 -0700
From: Greg KH <greg@kroah.com>
To: Florian Fainelli <florian@openwrt.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Greg KH <gregkh@suse.de>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH -stable] watchdog: mtx1-wdt: fix build failure
Message-ID: <20111102211041.GE9949@kroah.com>
References: <201110171947.44673.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201110171947.44673.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Oct 17, 2011 at 07:47:44PM +0200, Florian Fainelli wrote:
> Commit 6d86a0ee (watchdog: mtx1-wdt: request gpio before using it) was
> backported from upstream. The patch is using a gpiolib call which is only
> available in kernel 2.6.34+. Fix build by using the "old" gpiolib API
> instead.
> 
> CC: stable@kernel.org
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> This patch is applicable from 2.6.32+ to 2.6.33+ included.

Thanks, now applied.

greg k-h
