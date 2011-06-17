Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:37778 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757162Ab1FQHRn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Jun 2011 03:17:43 -0400
Date: Fri, 17 Jun 2011 09:17:41 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Peter Fordham <peter.fordham@gmail.com>
Cc: Jamie Iles <jamie@jamieiles.com>,
	linux-arm-kernel@lists.infradead.org,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [MPCore Watchdog]: Convert from misc_dev to dynamic device
	node.
Message-ID: <20110617071741.GL23305@infomag.iguana.be>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com> <20110614234858.GA15534@gallagher> <BANLkTik02nt4ttTTS-3u5R_ZH0W90FADJQ@mail.gmail.com> <20110615085820.GH3075@pulham.picochip.com> <BANLkTinY8bM0PyLLcu6icEsWT=X=KVV3DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTinY8bM0PyLLcu6icEsWT=X=KVV3DQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

> > I've added Wim (watchdog driver maintainer), but I would think that if
> > this change is worth doing then it should be done for all drivers.
> 
> Agreed, but today this may be more work than I'm strictly interested in
> doing. If we do decide it's the right thing then I'll look into converting the
> other drivers later.

No, we need to do it by first converting all drivers to the new API and then a
change of the API will take care of it.

Kind regards,
Wim.

