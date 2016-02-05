Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0142.outbound.protection.outlook.com ([65.55.169.142]:16688
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757272AbcBEVSM (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Feb 2016 16:18:12 -0500
Date: Fri, 5 Feb 2016 15:03:28 -0600
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: Josh Cartwright <joshc@ni.com>
CC: <linux-watchdog@vger.kernel.org>
Subject: Re: [RFC 4/4] watchdog: ni9x3x_wdt: Let user control watchdog mode
Message-ID: <20160205210328.GB11390@senary>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
 <1454635683-13668-4-git-send-email-kyle.roeschley@ni.com>
 <20160205202720.GD9579@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20160205202720.GD9579@jcartwri.amer.corp.natinst.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 05, 2016 at 02:27:20PM -0600, Josh Cartwright wrote:
> On Thu, Feb 04, 2016 at 07:28:03PM -0600, Kyle Roeschley wrote:
> > When first powering on, the NI 903x/913x watchdog starts in boot mode.
> > If not switched from boot mode to user mode within 30 seconds of power
> > on, the device status LED indicates an unrecoverable error. While before
> > this was handled automatically, now add a module parameter to disable
> > this behavior.
> > 
> > In order to still have a useful watchdog, also add a R/W sysfs attribute
> > `mode' which can be used to switch the watchdog mode from boot to user
> > mode (but not user to boot mode).
> 
> Hmm.  Instead of an attribute, why don't we just ensure the watchdog is
> in "user" mode in start()?
> 
>   Josh

Seems like a good idea, except for the fact that we then lose a way to query
the current watchdog mode. Maybe we could only enable the `mode' attribute
(and possibly make it read-only) when auto_mode_switch is set to false?

Kyle
