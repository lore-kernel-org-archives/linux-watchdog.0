Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46721 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbbEAR71 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 May 2015 13:59:27 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YoFDi-000PP5-0M
	for linux-watchdog@vger.kernel.org; Fri, 01 May 2015 17:59:26 +0000
Date: Fri, 1 May 2015 10:59:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Timur Tabi <timur@codeaurora.org>
Cc: linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
Message-ID: <20150501175923.GC7712@roeck-us.net>
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org>
 <5542F33D.2020206@roeck-us.net>
 <5543A6E9.1090203@codeaurora.org>
 <5543B7D0.706@codeaurora.org>
 <20150501173209.GA7712@roeck-us.net>
 <5543BAE7.5040909@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5543BAE7.5040909@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 01, 2015 at 12:41:59PM -0500, Timur Tabi wrote:
> On 05/01/2015 12:32 PM, Guenter Roeck wrote:
> >devm_ioremap_resource already prints a message. For this reason, elsewhere in the
> >kernel the check for !res before calling devm_ioremap_resource is being removed,
> >leaving the error handling to devm_ioremap_resource. I would suggest to do the
> >same here.
> 
> I see what you're saying, but I leave the error handling to
> devm_ioremap_resource(), then no one will know whether it's because the
> control address or the refresh address is missing.  The user will just see
> "invalid resource" and won't what resource is actually invalid.
> 

You are saying that pretty much everyone in the kernel is, in your opinion,
doing the Wrong Thing (tm) and you insist in doing it differently.

As maintainer, I have seen lots of patches which remove this very same error
checking as unnecessary. If we accept your code, we can be all but sure to
see such a patch at some point, probably right after your patch was accepted
and shows up in linux-next. So besides arguing about something we should not
have to argue about in the first place, you are trying to create even more
maintainer work going forward.

Is that really neceessary ?

And then people wonder why maintainers sometimes get grumpy :-(.

Guenter
