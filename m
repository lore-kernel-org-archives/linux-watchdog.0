Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34995 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbbLUQN3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Dec 2015 11:13:29 -0500
Date: Mon, 21 Dec 2015 21:43:27 +0530
From: Pratyush Anand <panand@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@iguana.be, dyoung@redhat.com, dzickus@redhat.com,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 1/2] watchdog: Use static struct class watchdog_class
 in stead of pointer
Message-ID: <20151221161327.GK29413@dhcppc13.redhat.com>
References: <cover.1450353452.git.panand@redhat.com>
 <b45250982479cf4a8a59b84bda7c058e424a88e8.1450353452.git.panand@redhat.com>
 <5672CD1B.40105@roeck-us.net>
 <20151219042208.GH29413@dhcppc13.redhat.com>
 <5678205B.1090905@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5678205B.1090905@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 21/12/2015:07:52:59 AM, Guenter Roeck wrote:
> On 12/18/2015 08:22 PM, Pratyush Anand wrote:
> >On 17/12/2015:06:56:27 AM, Guenter Roeck wrote:
> >>On 12/17/2015 04:23 AM, Pratyush Anand wrote:
> >>>We need few sysfs attributes to know different status of a watchdog device.
> >>>To do that, we need to associate .dev_groups with watchdog_class. So
> >>>convert it from pointer to static.
> >>>Putting this static struct in watchdog_dev.c, so that static device
> >>>attributes defined in that file can be attached to it.
> >>>
> >>>Signed-off-by: Pratyush Anand <panand@redhat.com>
> >>>Suggested-by: Guenter Roeck <linux@roeck-us.net>
> >>>Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >>
> >>As things evolve, I'd by now prefer to move the call to device_create()
> >>into watchdog_dev.c, but that can wait for a follow-up patch if Wim
> >>is ok with this series.
> >
> >Thanks for your quick review.
> >
> >OK. I will wait for Wim's comment and then may be I will send another
> >version with your comment for patch 1/1 incorporated.
> >
> 
> Thinking about it, my comment is really minor and should not hold up the
> series from going forward. So let's just skip another version unless Wim
> or someone else has any comments.

Thanks a lot :-)

~Pratyush
