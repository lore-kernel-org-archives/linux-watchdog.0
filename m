Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40097 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755056Ab1KVTXO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Nov 2011 14:23:14 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6C03120A70
	for <linux-watchdog@vger.kernel.org>; Tue, 22 Nov 2011 14:23:13 -0500 (EST)
Date: Tue, 22 Nov 2011 11:20:30 -0800
From: Greg KH <greg@kroah.com>
To: Alessandro Rubini <rubini@unipv.it>
Cc: dave.martin@linaro.org, linux@arm.linux.org.uk, patches@linaro.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	alan@linux.intel.com, a.zummo@towertech.it,
	alsa-devel@alsa-project.org, cjb@laptop.org,
	dan.j.williams@intel.com, dmitry.torokhov@gmail.com,
	grant.likely@secretlab.ca, perex@perex.cz,
	jassisinghbrar@gmail.com, julia@diku.dk, linus.walleij@linaro.org,
	linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org, lethal@linux-sh.org,
	Pawel.Moll@arm.com, rtc-linux@googlegroups.com,
	spi-devel-general@lists.sourceforge.net, tiwai@suse.de,
	vinod.koul@intel.com, wim@iguana.be
Subject: Re: [GIT PULL] ARM: amba: Enable module alias autogeneration for
 AMBA drivers
Message-ID: <20111122192030.GA4930@kroah.com>
References: <1321961573-4562-1-git-send-email-dave.martin@linaro.org>
 <20111122115632.GA5165@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111122115632.GA5165@mail.gnudd.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Nov 22, 2011 at 12:56:32PM +0100, Alessandro Rubini wrote:
> > I have Acks on some of the driver patches and no comments on the
> > rest.  I've been circulating these for some time, so if you're
> > happy to pull those driver patches via your tree, please go ahead.
> 
> Sure I have no problem with the nomadik-rng.c, (so please have my
> Acked-by: -- sorry for not noting it earlier) but I think this
> file2alias thing needs a serious rework to split each bus in a
> different file, using ELF sections like we do elsewhere.
> 
> I posted a patch last week but I got no comment at all. Maybe this
> is the time to ask for comments? I can rebase and repost if needed.
> 
>   lkml.org/lkml/2011/11/4/125 (0/2: description of the work)
>   lkml.org/lkml/2011/11/4/126 (1/2: turn the if plethora to table lookup)
>   lkml.org/lkml/2011/11/4/127 (2/2: partial split to type-specific files).

Ah, I missed that, yes, this would be a good thing to have, we've been
wanting it for _years_.

greg k-h
