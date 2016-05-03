Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53778 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039AbcECRQQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 May 2016 13:16:16 -0400
Date: Tue, 3 May 2016 10:16:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Pratyush Anand <panand@redhat.com>
Cc: Timur Tabi <timur@codeaurora.org>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, wim@iguana.be,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
Message-ID: <20160503171602.GA2518@roeck-us.net>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
 <5728A7C3.4010001@roeck-us.net>
 <20160503143856.GE13045@dhcppc6.redhat.com>
 <5728BEC4.6050603@codeaurora.org>
 <20160503155141.GF13045@dhcppc6.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160503155141.GF13045@dhcppc6.redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 03, 2016 at 09:21:41PM +0530, Pratyush Anand wrote:
> On 03/05/2016:10:07:48 AM, Timur Tabi wrote:
> > Pratyush Anand wrote:
> > >In fact after supporting max_hw_heartbeat_ms, there should be no change for
> > >action=0 functionally. However, we would still need some changes for action=1.
> > 
> > IMHO, action=1 is more of a debugging option, and not something that would
> > be used normally.  I would need to see some evidence that real users want to
> > have action=1 and a longer timeout.
> > 
> If action=1 need to be used effectively, then we should have something which
> would help to increase timeout values.
> 
> Currently you have only 10 second to execute secondary kernel, which might not
> be sufficient.
> 
Previously the argument was that the 10 seconds (assuming the clock runs at
maximum speed) would not be sufficient to load the watchdog application. Now it
seems the 10 seconds are deemed insufficient to load the watchdog driver (since
the infrastructure can handle the heartbeats). Is there actual evidence that
this is the case ?

Guenter

> > I've never been a fan of the action=1 option, and I'm certainly not keen any
> > patches that make action=1 more complicated than it already is.
> 
> I think, with max_hw_heartbeat_ms it would be far more simpler. Will attempt and
> send another RFC.
> 
> ~Pratyush
