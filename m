Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:39390 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751510Ab3J2Ioh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Oct 2013 04:44:37 -0400
Date: Tue, 29 Oct 2013 09:44:33 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Johannes Thumshirn <johannes.thumshirn@men.de>,
	linux-watchdog@vger.kernel.org
Subject: Re: [GIT PULL v2] watchdog updates for Linux 3.13
Message-ID: <20131029084433.GM19704@spo001.leaseweb.com>
References: <20131023003541.GA2435@roeck-us.net> <20131023065759.GA24193@jtlinux> <52685623.3040108@roeck-us.net> <20131024062211.GA6657@jtlinux> <20131024151749.GA25355@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131024151749.GA25355@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> On Thu, Oct 24, 2013 at 08:22:11AM +0200, Johannes Thumshirn wrote:
> > On Wed, Oct 23, 2013 at 04:05:07PM -0700, Guenter Roeck wrote:
> > > On 10/22/2013 11:57 PM, Johannes Thumshirn wrote:
> > > >On Tue, Oct 22, 2013 at 05:35:41PM -0700, Guenter Roeck wrote:
> > > >>* PGP Signed by an unknown key
> > > >>
> > > >>Hi Wim,
> > > >>
> > > >>This is v2 of my pull request. Please ignore the previous request.
> > > >>There are a couple of changes as outlined below, and I rebased the
> > > >>branch to 3.12-rc6.
> > > >>
> > > >>Please consider pulling watchdog updates for Linux 3.13 from signed tag:
> > > >>
> > > >>     git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-wim
> > > >>
> > > >>The tag has been applied on top of the watchdog-next branch. The branch includes
> > > >>a number of patches I collected over the last few months. It does not include
> > > >>all submitted patches; only the ones I reviewed and felt comfortable with are
> > > >>included.
> > > >>
> > > >>I reviewed all patches and ran build tests as well as source verification tests
> > > >>with both smatch and spatch. The branch has been on my Linux repo for a while,
> > > >>so presumably Fenguang's robot will have built the code as well.
> > > >>The w83627hf patches have been running on several servers for more than a month
> > > >>without problems.
> > > >>
> > > >>You can find the most recent build results at
> > > >>http://server.roeck-us.net:8010/builders/watchdog-next.
> > > >>
> > > >>If you don't want to apply the entire series, please consider applying whatever
> > > >>subset you might feel comfortable with.
> > > >>
> > > >>Thanks,
> > > >>Guenter
> > > >>
> > > >>------
> > > >
> > > >Hi Gunther,
> > > >
> > > >Can you please drop the patch from me from the pull request?  I'm afraid
> > > >something went wrong there, I thought Stephen Warren and I decided to just move
> > > >the binding document and not change the bindings, as the driver went upstream in
> > > >3.11.
> > > >
> > >
> > > Your original patch is at https://lkml.org/lkml/2013/8/21/251.
> > > Do you want that version applied, with Stephen's Ack ?
> > >
> > 
> >  If you could do that, that would be great. If not I'll resend it.
> > 
> Ok, I applied it to the watchdog-next branch of my repository on
> kernel.org (on top of v2 and its revert).
> 
> Wim, please let me know how you want to handle it from there. You can pick
> it up from there (or direcetly from lkml), I could send you yet another pull
> request of the current branch, or I could rebase the branch again, drop v2
> of the patch and its revert, and send you a pull request of the result.
> Or do nothing, of course.

I added the old patch to linux-watchdog-next. So you don't need to do anything anymore.

Kind regards,
Wim.

