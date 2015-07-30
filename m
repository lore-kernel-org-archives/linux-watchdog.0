Return-path: <matt@console-pimps.org>
Date: Thu, 30 Jul 2015 10:14:59 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Lee Jones <lee.jones@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Zha Qipeng <qipeng.zha@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/3] iTCO_wdt: Expose watchdog properties using
 platform data
Message-ID: <20150730091458.GB2704@codeblueprint.co.uk>
References: <1438171844-24861-1-git-send-email-matt@codeblueprint.co.uk>
 <1438171844-24861-2-git-send-email-matt@codeblueprint.co.uk>
 <20150729153556.GC9319@x1>
 <20150729163953.GI2773@codeblueprint.co.uk>
 <20150730085347.GF9319@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150730085347.GF9319@x1>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, 30 Jul, at 09:53:47AM, Lee Jones wrote:
> On Wed, 29 Jul 2015, Matt Fleming wrote:
> 
> > On Wed, 29 Jul, at 04:35:56PM, Lee Jones wrote:
> > > 
> > > For my own reference (I assume this will go through the MFD tree):
> > >   Acked-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Great, thanks Lee!
> > 
> > I've no strong opinion on which tree these 3 patches go through but at
> > the very least patches 1 and 2 need to go through the same tree to avoid
> > build breakage (since PATCH 1 introduces 'struct itco_wdt_platform_data'
> > which is used in PATCH 2).
> > 
> > For reference, the other patches are here,
> > 
> >   https://lkml.kernel.org/r/1438171844-24861-3-git-send-email-matt@codeblueprint.co.uk
> >   https://lkml.kernel.org/r/1438171844-24861-4-git-send-email-matt@codeblueprint.co.uk
> 
> Obviously this makes things more difficult.  Once you have the other
> Acks you need, I suggest you re-submit the set using --threaded, so we
> can all see what's going on.
 
Umm... I submitted *this* version using --threaded. In fact, that's
plain to see from the Message-Id format in the links above. It's just
that I only Cc'd you on the patch that touched the mfd code.

I can resubmit with the Ack/Review tags and copy you on the whole series
if you'd like.

-- 
Matt Fleming, Intel Open Source Technology Center
