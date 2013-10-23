Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:55719 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab3JWQro (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Oct 2013 12:47:44 -0400
Received: by mail-pb0-f42.google.com with SMTP id jt11so1011805pbb.1
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Oct 2013 09:47:44 -0700 (PDT)
Date: Wed, 23 Oct 2013 09:47:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [GIT PULL v2] watchdog updates for Linux 3.13
Message-ID: <20131023164736.GA22394@roeck-us.net>
References: <20131023003541.GA2435@roeck-us.net>
 <20131023065759.GA24193@jtlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131023065759.GA24193@jtlinux>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 23, 2013 at 08:57:59AM +0200, Johannes Thumshirn wrote:
> On Tue, Oct 22, 2013 at 05:35:41PM -0700, Guenter Roeck wrote:
> > * PGP Signed by an unknown key
> >
> > Hi Wim,
> >
> > This is v2 of my pull request. Please ignore the previous request.
> > There are a couple of changes as outlined below, and I rebased the
> > branch to 3.12-rc6.
> >
> > Please consider pulling watchdog updates for Linux 3.13 from signed tag:
> >
> >     git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-wim
> >
> > The tag has been applied on top of the watchdog-next branch. The branch includes
> > a number of patches I collected over the last few months. It does not include
> > all submitted patches; only the ones I reviewed and felt comfortable with are
> > included.
> >
> > I reviewed all patches and ran build tests as well as source verification tests
> > with both smatch and spatch. The branch has been on my Linux repo for a while,
> > so presumably Fenguang's robot will have built the code as well.
> > The w83627hf patches have been running on several servers for more than a month
> > without problems.
> >
> > You can find the most recent build results at
> > http://server.roeck-us.net:8010/builders/watchdog-next.
> >
> > If you don't want to apply the entire series, please consider applying whatever
> > subset you might feel comfortable with.
> >
> > Thanks,
> > Guenter
> >
> > ------
> 
> Hi Gunther,
> 
> Can you please drop the patch from me from the pull request?  I'm afraid
> something went wrong there, I thought Stephen Warren and I decided to just move
> the binding document and not change the bindings, as the driver went upstream in
> 3.11.
> 
I ended up reverting your patch on top of my tree. Wim can either do the same
if/when he decides to pull the patches, or simply drop the patch before sending
his next pull request to Linus.

Thanks,
Guenter
