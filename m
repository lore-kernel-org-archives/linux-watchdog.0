Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60466 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbbG2JE2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 05:04:28 -0400
Date: Wed, 29 Jul 2015 11:04:23 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Lee Jones <lee.jones@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150729110423.45b33e22@endymion.delvare>
In-Reply-To: <20150728173216.GC2284@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
	<1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
	<20150728094643.GT14943@x1>
	<20150728110717.GH2492@codeblueprint.co.uk>
	<20150728113721.GU14943@x1>
	<20150728124338.GA2773@codeblueprint.co.uk>
	<20150728150021.GX14943@x1>
	<55B79D60.4080807@roeck-us.net>
	<20150728152832.GY14943@x1>
	<55B7B707.8060606@roeck-us.net>
	<20150728173216.GC2284@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lee,

On Tue, 28 Jul 2015 18:32:16 +0100, Lee Jones wrote:
> On Tue, 28 Jul 2015, Guenter Roeck wrote:
> > On 07/28/2015 08:28 AM, Lee Jones wrote:
> > >On Tue, 28 Jul 2015, Guenter Roeck wrote:
> > >>Sure, we could have changed it to lowercase, but so far no one bothered.
> > >>Plus, of course, there is always the element that some maintainers hate
> > >>that kind of cleanup,
> > >
> > >Really?  Surely any kind of clean-up is good clean-up.  Especially as
> > >Greg KH et. al, have been doing public presentations telling everyone
> > >that there is always kernel work for anyone who has the time; spelling
> > >corrections and all.
> > 
> > Yes, really. Just try to submit cleanup patches to maintainers other than
> > Greg and myself, and you'll see. It is a minefield.
> 
> Admittedly some of us have our quirks, but I'm happy to challenge
> anyone that won't accept clean-up patches that make things better.

I may be one of these, to some degree, under certain circumstances.

The problem is that what you call "better" may not actually sound
better to me. Or it might be better in some respect but worse in others.

Specifically, your proposal to rename a kernel driver to remove
capitals, obviously has upsides, but it may also have downsides. Are
modprobe and friends case-insensitive? If not then renaming the module
that way may break existing "options" or "blacklist" statements
in /etc/modprobe.conf, or initialization scripts.

Such a change may also require some changes on the distribution side,
from a packaging perspective.

Likewise, renaming variables in the code makes it look better, but at
the cost of making future backports to that driver more difficult.

And if nothing else, the time you (or others) spend on this, is time
you won't spend somewhere else where it may be more useful. Or fun.

So in the end there's always a balance between the costs and the
benefits. Which may explain why sometimes some maintainers aren't so
interested in certain clean-up patches.

-- 
Jean Delvare
SUSE L3 Support
