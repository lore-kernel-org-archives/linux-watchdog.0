Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19162 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033Ab2HGPXy (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Aug 2012 11:23:54 -0400
Date: Tue, 7 Aug 2012 11:23:48 -0400
From: David Teigland <teigland@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: new option to skip ping in close
Message-ID: <20120807152348.GA29229@redhat.com>
References: <20120803174027.GB15192@redhat.com>
 <501CE688.8070509@redhat.com>
 <20120806162503.GA21740@redhat.com>
 <5020C980.5050601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5020C980.5050601@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Aug 07, 2012 at 09:53:36AM +0200, Hans de Goede wrote:
> >In the end, we need WDIOC_NOCLOSEPING to be processed by the core,
> >independent of what drivers do, since as I explained this is targeting the
> >behavior of the core framework, not the drivers.
> 
> Right, and it will be processed by the core if it is in the switch-case because:
> 
> watchdog_ioctl_op will return ENOIOCTLCMD for non driver specific custom ioctls,
> causing watchdog_ioctl() to continue into the switch case for standard ioctls!

Thanks, there's one piece I'm missing -- could you refer me to a specific
driver that returns ENOIOCTLCMD from its ioctl method?

Thanks,
Dave

