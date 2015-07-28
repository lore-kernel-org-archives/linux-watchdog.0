Return-path: <matt@console-pimps.org>
Date: Tue, 28 Jul 2015 16:45:50 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Lee Jones <lee.jones@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150728154550.GB2773@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150728094643.GT14943@x1>
 <20150728110717.GH2492@codeblueprint.co.uk>
 <20150728113721.GU14943@x1>
 <20150728124338.GA2773@codeblueprint.co.uk>
 <20150728150021.GX14943@x1>
 <55B79D60.4080807@roeck-us.net>
 <20150728152832.GY14943@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150728152832.GY14943@x1>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, 28 Jul, at 04:28:32PM, Lee Jones wrote:
> On Tue, 28 Jul 2015, Guenter Roeck wrote:
> 
> > On 07/28/2015 08:00 AM, Lee Jones wrote:
> > >On Tue, 28 Jul 2015, Matt Fleming wrote:
> > >>On Tue, 28 Jul, at 12:37:21PM, Lee Jones wrote:
> > >>>
> > >>>The driver shouldn't be called that either.
> > >>>
> > >>>You are the only one.  What makes iTCO 'special'?
> > >>
> > >>I don't know, I didn't write it. It looks like Wim did ~9 years ago, so
> > >>it must have made sense to him at the time.
> > >>
> > 
> > Coding style wasn't as strict then as it is today. iTCO has just been kept
> > for historic reasons.
> 
> For sure, I get that, but it doesn't mean we can't do-the-right-thing
> (tm) now does it?
> 
> > Sure, we could have changed it to lowercase, but so far no one bothered.
> > Plus, of course, there is always the element that some maintainers hate
> > that kind of cleanup,
> 
> Really?

Yes, really. 

> Surely any kind of clean-up is good clean-up.  Especially as Greg KH
> et. al, have been doing public presentations telling everyone that
> there is always kernel work for anyone who has the time; spelling
> corrections and all.
 
That's what staging/ was invented for ;-) Greg is quite happy to take
those patches, other maintainers are less so.

> Matt,
> 
> Either do the 5min clean-up or don't, no biggy.  If you don't then I
> can do it.

Go for it.

> At the very least please don't add any _new_ camel case variables or
> filenames.

OK, sure.

-- 
Matt Fleming, Intel Open Source Technology Center
