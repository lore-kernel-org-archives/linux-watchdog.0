Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48102 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932289AbbD1JWO (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Apr 2015 05:22:14 -0400
Date: Tue, 28 Apr 2015 10:22:05 +0100
From: Lee Jones <lee@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eric Anholt <eric@anholt.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to
 the WDT driver.
Message-ID: <20150428092205.GG11956@x1>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
 <1429902534-2348-2-git-send-email-eric@anholt.net>
 <20150427160432.GD5701@roeck-us.net>
 <20150427160517.GA11074@roeck-us.net>
 <877fsx9nd6.fsf@eliezer.anholt.net>
 <553EE4EC.1000403@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <553EE4EC.1000403@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 27 Apr 2015, Guenter Roeck wrote:

> On 04/27/2015 04:12 PM, Eric Anholt wrote:
> >Guenter Roeck <linux@roeck-us.net> writes:
> >
> >>On Mon, Apr 27, 2015 at 09:04:32AM -0700, Guenter Roeck wrote:
> >>>On Fri, Apr 24, 2015 at 12:08:54PM -0700, Eric Anholt wrote:
> >>>>Since the WDT is what's used to drive restart and power off, it makes
> >>>>more sense to keep it there, where the regs are already mapped and
> >>>>definitions for them provided.  Note that this means you may need to
> >>>>add CONFIG_BCM2835_WDT to retain functionality of your kernel.
> >>>>
> >>>>Signed-off-by: Eric Anholt <eric@anholt.net>
> >>>>Cc: linux-watchdog@vger.kernel.org
> >>>
> >>>The patch will require a rebase to v4.0-rc1.
> >>>
> >>s/4.0/4.1/
> >
> >It will?  It seems to work fine, and the diff's the same.  Is there some
> >new thing you were expecting in a rebase?
> >
> All I can say is that it didn't apply for me. Maybe someone else has more luck.

I won't even try without a WDT Ack. ;)
