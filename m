Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:32528 "EHLO
	mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755399Ab1GAIbY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 Jul 2011 04:31:24 -0400
Date: Fri, 1 Jul 2011 10:31:22 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-watchdog@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Jamie Iles <jamie@jamieiles.com>,
	Walter Goossens <waltergoossens@home.nl>,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	nios2-dev@sopc.et.ntust.edu.tw
Subject: Re: [PATCH v3 RESEND] watchdog: Add driver for Altera Watchdog
	Timer
Message-ID: <20110701083122.GA8678@infomag.iguana.be>
References: <1300461573-12268-1-git-send-email-tklauser@distanz.ch> <20110527082309.GB16394@infomag.iguana.be> <20110614134859.GP20966@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110614134859.GP20966@distanz.ch>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tobias,

> > I presume this will go in together with the other nios2 architecture patches?
> 
> It will probably take some time until we get to the point where we're
> ready to submit nios2 arch patches. We started out with individual
> drivers to get used to the submission and review process. Most of them
> got taken by the respective subsystem maintainers.
> 
> So if you want to take the driver through your tree, please go ahead.
> Otherwise I will resubmit it once we're ready to submit the nios2 arch.

Just let me know when you are ready to submit the nios2 arch and then I will do
the necessary on my side. In the mean time I will add your driver to the
linux-2.6-watchdog-next tree in some form, but I might convert the driver first
to the generic watchdog framework.

Kind regards,
Wim.

