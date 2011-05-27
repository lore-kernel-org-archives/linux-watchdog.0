Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:54841 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758313Ab1E0Iis (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 May 2011 04:38:48 -0400
Date: Fri, 27 May 2011 10:38:46 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCHv6] watchdog: add support for the Synopsys DesignWare WDT
Message-ID: <20110527083846.GJ17887@infomag.iguana.be>
References: <1295871552-22254-1-git-send-email-jamie@jamieiles.com> <20110526133854.GE2577@pulham.picochip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110526133854.GE2577@pulham.picochip.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jamie,

> > The Synopsys DesignWare watchdog is found in several ARM based systems
> > and provides a choice of 16 timeout periods depending on the clock
> > input.  The watchdog cannot be disabled once started.
> > 
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> 
> Apologies for not chasing this sooner, is this driver OK to be applied?  
> This should apply cleanly onto 2.6.39.

Yes it is. It's in linux-2.6-watchdog-next now.

Kind regards,
Wim.

