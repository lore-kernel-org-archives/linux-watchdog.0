Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:6019 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754527Ab1C3Rfe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Mar 2011 13:35:34 -0400
Date: Wed, 30 Mar 2011 19:35:32 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] mpc8xxx_wdt: fix build
Message-ID: <20110330173532.GB3816@infomag.iguana.be>
References: <1301492902-12343-1-git-send-email-jacmet@sunsite.dk> <20110330143507.GC13685@ponder.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110330143507.GC13685@ponder.secretlab.ca>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Peter, Grant,

> On Wed, Mar 30, 2011 at 03:48:22PM +0200, Peter Korsgaard wrote:
> > Since 1c48a5c93da6313 (dt: Eliminate of_platform_{,un}register_driver)
> > mpc8xxx_wdt no longer builds as it tries to refer to a 'match' variable
> > rather than ofdev->dev.of_match that it checks just before.
> > 
> > Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

I added it to linux-2.6-watchdog-next.
it will go upstream after the weekend.

Kind regards,
Wim.

