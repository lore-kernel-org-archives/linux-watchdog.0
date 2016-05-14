Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:34809 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932361AbcENS3L (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 14:29:11 -0400
Date: Sat, 14 May 2016 20:29:07 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: core: Fix circular locking dependency
Message-ID: <20160514182907.GA21026@spo001.leaseweb.nl>
References: <1461249494-24924-1-git-send-email-linux@roeck-us.net> <20160514164119.GE20158@spo001.leaseweb.nl> <57375B5B.8040809@roeck-us.net> <57375F49.2020300@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57375F49.2020300@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> On 05/14/2016 10:07 AM, Guenter Roeck wrote:
> >Hi Wim,
> >
> >On 05/14/2016 09:41 AM, Wim Van Sebroeck wrote:
> >>Hi Guenter,
> >>
> >>>lockdep reports the following circular locking dependency.
> >>>
> >
> >You are faster than me this time. I was just about to send you a pull 
> >request.
> >Sorry for being late. The watchdog-next branch in my repository on 
> >kernel.org
> >has all patches in my queue, in case you want to have a look.
> >
> >I'll rebase my branch to yours and see if anything is missing, then send
> >you a pull request on top of it if needed.
> >
> 
> All there. Looks like you picked it up right after I updated the branch
> this morning.

Correct ;-)

Kind regards,
Wim.

