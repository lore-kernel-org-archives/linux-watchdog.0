Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53635 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752569Ab1BNUIH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Feb 2011 15:08:07 -0500
Date: Mon, 14 Feb 2011 12:07:31 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-watchdog@vger.kernel.org,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Ian Campbell <ian.campbell@citrix.com>,
	Jan Beulich <JBeulich@novell.com>
Subject: Re: [Xen-devel] [PATCH, resend] Xen watchdog driver
Message-Id: <20110214120731.d8344f68.akpm@linux-foundation.org>
In-Reply-To: <20110214145602.GA10300@dumpdata.com>
References: <4D41A088020000780002ED06@vpn.id2.novell.com>
	<20110214145602.GA10300@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 14 Feb 2011 09:56:02 -0500
Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> On Thu, Jan 27, 2011 at 03:42:48PM +0000, Jan Beulich wrote:
> > While the hypervisor change adding SCHEDOP_watchdog support included a
> > daemon to make use of the new functionality, having a kernel driver
> > for /dev/watchdog so that user space code doesn't need to distinguish
> > non-Xen and Xen seems to be preferable.
> 
> Hey Andrew,
> I was wondering if you could help us out. Jan posted this patch
> way back in Sep, then again in Oct on the xen-watchdog mailing list
> with with no responses except Ian's Ack and my Reviewed-by. Would you
> be OK taking this patch under your wing or do you think I ought to
> send a git pull to Linus during the 2.6.39 merge window directly?

Ordinarily Wim would take care of this - perhaps he's busy.

Please refresh, retest and resend.  cc myself, wim, linux-watchdog and
linux-kernel and we'll take care of it, thanks.

