Return-path: <panand@redhat.com>
Date: Tue, 3 May 2016 21:21:41 +0530
From: Pratyush Anand <panand@redhat.com>
To: Timur Tabi <timur@codeaurora.org>
Cc: Guenter Roeck <linux@roeck-us.net>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, wim@iguana.be,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
Message-ID: <20160503155141.GF13045@dhcppc6.redhat.com>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
 <5728A7C3.4010001@roeck-us.net>
 <20160503143856.GE13045@dhcppc6.redhat.com>
 <5728BEC4.6050603@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5728BEC4.6050603@codeaurora.org>
List-ID: <linux-watchdog@vger.kernel.org>

On 03/05/2016:10:07:48 AM, Timur Tabi wrote:
> Pratyush Anand wrote:
> >In fact after supporting max_hw_heartbeat_ms, there should be no change for
> >action=0 functionally. However, we would still need some changes for action=1.
> 
> IMHO, action=1 is more of a debugging option, and not something that would
> be used normally.  I would need to see some evidence that real users want to
> have action=1 and a longer timeout.
> 
If action=1 need to be used effectively, then we should have something which
would help to increase timeout values.

Currently you have only 10 second to execute secondary kernel, which might not
be sufficient.

> I've never been a fan of the action=1 option, and I'm certainly not keen any
> patches that make action=1 more complicated than it already is.

I think, with max_hw_heartbeat_ms it would be far more simpler. Will attempt and
send another RFC.

~Pratyush
