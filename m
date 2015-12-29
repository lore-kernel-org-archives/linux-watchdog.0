Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35460 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbbL2AAS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Dec 2015 19:00:18 -0500
Date: Mon, 28 Dec 2015 16:00:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] watchdog: Do not use 'dev' from watchdog_device
 in watchdog drivers
Message-ID: <20151229000015.GA2346@roeck-us.net>
References: <1450995724-17758-1-git-send-email-linux@roeck-us.net>
 <20151228221510.GB1889@spo001.leaseweb.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151228221510.GB1889@spo001.leaseweb.nl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Dec 28, 2015 at 11:15:10PM +0100, Wim Van Sebroeck wrote:
> Hi Guenter,
> 
> > The 'dev' variable in watchdog drivers has a different lifetime than the
> > watchdog character device and should therefore not be used by watchdog
> > drivers.
> > 
> > Some of the drivers use the variable to print kernel messages. Those
> > messages are either dropped or changed to use the parent device.
> > One driver sets the variable during initialization to the watchdog
> > driver's parent device, which is wrong and was removed.
> > 
> > v2: Use parent device for dev_XXX messages instead of pr_XXX.
> 
> This patchset has been added to linux-watchdog-next.
> 

Thanks!

Guenter
