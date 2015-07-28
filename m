Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36596 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932625AbbG1PAc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 11:00:32 -0400
Received: by wicgb10 with SMTP id gb10so160803094wic.1
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 08:00:30 -0700 (PDT)
Date: Tue, 28 Jul 2015 16:00:21 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
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
Message-ID: <20150728150021.GX14943@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150728094643.GT14943@x1>
 <20150728110717.GH2492@codeblueprint.co.uk>
 <20150728113721.GU14943@x1>
 <20150728124338.GA2773@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150728124338.GA2773@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 28 Jul 2015, Matt Fleming wrote:
> On Tue, 28 Jul, at 12:37:21PM, Lee Jones wrote:
> > 
> > The driver shouldn't be called that either.
> > 
> > You are the only one.  What makes iTCO 'special'?
> 
> I don't know, I didn't write it. It looks like Wim did ~9 years ago, so
> it must have made sense to him at the time.
> 
> > > > > +	info = &lpc_chipset_info[priv->chipset];
> > > > > +
> > > > > +	pdata->iTCO_version = info->iTCO_version;
> > > > 
> > > > Lowercase please.
> > > 
> > > Hmm... but then this line will read,
> > > 
> > > 	pdata->itco_version = info->iTCO_version;
> > > 
> > > I'm not sure that's an improvement.
> > 
> > Please consider making all of the variable names conform to the
> > coding standards we normally abide by.  You can submit it either as
> > patch 1 of this set, or independently.
> 
> Right, I figured we were fast approaching this rabit hole.

No rabbit hole, just some fixups.  If it takes you any more than 10
mins, I'd be surprised.

Let me know if you think it'll be too much trouble and I'll do the
fixups myself.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
