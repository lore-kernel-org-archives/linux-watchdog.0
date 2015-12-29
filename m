Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58964 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbbL2QEM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Dec 2015 11:04:12 -0500
Date: Tue, 29 Dec 2015 08:04:11 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: Additional patches in my watchdog-next branch
Message-ID: <20151229160411.GB30405@roeck-us.net>
References: <20151228152335.GA18627@roeck-us.net>
 <20151228152710.GA31482@spo001.leaseweb.nl>
 <20151228215709.GA30595@roeck-us.net>
 <20151228225427.GA2018@spo001.leaseweb.nl>
 <5681C2FE.7070100@mentor.com>
 <20151229071732.GA6292@spo001.leaseweb.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151229071732.GA6292@spo001.leaseweb.nl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On Tue, Dec 29, 2015 at 08:17:32AM +0100, Wim Van Sebroeck wrote:
[ ... ]
> 
> SBSA: What should be done is to create a correct driver without pretimeout and with just the normal watchdog (=reboot if we aren't kicked fast enough) behaviour and get that in.
> 
Absoutely agree.

Thanks,
Guenter
