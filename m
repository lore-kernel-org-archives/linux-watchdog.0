Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:44373 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751869Ab2CUTHh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Mar 2012 15:07:37 -0400
Date: Wed, 21 Mar 2012 20:07:19 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jan Beulich <JBeulich@suse.com>,
	Ian Campbell <ian.campbell@citrix.com>,
	Wouter de Geus <benv-xensource.com@junerules.com>,
	xen-devel <xen-devel@lists.xen.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog/xen: don't unconditionally enable the watchdog during resume
Message-ID: <20120321190719.GP10698@spo001.leaseweb.com>
References: <4F670AC9020000780007934F@nat28.tlf.novell.com> <20120321172332.GA5923@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120321172332.GA5923@phenom.dumpdata.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Konrad,

> On Mon, Mar 19, 2012 at 09:30:33AM +0000, Jan Beulich wrote:
> > This was found to be a problem particularly after guest migration.
> > 
> > Signed-off-by: Jan Beulich <jbeulich@suse.com>
> > Reported-by: Wouter de Geus <benv-xensource.com@junerules.com>
> > Reported-by: Ian Campbell <Ian.Campbell@citrix.com>
> > Tested-by: Wouter de Geus <benv-xensource.com@junerules.com>
> 
> Looks good to me.
> 
> Wim, would you like me to carry it for 3.4 or are you OK doing it?

I will carry both fixes in the watchdog tree.

Kind regards,
Wim.

