Return-Path: <SRS0=spCl=S5=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C44FC43219
	for <linux-watchdog@archiver.kernel.org>; Sat, 27 Apr 2019 10:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E40208CB
	for <linux-watchdog@archiver.kernel.org>; Sat, 27 Apr 2019 10:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="Aae5tvZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbfD0Kb7 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:31:59 -0400
Received: from www.linux-watchdog.org ([185.87.125.42]:59250 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfD0Kb7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 27 Apr 2019 06:31:59 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Apr 2019 06:31:58 EDT
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 2F2E640897; Sat, 27 Apr 2019 11:48:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 2F2E640897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1556358514;
        bh=MRZSf2XrVKE+kaL732ODcIsVjbqd4G352HK7JSO/jzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aae5tvZ83NGZw2CLNidwd42SSK5g1qpv3dWTGN5Evi9Ae/9NEwOZlooIAkcvsqudl
         /JYJ8vACZCSqycDp//CntRh+vScMGWeV0LAU7lNIydzZTFQ2QIKnRI+HfgPOv1GsJG
         FHsDa7zijT4FfTLGvJwbOCHOIuOa90TfreEosRNI=
Date:   Sat, 27 Apr 2019 11:48:34 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/5] watchdog: watchdog_core: make it explicitly
 non-modular
Message-ID: <20190427094833.GA32761@www.linux-watchdog.org>
References: <1556034515-28792-1-git-send-email-paul.gortmaker@windriver.com>
 <1556034515-28792-3-git-send-email-paul.gortmaker@windriver.com>
 <439d89d7-bae6-c5c8-e9bf-5477304bc065@roeck-us.net>
 <20190424153700.GT23044@windriver.com>
 <20190424210530.GA29993@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424210530.GA29993@roeck-us.net>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi All,

> On Wed, Apr 24, 2019 at 11:37:00AM -0400, Paul Gortmaker wrote:
> > [Re: [PATCH 2/5] watchdog: watchdog_core: make it explicitly non-modular] On 23/04/2019 (Tue 18:22) Guenter Roeck wrote:
> > 
> > > On 4/23/19 8:48 AM, Paul Gortmaker wrote:
> > > >The Kconfig currently controlling compilation of this code is:
> > > >
> > > >config WATCHDOG_CORE
> > > >        bool "WatchDog Timer Driver Core"
> > > >
> > > >...meaning that it currently is not being built as a module by anyone.
> > > >
> > > >Lets remove the modular code that is essentially orphaned, so that
> > > >when reading the driver there is no doubt it is builtin-only.
> > > >
> > > >We replace module.h with export.h since the file does export some
> > > >symbols.  We don't add init.h since the file already has that.
> > > >
> > > >We also delete the MODULE_LICENSE tag etc. since all that information
> > > >is already contained at the top of the file in the comments.
> > > >
> > > 
> > > I must admit that I am not at all happy about this change. While not
> > > configurable by default, I used tristate a lot (after enabling it
> > > manually) to test watchdog core code while changing it. It saves a
> > > lot of time to be able to reload the watchdog core without having
> > > to reboot the entire system after each change. Removing the ability
> > 
> > I'm confused.  If it is useful, then why not formally make it tristate
> > so other people can do the same as you do, and nobody is manually making
> > the change over and over again each time?  I'd support that update.
> > 
> No idea. That precedes my involvement in the watchdog subsystem.
> Let's wait for input from Wim. I have a set of patches ready, but it
> doesn't make sense to me to submit them if Wim wants to go the non-modular
> route.
> 
> FWIW, I am fine with the other patches except for the npcm patch, because
> several of the other npcm drivers are buildable as module.

In general: If systems/devices can't handle modules then we should indeed make sure that we clean it up.

For the watchdog core however, I am not in favour of doing that. I also use it as a module when i'm testing.
I originally wanted to make it tristate (so that it can be loaded as a module), but I didn't had a clean way for the following situation:
driver built as part of kernel, but watchdog system build as a module. We should imho avoid that.
So no for this peticular patch and Guenter you can o ahead with another patch to make it tristate.

Kind regards,
Wim.



