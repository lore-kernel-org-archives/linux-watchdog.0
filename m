Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38517 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755434Ab1J1Psr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 28 Oct 2011 11:48:47 -0400
Date: Fri, 28 Oct 2011 11:48:22 -0400
From: Don Zickus <dzickus@redhat.com>
To: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: watchdogs and kdump
Message-ID: <20111028154822.GW3452@redhat.com>
References: <20111027203029.GR3452@redhat.com>
 <4EAACE56.90209@udio.cujae.edu.cu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EAACE56.90209@udio.cujae.edu.cu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 28, 2011 at 11:46:30AM -0400, Alejandro Cabrera wrote:
> Hi
> 
> I dont know kjump :), but seeing it's description I think that you
> could use a temporal thread executed in the context of kdump that
> ping the watchdog at certain intervals like watchdogd does at
> user-space.

Sure.  Add something like watchdogd isn't difficult.  My problem is
getting enough time to boot the second kernel to run that daemon.
Depending on when the watchdog was last kicked, the machine may reboot
while trying to initialize the cpu in the second kernel. :-(

Cheers,
Don
