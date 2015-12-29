Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46597 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752948AbbL2QhJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Dec 2015 11:37:09 -0500
Date: Tue, 29 Dec 2015 17:37:05 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-watchdog@vger.kernel.org, Fu Wei <fu.wei@linaro.org>
Subject: Re: Additional patches in my watchdog-next branch
Message-ID: <20151229173705.1596cf1d@free-electrons.com>
In-Reply-To: <20151229160411.GB30405@roeck-us.net>
References: <20151228152335.GA18627@roeck-us.net>
	<20151228152710.GA31482@spo001.leaseweb.nl>
	<20151228215709.GA30595@roeck-us.net>
	<20151228225427.GA2018@spo001.leaseweb.nl>
	<5681C2FE.7070100@mentor.com>
	<20151229071732.GA6292@spo001.leaseweb.nl>
	<20151229160411.GB30405@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

On Tue, 29 Dec 2015 08:04:11 -0800, Guenter Roeck wrote:
> Hi Wim,
> 
> On Tue, Dec 29, 2015 at 08:17:32AM +0100, Wim Van Sebroeck wrote:
> [ ... ]
> > 
> > SBSA: What should be done is to create a correct driver without pretimeout and with just the normal watchdog (=reboot if we aren't kicked fast enough) behaviour and get that in.
> > 
> Absoutely agree.

Sorry to get into the conversation, but I got interested into the SBSA
watchdog driver recently, and looked at the status of its merge in the
kernel.

I've looked at Fu Wei's v9 from November which I believe is the latest
version, and then looked at Vladimir's generic pretimeout patch set.

Vladimir, do you plan to rework the SBSA watchdog driver on top of your
pretimeout patch series ? Or do Fu Wei intends do it ? Alternatively,
as suggested by Wim and Guenter, submitting an initial version without
pretimeout support would be a good thing. Are you, or Fu, interested in
doing this, or should I work at updating Fu's patches in this
direction ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
