Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33763 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbbG1P40 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 11:56:26 -0400
Received: by wicmv11 with SMTP id mv11so185506776wic.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 08:56:25 -0700 (PDT)
Date: Tue, 28 Jul 2015 16:56:20 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150728155620.GA2284@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150728094643.GT14943@x1>
 <20150728110717.GH2492@codeblueprint.co.uk>
 <20150728113721.GU14943@x1>
 <20150728124338.GA2773@codeblueprint.co.uk>
 <20150728150021.GX14943@x1>
 <55B79D60.4080807@roeck-us.net>
 <20150728152832.GY14943@x1>
 <20150728154550.GB2773@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150728154550.GB2773@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 28 Jul 2015, Matt Fleming wrote:

> On Tue, 28 Jul, at 04:28:32PM, Lee Jones wrote:
> > On Tue, 28 Jul 2015, Guenter Roeck wrote:
> > 
> > > On 07/28/2015 08:00 AM, Lee Jones wrote:
> > > >On Tue, 28 Jul 2015, Matt Fleming wrote:
> > > >>On Tue, 28 Jul, at 12:37:21PM, Lee Jones wrote:
> > > >>>
> > > >>>The driver shouldn't be called that either.
> > > >>>
> > > >>>You are the only one.  What makes iTCO 'special'?
> > > >>
> > > >>I don't know, I didn't write it. It looks like Wim did ~9 years ago, so
> > > >>it must have made sense to him at the time.
> > > >>
> > > 
> > > Coding style wasn't as strict then as it is today. iTCO has just been kept
> > > for historic reasons.
> > 
> > For sure, I get that, but it doesn't mean we can't do-the-right-thing
> > (tm) now does it?
> > 
> > > Sure, we could have changed it to lowercase, but so far no one bothered.
> > > Plus, of course, there is always the element that some maintainers hate
> > > that kind of cleanup,
> > 
> > Really?
> 
> Yes, really. 

Well then they are silly (replace silly with something less ML
friendly if you like).

> > Surely any kind of clean-up is good clean-up.  Especially as Greg KH
> > et. al, have been doing public presentations telling everyone that
> > there is always kernel work for anyone who has the time; spelling
> > corrections and all.
>  
> That's what staging/ was invented for ;-) Greg is quite happy to take
> those patches, other maintainers are less so.

No, staging was designed to take drivers which are either
controversial or still in a state of flux.  Not to over-rule
maintainers which didn't think a clean-up was important enough for
acceptance.

> > Either do the 5min clean-up or don't, no biggy.  If you don't then I
> > can do it.
> 
> Go for it.
> 
> > At the very least please don't add any _new_ camel case variables or
> > filenames.
> 
> OK, sure.

Great.  Resubmit when ready.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
