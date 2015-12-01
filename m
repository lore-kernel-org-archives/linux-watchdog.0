Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39999 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436AbbLAUYP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Dec 2015 15:24:15 -0500
Date: Tue, 1 Dec 2015 12:24:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [v3,1/2] Add binding documentation for Zodiac Watchdog Timer
Message-ID: <20151201202409.GA7401@roeck-us.net>
References: <1448453015-16126-1-git-send-email-martyn.welch@collabora.co.uk>
 <20151201151558.GA3141@roeck-us.net>
 <565DBEFE.8090508@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565DBEFE.8090508@collabora.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Dec 01, 2015 at 03:38:38PM +0000, Martyn Welch wrote:
> 
> 
> On 01/12/15 15:15, Guenter Roeck wrote:
> >On Wed, Nov 25, 2015 at 12:03:34PM +0000, Martyn Welch wrote:
> >>This patchs adds documentation for the binding of the Zodiac RAVE
> >>Switch Watchdog Processor. This is an i2c based watchdog.
> >>
> >>Cc: Rob Herring <robh+dt@kernel.org>
> >>Cc: Pawel Moll <pawel.moll@arm.com>
> >>Cc: Mark Rutland <mark.rutland@arm.com>
> >>Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> >>Cc: Kumar Gala <galak@codeaurora.org>
> >>Cc: devicetree@vger.kernel.org
> >>Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> >>Acked-by: Rob Herring <robh@kernel.org>
> >
> >Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >
> 
> Would I be right in thinking this will be going via the watchdog tree as
> well?
> 
I would think so. I'll queue it in my tree and send it to Wim in my next pull
request.

Guenter
