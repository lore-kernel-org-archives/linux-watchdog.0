Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:16426 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751398Ab1BNUIo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Feb 2011 15:08:44 -0500
Date: Mon, 14 Feb 2011 21:08:37 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-watchdog@vger.kernel.org,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Ian Campbell <ian.campbell@citrix.com>,
	Jan Beulich <JBeulich@novell.com>
Subject: Re: [Xen-devel] [PATCH, resend] Xen watchdog driver
Message-ID: <20110214200837.GB3790@infomag.iguana.be>
References: <4D41A088020000780002ED06@vpn.id2.novell.com> <20110214145602.GA10300@dumpdata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110214145602.GA10300@dumpdata.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

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
I
'm completing review of 2 other drivers first.
Then I will review this one and add it to linux-2.5-watchdog-next for broader testing.

Kind regards,
Wim.

