Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37665 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbbG1Mnl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 08:43:41 -0400
Received: by wibud3 with SMTP id ud3so157654446wib.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 05:43:40 -0700 (PDT)
Date: Tue, 28 Jul 2015 13:43:38 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Lee Jones <lee.jones@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
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
Message-ID: <20150728124338.GA2773@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150728094643.GT14943@x1>
 <20150728110717.GH2492@codeblueprint.co.uk>
 <20150728113721.GU14943@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150728113721.GU14943@x1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 28 Jul, at 12:37:21PM, Lee Jones wrote:
> 
> The driver shouldn't be called that either.
> 
> You are the only one.  What makes iTCO 'special'?

I don't know, I didn't write it. It looks like Wim did ~9 years ago, so
it must have made sense to him at the time.

> > > > +	info = &lpc_chipset_info[priv->chipset];
> > > > +
> > > > +	pdata->iTCO_version = info->iTCO_version;
> > > 
> > > Lowercase please.
> > 
> > Hmm... but then this line will read,
> > 
> > 	pdata->itco_version = info->iTCO_version;
> > 
> > I'm not sure that's an improvement.
> 
> Please consider making all of the variable names conform to the
> coding standards we normally abide by.  You can submit it either as
> patch 1 of this set, or independently.

Right, I figured we were fast approaching this rabit hole.
 
-- 
Matt Fleming, Intel Open Source Technology Center
