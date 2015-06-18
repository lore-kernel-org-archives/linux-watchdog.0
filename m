Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:32988 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732AbbFRQiV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Jun 2015 12:38:21 -0400
Date: Thu, 18 Jun 2015 09:38:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: poeschel@lemonage.de
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: watchdog: omap_wdt: implement get_timeleft
Message-ID: <20150618163814.GA21442@roeck-us.net>
References: <1434531539-6198-1-git-send-email-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1434531539-6198-1-git-send-email-poeschel@lemonage.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 17, 2015 at 10:58:59AM +0200, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> The omap watchdog hardware is able to read the watchdog timer counter
> register. This implements this functionality in the omap_wdt driver, so
> one is can read the time until the watchdog will trigger the reset in
> seconds using WDIOC_GETTIMELEFT.
> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
